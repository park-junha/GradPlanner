from flask import Flask, render_template, request, redirect, url_for
import sys
import json
import random
import pymysql

app = Flask(__name__)

# Paths to JSON files containing survey questions and options
surveysPath = 'setup/surveyQuestionJsons'
csciEmphasesJson = surveysPath + '/csciEmphases.json'
# prefersMajorClassesOnlyJson = surveysPath + '/prefersMajorClassesOnly.json'
csciMajorReqsJson = surveysPath + '/csciMajorReqs.json'
coreReqsJson = surveysPath + '/coreReqs.json'

DEBUG_MODE = False

if any(arg in ['-d', '--debug'] for arg in sys.argv):
    print("Debug flag set to True")
    DEBUG_MODE = True

class scuClass:
    def __init__(self, cID = "", name = "", sub = "", quart = "", creds = 0):
        self.classInfo = {'classID': cID, 'fullName': name, 'subject': sub, 'quarters': quart, 'credits': creds}
        self.preReqs = []

    def pushPreReq(self, cID):
        if DEBUG_MODE is True: print("scuClass.pushPreReq(): Appending " + cID + " as prereq to scuClass object")
        self.preReqs.append(cID)

    def getID(self):
        return self.classInfo['classID']

    def getName(self):
        return self.classInfo['fullName']

    def getSubject(self):
        return self.classInfo['subject']

    def getQuarters(self):
        return self.classInfo['quarters']

    def getCredits(self):
        return self.classInfo['credits']

    def getPrereqs(self):
        return self.preReqs

    def printDetails(self):
        print("Class ID:", self.getID())
        print("Name:", self.getName())
        print("Subject:", self.getSubject())
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
    def __init__(self, inputMajor, inputCore, creditsAlreadyDone):
        self.metadata = {'major': inputMajor, 'core': inputCore, 'doneClasses': [], 'credits': creditsAlreadyDone}
        self.quarters = ["F","W","S","F","W","S","F","W","S","F","W","S"]

    def completeClass(self, cID):
        maps = ['major', 'core']
        for key in maps:
            if cID in self.metadata[key]:
                self.metadata['doneClasses'].append(cID)
                self.metadata['credits'] += self.metadata[key][cID].getCredits()

    def getClass(self, cID): # scuClass return value
        maps = ['major', 'core']
        for key in maps:
            if cID in self.metadata[key]:
                return self.metadata[key][cID]

    # not sure if logic is correct, especially any condition
    def feasible(self, cID, quarter, year):
        if DEBUG_MODE is True: print("feasible(), cID:", cID)
        if DEBUG_MODE is True: print("feasible(), quarter:", quarter)
        if DEBUG_MODE is True: print("feasible(), year:", year)
        if DEBUG_MODE is True: print("feasible(), self.metadata['doneClasses']:", self.metadata['doneClasses'])
        if DEBUG_MODE is True: print("feasible(), self.getClass(cID).getPrereqs():", self.getClass(cID).getPrereqs())
        if cID in self.metadata['doneClasses']:
            if DEBUG_MODE is True: print("feasible() return False because class is done")
            return False
        if any(prereq not in self.metadata['doneClasses'] for prereq in self.getClass(cID).getPrereqs()):
            if DEBUG_MODE is True: print("feasible() return False because prereqs not met")
            return False
        if DEBUG_MODE is True: print("feasible() return", self.getClass(cID).available(quarter, year))
        return self.getClass(cID).available(quarter, year)

    def planComplete(self):
        maps = ['major', 'core']
        if self.metadata['credits'] < 175:
            if DEBUG_MODE is True: print("planComplete() return False because credits under 175")
            return False
        for key in maps:
            for cID in self.metadata[key]:
                if cID not in self.metadata['doneClasses']:
                    if DEBUG_MODE is True: print("planComplete() return False because", cID, "not yet taken")
                    return False
        if DEBUG_MODE is True: print("planComplete() return True")
        return True

    def buildPlan(self, year):
        plan = []
        currentYear = -1
        quarter = -1
        maxClassCount = 4
        terms = ['Fall', 'Winter', 'Spring']
        maps = ['major', 'core']
        while not self.planComplete():
            quarter += 1
            if quarter % 3 == 0:
                quarter = 0
                currentYear += 1
                academicYear = str(year) + '-' + str(year + 1)
                if DEBUG_MODE is True: print("buildPlan(), currentYear:", currentYear)
                if DEBUG_MODE is True: print("buildPlan(), quarter:", quarter)
                if DEBUG_MODE is True: print("buildPlan(), academicYear:", academicYear)
                plan.append({'year': academicYear, 'yearSchedule': []})
                if DEBUG_MODE is True: print("Current plan:", plan)
            if quarter % 3 == 1:
                year += 1
            plan[currentYear]['yearSchedule'].append({'quarter': terms[quarter], 'classes': []})
            classCount = 0
            balanceCount = 0
            for key in maps:
                if key == 'core':
                    balanceCount = 0
                for cID in self.metadata[key]:
                    if self.feasible(cID, terms[quarter][0], year) and (classCount < maxClassCount):
                        if DEBUG_MODE is True: print("buildPlan(), appending", cID, "to plan")
                        prereqs = self.metadata[key][cID].getPrereqs()
                        if not prereqs:
                            prereqs = None
                        plan[currentYear]['yearSchedule'][quarter]['classes'].append({'name': cID, 'prereqs': prereqs, 'units': self.metadata[key][cID].getCredits()})
                        self.completeClass(cID)
                        classCount += 1
                        balanceCount += 1
                    # in original c++ code this next if statement is in the beginning for emphases
                    if balanceCount >= 2:
                        break
            if DEBUG_MODE is True: print("Current plan (end of while):", plan)
            if currentYear > 30:
                if DEBUG_MODE is True: print("Cannot build plan. Exiting program.")
                sys.exit(1)
        if DEBUG_MODE is True: print("buildPlan(): Plan complete!")
        return plan

def buildFourYearPlan(majorMap, coreMap, prevCompletedClassesMap, creditsCompleted):
    year = 2019
    fourYearPlan = FourYearPlan(majorMap, coreMap, creditsCompleted)
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
def sqlFromSurvey(studentID, quartersCompleted, maxQuarters, maxUnits, majorAndEmphasis, classes):
    try:
        query = ["INSERT INTO Student (StudentID, QuartersCompleted, MaxQuarters, MaxUnits, MajorEmphasis) VALUES (" + str(studentID) + ", " + str(quartersCompleted) + ", " + str(maxQuarters) + ", " + str(maxUnits) + ", \'" + majorAndEmphasis + "\');"]
        numberOfClasses = len(classes)
        for classesIndex in range(numberOfClasses):
            value = "INSERT INTO CoursesTaken (CourseID, StudentID) VALUES (\'" + classes[classesIndex] + "\', " + str(studentID) + ");"
            query.append(value)
        return query
    except:
        raise Exception("Could not generate SQL INSERT INTO statements")

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

# Home page
@app.route("/")
@app.route("/index")
@app.route("/home")
def index():
    return render_template('index.html')

# Survey page
@app.route("/survey")
def survey():
    csciEmphases = getJson(csciEmphasesJson)
    csciMajorReqs = getJson(csciMajorReqsJson)
    coreReqs = getJson(coreReqsJson)

    return render_template('survey.html', csciEmphases=csciEmphases, csciMajorReqs=csciMajorReqs, coreReqs=coreReqs)

# Schedule page
@app.route("/schedule")
def schedule():
    # Connect to MySQL
    db = getMysqlConn()
    conn = db[0]
    cur = db[1]

    # Generate random student ID
    # Currently only serves as an identifier for data entry
    # No identifier uniqueness check currently implemented
    studentID = random.randint(-1999999999,-1000000000)
    print("Student ID (integer):", studentID)

    # Get major and emphasis
    major = "Computer-Science"
    emphasis = request.args.get('csciEmphasis')

    # Replace numberOfQuarters and maxUnits values with HTML values
    quartersCompleted = 0
    maxQuarters = 12
    maxUnits = 19

    # Preference on major/core classes only
    classesPreferred = request.args.get('classPreferences')

    # Return to survey page if no emphasis declared
    # No error message is displayed currently
    if emphasis == None:
        return render_template('survey.html', csciEmphases=csciEmphases, csciMajorReqs=csciMajorReqs, coreReqs=coreReqs)
    else:
        majorAndEmphasis = concatenateMajorAndEmphasis(major, emphasis)

    print("Major:", majorAndEmphasis)
    print("Core/major preference:", classesPreferred)

    # Initialize lists, replace dashes in names of classes with spaces
    majorClassesTaken = replaceDashesWithSpacesInList(request.args.getlist('csciMajorReqsTaken'))
    coresTaken = replaceDashesWithSpacesInList(request.args.getlist('coreReqsTaken'))
    allClassesTaken = majorClassesTaken + coresTaken
    print("\nAll classes taken:")
    for aClass in allClassesTaken:
        print(aClass)

#   # Execute insert commands to MySQL
#   sqlCommands = sqlFromSurvey(studentID, quartersCompleted, maxQuarters, maxUnits, majorAndEmphasis, allClassesTaken)
#   print("\nSQL commands:")
#   for sqlCommand in sqlCommands:
#       print(sqlCommand)
#       cur.execute(sqlCommand)

#   # Commit commands to database
#   conn.commit()
#   print("\nSQL commands committed to database")

    # Query major classes and write to file
    majorMap = {}
    coreMap = {}
    doneClassesMap = {}
    creditsCompleted = 0
    queryMajorClasses = "SELECT a.CourseID, CourseName, QuarterOffered, CreditGiven FROM Classes AS a LEFT JOIN MajorReqs AS b ON a.CourseID = b.CourseID WHERE MajorName = \'" + majorAndEmphasis + "\';"
    cur.execute(queryMajorClasses)
    queriedMajorClasses = cur.fetchall()

    # Get two random emphasis classes lol
    queryTwoEmphasisClasses = "SELECT a.CourseID, CourseName, QuarterOffered, CreditGiven FROM Classes AS a LEFT JOIN MajorReqs AS b ON a.CourseID = b.CourseID WHERE a.CourseID = \'CSCI 168\' OR a.CourseID = \'COEN 166 and L\';"
    cur.execute(queryTwoEmphasisClasses)
    queriedMajorClasses += cur.fetchall()

    for aClass in queriedMajorClasses:
        classID = aClass[0]
        creditGiven = aClass[3]
        classObj = scuClass(classID, aClass[1], majorAndEmphasis, aClass[2], creditGiven)
        queryPrereqs = "SELECT PreReqName from Prereqs where CourseID=\'" + classID + "\'"
        cur.execute(queryPrereqs)
        queriedPrereqs = cur.fetchall()
        for prereq in queriedPrereqs:
            classObj.pushPreReq(prereq[0])
        majorMap[classID] = classObj
        if classID in allClassesTaken:
            doneClassesMap[classID] = classObj
            creditsCompleted += creditGiven

    # Query core classes and write to file
    queryCoreClasses = "SELECT a.CourseID, CourseName, QuarterOffered, CreditGiven FROM Classes AS a LEFT JOIN MajorReqs AS b ON a.CourseID = b.CourseID WHERE MajorName = \'Core\';"
    cur.execute(queryCoreClasses)
    queriedCoreClasses = cur.fetchall()

    for aClass in queriedCoreClasses:
        classID = aClass[0]
        creditGiven = aClass[3]
        classObj = scuClass(classID, aClass[1], "Core", aClass[2], creditGiven)
        queryPrereqs = "SELECT PreReqName from Prereqs where CourseID=\'" + classID + "\'"
        cur.execute(queryPrereqs)
        queriedPrereqs = cur.fetchall()
        for prereq in queriedPrereqs:
            classObj.pushPreReq(prereq[0])
        coreMap[classID] = classObj
        if classID in allClassesTaken:
            doneClassesMap[classID] = classObj
            creditsCompleted += creditGiven

    fourYearPlan = buildFourYearPlan(majorMap, coreMap, doneClassesMap, creditsCompleted)

    # Close connection to database
    cur.close()
    print("Cursor closed.")
    conn.close()
    print("Connection to database closed.")

    return render_template('schedule.html', fourYearPlan=fourYearPlan)

# Enable debugging when running
if __name__ == '__main__':
    app.run(debug=True)
