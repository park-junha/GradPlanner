class scuClass:
    # NEED TO MAKE SAT A LIST, NOT A SINGLE VARIABLE
    def __init__(self, cID = "", name = "", sat = None, quart = "", creds = 0, isCore = False, isRequired = True):
        self.classInfo = {'classID': cID, 'fullName': name, 'quarters': quart, 'credits': creds, 'isCore': isCore, 'isRequired': isRequired}
        self.preReqs = []
        if sat is None:
            self.satisfies = []
        else:
            self.satisfies = [sat]

    def pushPreReq(self, cID):
        self.preReqs.append(cID)

    # Takes another scuObject with same cID as input and combines satisfies
    # Doesn't check for duplicates
    def doubleDip(self, obj):
        self.satisfies.extend(obj.satisfies)

    # What is q? How does this logic work?
    def available(self, q, year):
        quartersOffered = self.classInfo['quarters']
        if (year % 2 == 0) and ('O' not in quartersOffered):
            if quartersOffered.find(q[0]) is not -1:
                return True
        elif (year % 2 == 1) and ('E' not in quartersOffered):
            if quartersOffered.find(q[0]) is not -1:
                return True
        return False

class FourYearPlan:
    # All constructor arguments are hash maps except for creditsAlreadyDone
    def __init__(self, required, notRequired, creditsAlreadyDone, major):
        self.metadata = {'required': required, 'notRequired': notRequired, 'doneClasses': [], 'credits': creditsAlreadyDone, 'major': major}
        self.preferences = {'maxClassCount': 4, 'maxMajorClasses': 2, 'maxCoreClasses': 2}
        self.minUnits = 12

    def completeClass(self, cID):
        if cID in self.metadata['required']:
            self.metadata['doneClasses'].append(cID)
            self.metadata['credits'] += self.metadata['required'][cID].classInfo['credits']
        elif cID in self.metadata['notRequired']:
            self.metadata['doneClasses'].append(cID)
            self.metadata['credits'] += self.metadata['notRequired'][cID].classInfo['credits']

    def getClass(self, cID): # scuClass return value
        if cID in self.metadata['required']:
            return self.metadata['required'][cID]

    def getNotRequiredClass(self, cID): # scuClass return value
        if cID in self.metadata['notRequired']:
            return self.metadata['notRequired'][cID]

    def feasible(self, cID, quarter, year):
        if cID in self.metadata['doneClasses']:
            return False
        if any(prereq not in self.metadata['doneClasses'] for prereq in self.getClass(cID).preReqs):
            return False
        # If fall, pass year as argument
        # If not, pass year-1
        # scuClass.available() takes school year's beginning year as argument
        # But year is the actual year, not school year
        # This is a workaround solution
        if quarter is 'F':
            return self.getClass(cID).available(quarter, year)
        else:
            return self.getClass(cID).available(quarter, year-1)

    def feasibleNotRequired(self, cID, quarter, year):
        if cID in self.metadata['doneClasses']:
            return False
        if any(prereq not in self.metadata['doneClasses'] for prereq in self.getNotRequiredClass(cID).preReqs):
            return False
        return self.getNotRequiredClass(cID).available(quarter, year)

    def planComplete(self):
        if self.metadata['credits'] < 175:
            return False
        for cID in self.metadata['required']:
            if cID not in self.metadata['doneClasses']:
                return False
        return True

    def preferenceMet(self, quarterMap, satisfiesKey):
        keyMap = {'classCount': 'maxClassCount', 'majorClasses': 'maxMajorClasses', 'coreClasses': 'maxCoreClasses'}
        if quarterMap[satisfiesKey] >= self.preferences[keyMap[satisfiesKey]]:
            return False
        return True

    def allPreferencesMet(self, quarterMap):
        keyMap = {'classCount': 'maxClassCount', 'majorClasses': 'maxMajorClasses', 'coreClasses': 'maxCoreClasses'}
        for key, value in keyMap.items():
            if quarterMap[key] < self.preferences[value]:
                return False
        return True

    def buildPlan(self, year, startQuarter):
        plan = []
        currentYear = 0
        terms = ['Fall', 'Winter', 'Spring']
        warning = None

        # Set quarter based on startQuarter argument
        try:
            quarter = terms.index(startQuarter)
        # Default to Fall if startQuarter is invalid
        except:
            print("startQuarter:", startQuarter, "is not valid. Defaulting to Fall.")
            quarter = 0

        # Set academic year (weird implementation)
        if quarter == 0:
            academicYear = str(year) + '-' + str(year + 1)
        else:
            academicYear = str(year-1) + '-' + str(year)

        # Create a starting academic year in plan
        plan.append({'year': academicYear, 'yearSchedule': []})

        # Fill in empty quarters of the year if starting Winter or Spring
        for emptyQuarter in range(quarter):
            plan[currentYear]['yearSchedule'].append({'quarter': terms[emptyQuarter], 'classes': []})

        while not self.planComplete():
            # Create a new academic year in the plan when starting in Fall
            if quarter % 3 == 0 and quarter > 0:
                quarter = 0
                currentYear += 1
                academicYear = str(year) + '-' + str(year + 1)
                plan.append({'year': academicYear, 'yearSchedule': []})

            # Initialize list of enrolled classes for the quarter
            enrolledClasses = []

            # Initialize quarter object for the current quarter of the plan
            plan[currentYear]['yearSchedule'].append({'quarter': terms[quarter], 'classes': []})

            # Hashmap for keeping track of how many classes enrolled for the quarter, separated by category
            quarterMap = {'classCount': 0, 'majorClasses': 0, 'coreClasses': 0}

            # Key-value pairs of what the class satisfies and the corresponding quarterMap key
            satisfiesMap = {self.metadata['major']: 'majorClasses', 'Core': 'coreClasses', 'Unit Requirement': 'coreClasses', 'Highly Recommended': 'majorClasses'}

            # List of all core requirements
            # HARD CODED -- might want to change to fetching data from database
            coreRequisites = ["CTW 1", "CTW 2", "Mathematics Core", "Culture and Ideas 1", "Culture and Ideas 2", "Diversity", "RTC 1", "RTC 2", "Social Science", "Natural Science", "Language 1", "Language 2", "Advanced Writing", "Civic Engagement", "Ethics", "Culture and Ideas 3", "ELSJ", "RTC 3", "Arts", "Science, Technology, and Society"]

            # Add each core requisite as a key with value coreClasses to satisfiesMap
            for coreRequisite in coreRequisites:
                satisfiesMap[coreRequisite] = 'coreClasses'

            unitsInQuarter = 0

            # Go through all requisites to graduate
            for cID in self.metadata['required']:
                # Only stores first element from satisfies member of scuClass
                satisfies = self.metadata['required'][cID].satisfies[0]

                # Add class to plan if feasible and user preferences are met
                if self.feasible(cID, terms[quarter][0], year) and self.preferenceMet(quarterMap, satisfiesMap[satisfies]):
                    # Get pre-requisites of the class
                    prereqs = self.metadata['required'][cID].preReqs
                    if not prereqs:
                        prereqs = None
                    # Append the class
                    plan[currentYear]['yearSchedule'][quarter]['classes'].append({'name': cID, 'prereqs': prereqs, 'units': self.metadata['required'][cID].classInfo['credits'], 'satisfies': self.metadata['required'][cID].satisfies, 'isCore': self.metadata['required'][cID].classInfo['isCore']})
                    # Add the class to the list of enrolled classes
                    enrolledClasses.append(cID)
                    # Increment number of classes enrolled in the quarter
                    quarterMap['classCount'] += 1
                    unitsInQuarter += self.metadata['required'][cID].classInfo['credits']
                    # Increment majorClasses or coreClasses in quarterMap, depending on which of those categories the class falls under
                    if satisfies in satisfiesMap:
                        quarterMap[satisfiesMap[satisfies]] += 1
                # Break out of the for loop if all preferences for the quarter are met
                if self.allPreferencesMet(quarterMap):
                    break

            # Iterate through the non-required classes if fewer than minimum units per quarter are scheduled
            while unitsInQuarter < self.minUnits:
                # Go through all requisites to graduate
                for cID in self.metadata['notRequired']:
                    # Stop appending classes if more than minimum units per quarter
                    if unitsInQuarter >= self.minUnits:
                        break

                    # Only stores first element from satisfies member of scuClass
                    satisfies = self.metadata['notRequired'][cID].satisfies[0]

                    # Add class to plan if feasible and user preferences are met
                    if self.feasibleNotRequired(cID, terms[quarter][0], year):
                        # Get pre-requisites of the class
                        prereqs = self.metadata['notRequired'][cID].preReqs
                        if not prereqs:
                            prereqs = None
                        # Append the class
                        plan[currentYear]['yearSchedule'][quarter]['classes'].append({'name': cID, 'prereqs': prereqs, 'units': self.metadata['notRequired'][cID].classInfo['credits'], 'satisfies': self.metadata['notRequired'][cID].satisfies, 'isCore': self.metadata['notRequired'][cID].classInfo['isCore']})
                        # Add the class to the list of enrolled classes
                        enrolledClasses.append(cID)
                        # Increment number of classes enrolled in the quarter
                        quarterMap['classCount'] += 1
                        unitsInQuarter += self.metadata['notRequired'][cID].classInfo['credits']
                        # Increment majorClasses or coreClasses in quarterMap, depending on which of those categories the class falls under
                        if satisfies in satisfiesMap:
                            quarterMap[satisfiesMap[satisfies]] += 1
                # If still less than minimum units per quarter, throw a warning
                if unitsInQuarter < self.minUnits:
                    warning = "WARNING: Could not schedule " + str(self.minUnits) + " units per quarter"
                    print(warning)
                    break

            # Mark all enrolled classes for the quarter as complete
            for cID in enrolledClasses:
                self.completeClass(cID)
            if currentYear > 10:
                print("Cannot build plan. Exiting program.")
                raise Exception("Cannot build plan within 10 years.")
            # Increment quarter by 1
            quarter += 1
            # Increment the year if Winter
            if quarter % 3 == 1:
                year += 1

        # Fill in the remainder of the academic year with empty quarters
        for emptyQuarter in range(quarter, len(terms)):
            plan[currentYear]['yearSchedule'].append({'quarter': terms[emptyQuarter], 'classes': []})
        return {'warning': warning, 'plan': plan}
