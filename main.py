from flask import Flask, render_template, request, redirect, url_for
import sys
import json
import random
import pymysql

app = Flask(__name__)

# Enable to print more info to console log
VERBOSE_MODE = False

if any(arg in ['-v', '--verbose'] for arg in sys.argv):
    VERBOSE_MODE = True

class scuClass:
    def __init__(self, cID = "", name = "", sat = "", quart = "", creds = 0):
        self.classInfo = {'classID': cID, 'fullName': name, 'satisfies': sat, 'quarters': quart, 'credits': creds}
        self.preReqs = []

    def pushPreReq(self, cID):
        if VERBOSE_MODE is True: print("scuClass.pushPreReq(): Appending " + cID + " as prereq to scuClass object")
        self.preReqs.append(cID)

    def getID(self):
        return self.classInfo['classID']

    def getName(self):
        return self.classInfo['fullName']

    def getSatisfies(self):
        return self.classInfo['satisfies']

    def getQuarters(self):
        return self.classInfo['quarters']

    def getCredits(self):
        return self.classInfo['credits']

    def getPrereqs(self):
        return self.preReqs

    def printDetails(self):
        print("Class ID:", self.getID())
        print("Name:", self.getName())
        print("Satisfies:", self.getSatisfies())
        print("Credits:", self.getCredits())
        offered = "Offered during "
        quartersMap = {'F': 'Fall ', 'W': 'Winter ', 'S': 'Spring ', 'E': 'Even school years (2020-21)', 'O': 'Odd school years (2019-2020)'}
        for key, value in quartersMap.items():
            if key in self.classInfo['quarters']:
                offered += value
        if all(key not in self.classInfo['quarters'] for key in ['E', 'O']):
            offered += "every year"
        print(offered)
        print("Prereqs:", self.getPrereqs())

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
    def __init__(self, required, creditsAlreadyDone, major):
        self.metadata = {'required': required, 'doneClasses': [], 'credits': creditsAlreadyDone, 'major': major}
        self.preferences = {'maxClassCount': 4, 'maxMajorClasses': 2, 'maxCoreClasses': 2}
        self.quarters = ["F","W","S","F","W","S","F","W","S","F","W","S"]

    def completeClass(self, cID):
        if cID in self.metadata['required']:
            self.metadata['doneClasses'].append(cID)
            self.metadata['credits'] += self.metadata['required'][cID].getCredits()
            if VERBOSE_MODE is True: print("Total credits completed:", self.metadata['credits'])

    def getClass(self, cID): # scuClass return value
        if cID in self.metadata['required']:
            return self.metadata['required'][cID]

    def feasible(self, cID, quarter, year):
        if VERBOSE_MODE is True: print("feasible(), cID:", cID)
        if VERBOSE_MODE is True: print("feasible(), quarter:", quarter)
        if VERBOSE_MODE is True: print("feasible(), year:", year)
        if VERBOSE_MODE is True: print("feasible(), self.metadata['doneClasses']:", self.metadata['doneClasses'])
        if VERBOSE_MODE is True: print("feasible(), self.getClass(cID).getPrereqs():", self.getClass(cID).getPrereqs())
        if cID in self.metadata['doneClasses']:
            if VERBOSE_MODE is True: print("feasible() return False because class is done")
            return False
        if any(prereq not in self.metadata['doneClasses'] for prereq in self.getClass(cID).getPrereqs()):
            if VERBOSE_MODE is True: print("feasible() return False because prereqs not met")
            return False
        if VERBOSE_MODE is True: print("feasible() return", self.getClass(cID).available(quarter, year))
        return self.getClass(cID).available(quarter, year)

    def planComplete(self):
        if self.metadata['credits'] < 175:
            if VERBOSE_MODE is True: print("planComplete() return False because credits:", self.metadata['credits'])
            return False
        for cID in self.metadata['required']:
            if cID not in self.metadata['doneClasses']:
                if VERBOSE_MODE is True: print("planComplete() return False because", cID, "not yet taken")
                return False
        if VERBOSE_MODE is True: print("planComplete() return True")
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

    def buildPlan(self, year):
        plan = []
        currentYear = -1
        quarter = -1
        terms = ['Fall', 'Winter', 'Spring']
        while not self.planComplete():
            quarter += 1
            if quarter % 3 == 0:
                quarter = 0
                currentYear += 1
                academicYear = str(year) + '-' + str(year + 1)
                if VERBOSE_MODE is True: print("buildPlan(), currentYear:", currentYear)
                if VERBOSE_MODE is True: print("buildPlan(), quarter:", quarter)
                if VERBOSE_MODE is True: print("buildPlan(), academicYear:", academicYear)
                plan.append({'year': academicYear, 'yearSchedule': []})
                if VERBOSE_MODE is True: print("Current plan:", plan)
            if quarter % 3 == 1:
                year += 1
            plan[currentYear]['yearSchedule'].append({'quarter': terms[quarter], 'classes': []})
            quarterMap = {'classCount': 0, 'majorClasses': 0, 'coreClasses': 0}
            satisfiesMap = {self.metadata['major']: 'majorClasses', 'Core': 'coreClasses', 'Unit Requirement': 'coreClasses'}
            for cID in self.metadata['required']:
                satisfies = self.metadata['required'][cID].getSatisfies()
                if self.feasible(cID, terms[quarter][0], year) and self.preferenceMet(quarterMap, satisfiesMap[satisfies]):
                    if VERBOSE_MODE is True: print("buildPlan(), appending", cID, "to plan")
                    prereqs = self.metadata['required'][cID].getPrereqs()
                    if not prereqs:
                        prereqs = None
                    plan[currentYear]['yearSchedule'][quarter]['classes'].append({'name': cID, 'prereqs': prereqs, 'units': self.metadata['required'][cID].getCredits()})
                    self.completeClass(cID)
                    quarterMap['classCount'] += 1
                    if satisfies in satisfiesMap:
                        quarterMap[satisfiesMap[satisfies]] += 1
                if self.allPreferencesMet(quarterMap):
                    break
            if VERBOSE_MODE is True: print("Current plan (end of while):", plan)
            if currentYear > 30:
                if VERBOSE_MODE is True: print("Cannot build plan. Exiting program.")
                sys.exit(1)
        if VERBOSE_MODE is True: print("buildPlan(): Plan complete!")
        return plan

def buildFourYearPlan(requiredMap, prevCompletedClassesMap, creditsCompleted, major):
    year = 2019
    fourYearPlan = FourYearPlan(requiredMap, creditsCompleted, major)
    for doneClass in prevCompletedClassesMap:
        fourYearPlan.completeClass(doneClass)
    return fourYearPlan.buildPlan(year)

def getJson(jsonFileName):
    with open(jsonFileName, 'r') as data_f:
        dictFromJson = json.load(data_f)
    return dictFromJson

# Replace dashes with spaces in major and emphasis and then concatenate them
def concatenateMajorAndEmphasis(major, emphasis):
    try:
        major = replaceDashesWithSpaces(major)
        emphasis = replaceDashesWithSpaces(emphasis)
        return major + ", " + emphasis + " Emphasis"
    except:
        raise TypeError("Major and emphasis could not be concatenated")

# Replace dashes with spaces in an item
def replaceDashesWithSpaces(item):
    try:
        return item.replace('-',' ')
    except:
        print("Dashes of item could not be replaced")
        return item

# Replace spaces with dashes in an item
def replaceSpacesWithDashes(item):
    try:
        return item.replace(' ','-')
    except:
        print("Spaces of item could not be replaced")
        return item

# Replace commas with periods in an item
def replaceCommasWithPeriods(item):
    try:
        return item.replace(',','.')
    except:
        print("Could not replace commas of item")
        return item

# Replace periods with commas in an item
def replacePeriodsWithCommas(item):
    try:
        return item.replace('.',',')
    except:
        print("Could not replace periods of item")
        return item

# Replace dashes with spaces in a list
def replaceDashesWithSpacesInList(itemList):
    try:
        returnList = []
        for item in itemList:
            returnList.append(replaceDashesWithSpaces(item))
        return returnList
    except:
        print("Could not replace dashes with spaces in list")
        return itemList

# Initialize Student INSERT SQL statement
def sqlToStudent(studentID, quartersCompleted, maxQuarters, maxUnits, majorAndEmphasis, classes):
    try:
        query = ["INSERT INTO Student (StudentID, QuartersCompleted, MaxQuarters, MaxUnits, MajorEmphasis) VALUES (" + str(studentID) + ", " + str(quartersCompleted) + ", " + str(maxQuarters) + ", " + str(maxUnits) + ", \'" + majorAndEmphasis + "\');"]
        numberOfClasses = len(classes)
        for classesIndex in range(numberOfClasses):
            value = "INSERT INTO CoursesTaken (CourseID, StudentID) VALUES (\'" + classes[classesIndex] + "\', " + str(studentID) + ");"
            query.append(value)
        return query
    except:
        raise Exception("Could not generate SQL INSERT INTO statements")

def initClassObj(queriedClass):
    try:
        classID = queriedClass[0]
        className = queriedClass[1]
        classSatisfies = queriedClass[2]
        quartersOffered = queriedClass[3]
        creditGiven = queriedClass[4]
        return scuClass(classID, className, classSatisfies, quartersOffered, creditGiven)
    except:
        print("Could not initialize scuClass object from query tuple")
        raise Exception("initClassObj(): Could not create scuClass object")

def queryPrereqs(queriedClass):
    try:
        classID = queriedClass[0]
        return "SELECT PreReqName from Prereqs where CourseID=\'" + classID + "\'"
    except:
        print("Could not generate prerequisites query for class")
        raise Exception("queryPrereqs(): Could not generate query")

def getMysqlConn():
    try:
        # MySQL database information
        MYSQLHOST = 'localhost'
        MYSQLUSER = 'root'
        MYSQLDB = 'PlanToGrad'
        MYSQLPW = None

        # MySQL connection
        print("Connecting to MySQL server...")
        conn = pymysql.connect( MYSQLHOST,
                                user=MYSQLUSER,
#                               port=MYSQLPORT,
                                passwd=MYSQLPW,
                                db=MYSQLDB)
        print("Connected to MySQL server successfully.")

        # MySQL cursor for executing queries
        cur = conn.cursor()
        print("Cursor initiated")
        return [conn, cur]
    except:
        raise Exception("Could not connect to MySQL server.")

# Query supported majors
def queryMajors():
    return "SELECT MajorName FROM MajornEmphasis WHERE MajorName != \'Core\';"

# Query requisites of major
def queryClasses(major):
    return "SELECT a.CourseID, CourseName, MajorName, QuarterOffered, CreditGiven FROM Classes AS a LEFT JOIN MajorReqs AS b ON a.CourseID = b.CourseID WHERE MajorName = \'" + major + "\';"

# Create HTML id element for a string
def createId(item):
    item_id = replaceCommasWithPeriods(item)
    item_id = replaceSpacesWithDashes(item_id)
    return item_id

# Translate HTML id element for a string
def translateId(item):
    item_id = replacePeriodsWithCommas(item)
    item_id = replaceDashesWithSpaces(item_id)
    return item_id

# Format queried majors to json
def jsonifyMajors(queriedMajors):
    majors = {"question": "Choose your major.", "options": [] }
    for major in queriedMajors:
        optionToAppend = {}
        majorName = major[0]
        optionToAppend["name"] = majorName
        optionToAppend["id"] = createId(majorName)
        majors["options"].append(optionToAppend)
    return majors

# Format queried classes to json
def jsonifyClasses(queriedClasses):
    classes = {"question": "Select all classes you've completed.", "options": [[],[],[]], "totalCredits": 0}
    columnCounter = 0
    for item in queriedClasses:
        optionToAppend = {}
        classId = item[0]
        optionToAppend["name"] = classId + ": " + item[1]
        optionToAppend["id"] = createId(classId)
        classes["options"][columnCounter].append(optionToAppend)
        columnCounter = (columnCounter + 1) % len(classes["options"])
        classes["totalCredits"] += item[4]
    return classes

# Build a four year plan
def createFourYearPlan(queriedClasses, allClassesTaken, major, cur):
    requiredMap = {}
    doneClassesMap = {}
    creditsCompleted = 0
    creditsInPlan = 0
    for aClass in queriedClasses:
        classID = aClass[0]
        if VERBOSE_MODE is True: print("Handling queried tuple:", aClass)
        creditGiven = aClass[4]
        creditsInPlan += creditGiven
        classObj = initClassObj(aClass)
        cur.execute(queryPrereqs(aClass))
        queriedPrereqs = cur.fetchall()
        for prereq in queriedPrereqs:
            classObj.pushPreReq(prereq[0])
        requiredMap[classID] = classObj
        if classID in allClassesTaken:
            doneClassesMap[classID] = classObj
            creditsCompleted += creditGiven
    numOfElectives = 0
    while electiveCreditsNeeded(creditsInPlan, 175) > 0:
        numOfElectives += 1
        electiveKey = "Elective " + str(numOfElectives)
        electiveObj = initClassObj(('Elective', 'Elective', 'Unit Requirement', 'FWS', 4))
        requiredMap[electiveKey] = electiveObj
        creditsInPlan += 4
    return buildFourYearPlan(requiredMap, doneClassesMap, creditsCompleted, major)

# Obtain number of additional elective credits needed
def electiveCreditsNeeded(totalCredits, creditRequirement):
    return creditRequirement - totalCredits

# Generate message for credit total requisite satisfaction based on major/core classes needed
def generateCreditsAlert(totalCredits):
    creditRequirement = 175
    message = "Total credits from above: " + str(totalCredits) + "."
    if totalCredits < creditRequirement:
        message += " Need " + str(electiveCreditsNeeded(totalCredits, creditRequirement)) + " credits of electives."
    return message

# Home page
@app.route("/")
@app.route("/index")
@app.route("/home")
def index():
    return render_template('index.html')

# Input page (new survey page)
@app.route("/selectmajor")
def selectMajor():
    # Connect to MySQL
    db = getMysqlConn()
    conn = db[0]
    cur = db[1]

    # Query all majors available in database
    cur.execute(queryMajors())
    queriedMajors = cur.fetchall()
    questionMajors = jsonifyMajors(queriedMajors)

    # Close connection to database
    cur.close()
    print("Cursor closed.")
    conn.close()
    print("Connection to database closed.")

    return render_template('selectmajor.html', questionMajors=questionMajors)

# Questionnaire after receiving major input
@app.route("/selectrequisites")
def selectRequisites():
    # Connect to MySQL
    db = getMysqlConn()
    conn = db[0]
    cur = db[1]

    # Translate ID of input major to queryable item name
    global userMajor
    userMajor = translateId(request.args.get('major'))

    # Query all requisites for major
    cur.execute(queryClasses(userMajor))
    queriedMajorClasses = cur.fetchall()
    questionMajorClasses = jsonifyClasses(queriedMajorClasses)

    # Query all core requirements
    cur.execute(queryClasses("Core"))
    queriedCores = cur.fetchall()
    questionCores = jsonifyClasses(queriedCores)

    totalCredits = questionMajorClasses['totalCredits'] + questionCores['totalCredits']
    creditsAlert = generateCreditsAlert(totalCredits)

    if VERBOSE_MODE is True: print(queriedMajorClasses)
    if VERBOSE_MODE is True: print(questionMajorClasses)
    if VERBOSE_MODE is True: print(queriedCores)
    if VERBOSE_MODE is True: print(questionCores)

    # Store all queried tuples in global variable
    global allQueriedClasses
    allQueriedClasses = queriedMajorClasses + queriedCores

    # Close connection to database
    cur.close()
    print("Cursor closed.")
    conn.close()
    print("Connection to database closed.")

    return render_template('selectrequisites.html', questionMajorClasses=questionMajorClasses, questionCores=questionCores, creditsAlert=creditsAlert)

# Schedule page
@app.route("/schedule")
def schedule():
    # Connect to MySQL
    db = getMysqlConn()
    conn = db[0]
    cur = db[1]

    global allQueriedClasses
    global userMajor

    majorClassesTaken = replaceDashesWithSpacesInList(request.args.getlist('questionMajorClassesTaken'))
    coresTaken = replaceDashesWithSpacesInList(request.args.getlist('questionCoresTaken'))
    allClassesTaken = majorClassesTaken + coresTaken

    fourYearPlan = createFourYearPlan(allQueriedClasses, allClassesTaken, userMajor, cur)

    # Close connection to database
    cur.close()
    print("Cursor closed.")
    conn.close()
    print("Connection to database closed.")

    return render_template('schedule.html', fourYearPlan=fourYearPlan)

allQueriedMajors = None
userMajor = None

# Enable debugging when running
if __name__ == '__main__':
    app.run(debug=True)
