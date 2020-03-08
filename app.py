from flask import Flask, render_template, request, redirect, url_for
from datetime import datetime, timedelta
from gradplanner import FourYearPlan, scuClass
from gradplanner_rds import MYSQLHOST, MYSQLPORT, MYSQLUSER, MYSQLDB
from gradplanner_rds import MYSQLPW

import sys
import pymysql

# Flask app
app = Flask(__name__)

# Create a connection and cursor objects to database
def getMysqlConn():
    try:
        # MySQL database information
        global MYSQLHOST
        global MYSQLPORT
        global MYSQLUSER
        global MYSQLDB 
        global MYSQLPW

        # MySQL connection
        print("Connecting to MySQL server...")
        conn = pymysql.connect( MYSQLHOST,
                                user=MYSQLUSER,
                                port=MYSQLPORT,
                                passwd=MYSQLPW,
                                db=MYSQLDB)
        print("Connected to MySQL server successfully.")

        # MySQL cursor for executing queries
        cur = conn.cursor()
        print("Cursor initiated.")
        return [conn, cur]
    except:
        raise Exception("Could not connect to MySQL server.")

# String manipulation / list comprehension lambdas
replaceDashesWithSpaces = lambda item : item.replace('-',' ')
replaceSpacesWithDashes = lambda item : item.replace(' ','-')
replaceCommasWithPeriods = lambda item : item.replace(',','.')
replacePeriodsWithCommas = lambda item : item.replace('.',',')
replaceDashesWithSpacesInList = lambda itemList : [ replaceDashesWithSpaces(item) for item in itemList ]
concatenateMajorAndEmphasis = lambda major, emphasis : replaceDashesWithSpaces(major) + ", " + replaceDashesWithSpaces(emphasis) + " Emphasis"
createId = lambda item : replaceSpacesWithDashes(replaceCommasWithPeriods(item))
translateId = lambda item : replaceDashesWithSpaces(replacePeriodsWithCommas(item))
electiveCreditsNeeded = lambda totalCredits, creditRequirement : creditRequirement - totalCredits
createClassMetadata = lambda classTuples, isCore, isRequired : [ {'classTuple': classTuple, 'isCore': isCore, 'isRequired': isRequired} for classTuple in classTuples ]

# MySQL queries
querySchools = lambda : """
SELECT SchoolID, SchoolName
FROM SCUSchools;"""
queryMajors = lambda school : """
SELECT MajorName
FROM MajornEmphasis
WHERE SchoolID = \'""" + school + """\';"""
queryClasses = lambda major : """
SELECT a.CourseID, CourseName, MajorName, QuarterOffered, CreditGiven
FROM Classes AS a
LEFT JOIN MajorReqs AS b
ON a.CourseID = b.CourseID
WHERE MajorName = \'""" + major + """\'
ORDER BY b.RecommendedOrder ASC;"""
queryCores = lambda major : """
SELECT CoreReq, LeastCreditGiven FROM CoreReqs
WHERE (CoreReq) NOT IN (
    SELECT CoreReq FROM CoreClasses
    LEFT JOIN MajorReqs ON MajorReqs.CourseID = CoreClasses.CourseID
    WHERE MajorName = \'""" + major + """\'
)
ORDER BY RecommendedOrder ASC;"""
queryCoreSuggestions = lambda major : """
SELECT a.CourseID, CourseName, CoreReq, QuarterOffered, CreditGiven
FROM Classes AS a
RIGHT JOIN CoreReqs AS b
ON a.CourseID = b.SuggestedClass
WHERE (CoreReq) NOT IN (
    SELECT CoreReq FROM CoreClasses
    LEFT JOIN MajorReqs ON MajorReqs.CourseID = CoreClasses.CourseID
    WHERE MajorName = \'""" + major + """\'
)
ORDER BY b.RecommendedOrder ASC;"""
queryRecommendedClasses = lambda major : """
SELECT a.CourseID, CourseName, \'Highly Recommended\', QuarterOffered, CreditGiven
FROM Classes AS a
LEFT JOIN HighlySuggestedClasses AS b
ON a.CourseID = b.CourseID
WHERE MajorName = \'""" + major + """\'
ORDER BY b.RecommendedOrder ASC;"""
queryPrereqs = lambda queriedClass : """
SELECT PreReqName
FROM Prereqs
WHERE CourseID=\'""" + queriedClass[0] + "\'"

# Initialize scuClass object
initClassObj = lambda queriedClass, isCore, isRequired : scuClass(queriedClass[0], queriedClass[1], queriedClass[2], queriedClass[3], queriedClass[4], isCore, isRequired)

# API lambdas
jsonifySchools = lambda queriedSchools : {"question": "Choose your school.", "options": [ {'name': school[1], 'id': school[0]} for school in queriedSchools ] }
jsonifyMajors = lambda queriedMajors : {"question": "Choose your major.", "options": [ {'name': major[0], 'id': createId(major[0])} for major in queriedMajors ] }
totalCreditsMessage = lambda totalCredits : "Total credits from options: " + str(totalCredits) + "."
generateCreditsAlert = lambda totalCredits, creditRequirement : totalCreditsMessage(totalCredits) if totalCredits >= creditRequirement else totalCreditsMessage(totalCredits) + " Need " + str(electiveCreditsNeeded(totalCredits, creditRequirement)) + " credits of electives."

# Format queried classes to json
def jsonifyCores(queriedCores):
    classes = {"question": "Select all cores you've completed.", "options": [[],[],[]], "totalCredits": 0}
    columnCounter = 0
    for item in queriedCores:
        optionToAppend = {}
        classId = item[0]
        optionToAppend["name"] = classId
        optionToAppend["id"] = createId(classId)
        classes["options"][columnCounter].append(optionToAppend)
        columnCounter = (columnCounter + 1) % len(classes["options"])
        classes["totalCredits"] += item[1]
    return classes

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

# Create FourYearPlan object and build the schedule
def buildFourYearPlan(requiredMap, notRequiredMap, prevCompletedClassesMap, creditsCompleted, major, startQuarter, year):
    fourYearPlan = FourYearPlan(requiredMap, notRequiredMap, creditsCompleted, major)
    for doneClass in prevCompletedClassesMap:
        fourYearPlan.completeClass(doneClass)
    return fourYearPlan.buildPlan(year, startQuarter)

# Build a four year plan
def createFourYearPlan(classMetadata, allClassesTaken, major, cur, startQuarter, startYear, creditsCompleted = 0):
    requiredMap = {}
    notRequiredMap = {}
    doneClassesMap = {}
    creditsInPlan = creditsCompleted
    for aClassObject in classMetadata:
        aClass = aClassObject['classTuple']
        isCore = aClassObject['isCore']
        isRequired = aClassObject['isRequired']
        classID = aClass[0]
        creditGiven = aClass[4]
        classObj = initClassObj(aClass, isCore, isRequired)
        cur.execute(queryPrereqs(aClass))
        queriedPrereqs = cur.fetchall()
        for prereq in queriedPrereqs:
            classObj.pushPreReq(prereq[0])
        if isRequired is False:
            notRequiredMap[classID] = classObj
            continue
        # Check if double dip
        if classID in requiredMap:
            requiredMap[classID].doubleDip(classObj)
            creditGiven = 0
        else:
            requiredMap[classID] = classObj
        creditsInPlan += creditGiven
        if (classID in allClassesTaken and aClass[2] == major) or (aClass[2] in allClassesTaken and aClass[2] != major):
            doneClassesMap[classID] = classObj
            creditsCompleted += creditGiven
    numOfElectives = 0
    while electiveCreditsNeeded(creditsInPlan, 175) > 0:
        numOfElectives += 1
        electiveKey = "Elective " + str(numOfElectives)
        electiveObj = initClassObj(('Elective', 'Elective', 'Unit Requirement', 'FWS', 4), False, False)
        requiredMap[electiveKey] = electiveObj
        creditsInPlan += 4
    return buildFourYearPlan(requiredMap, notRequiredMap, doneClassesMap, creditsCompleted, major, startQuarter, startYear)

# Home page
@app.route("/")
@app.route("/index")
@app.route("/home")
def index():
    return render_template('index.html')

# SCU Undergraduate School selection page
@app.route("/selectschool")
def selectSchool():
    # Connect to MySQL
    db = getMysqlConn()
    conn = db[0]
    cur = db[1]

    # Query schools from database
    cur.execute(querySchools())
    queriedSchools = cur.fetchall()
    questionSchools = jsonifySchools(queriedSchools)

    # Close connection to database
    cur.close()
    print("Cursor closed.")
    conn.close()
    print("Connection to database closed.")

    return render_template('selectschool.html', questionSchools=questionSchools)

# Input page (new survey page)
@app.route("/selectmajor")
def selectMajor():
    # Get school input
    school = request.args.get('school')

    if school is None:
        return redirect(url_for('selectSchool'))

    # Connect to MySQL
    db = getMysqlConn()
    conn = db[0]
    cur = db[1]

    # Query all majors available in database
    cur.execute(queryMajors(school))
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

    # Quarters
    terms = [{'name':'Fall','id':'Fall'}, {'name':'Winter','id':'Winter'}, {'name':'Spring','id':'Spring'}]

    # Academic years
    years = [{'name':'2019-2020','id':'2019'}, {'name':'2020-2021','id':'2020'}]

    # Translate ID of input major to queryable item name
    userMajor = {}
    userMajor['id'] = request.args.get('major')
    if userMajor['id'] is None:
        print("No major declared. Defaulting to Undeclared major.")
        userMajor['id'] = "Undeclared"
    userMajor['name'] = translateId(userMajor['id'])

    # Query all requisites for major
    cur.execute(queryClasses(userMajor['name']))
    queriedMajorClasses = cur.fetchall()
    questionMajorClasses = jsonifyClasses(queriedMajorClasses)

    # Query all core requirements
    cur.execute(queryCores(userMajor['name']))
    queriedCores = cur.fetchall()
    questionCores = jsonifyCores(queriedCores)

    totalCredits = questionMajorClasses['totalCredits'] + questionCores['totalCredits']
    creditsAlert = generateCreditsAlert(totalCredits, 175)

    # Combine tuples of all queried classes
    allQueriedClasses = queriedMajorClasses + queriedCores

    # Close connection to database
    cur.close()
    print("Cursor closed.")
    conn.close()
    print("Connection to database closed.")

    return render_template('selectrequisites.html', questionMajorClasses=questionMajorClasses, questionCores=questionCores, creditsAlert=creditsAlert, terms=terms, years=years, userMajor=userMajor)

# Schedule page
@app.route("/schedule")
def schedule():
    # Connect to MySQL
    db = getMysqlConn()
    conn = db[0]
    cur = db[1]

    majorClassesTaken = replaceDashesWithSpacesInList(request.args.getlist('questionMajorClassesTaken'))
    coresTaken = replaceDashesWithSpacesInList(request.args.getlist('questionCoresTaken'))
    allClassesTaken = majorClassesTaken + coresTaken

    userMajor = translateId(request.args.get('inputtedMajor'))

    try:
        startQuarter = request.args.get('startingQuarter')
        if startQuarter is None:
            raise Exception
    except:
        currentMonth = datetime.now().month
        if currentMonth >= 10 and currentMonth <= 12:
            startQuarter = "Winter"
        elif currentMonth >= 1 and currentMonth <= 3:
            startQuarter = "Spring"
        else:
            startQuarter = "Fall"
        print("No user input for startQuarter.")
        print("Current month:", str(currentMonth) + ". Defaulting to", startQuarter)

    try:
        startYear = int(request.args.get('academicYear'))
    except:
        currentYear = datetime.now().year
        startYear = currentYear
        if datetime.now().month < 4:
            startYear -= 1
        print("No user input for startYear.")
        print("Current year:", str(currentYear) + ". Defaulting to", startYear)

    try:
        electiveUnits = int(request.args.get('electiveUnits'))
    except:
        print("Invalid/no user input for electiveUnits. Defaulting to 0.")
        electiveUnits = 0

    # Query all requisites for major
    cur.execute(queryClasses(userMajor))
    queriedMajorClasses = cur.fetchall()

    # Query all core requirements
    cur.execute(queryCoreSuggestions(userMajor))
    queriedCores = cur.fetchall()

    # Query highly recommended classes for major
    cur.execute(queryRecommendedClasses(userMajor))
    queriedRecommendedClasses = cur.fetchall()

    # Combine tuples of all queried classes
    allQueriedClasses = queriedMajorClasses + queriedCores

    # Organize information on queried tuples
    classMetadata = []
    classMetadata.extend(createClassMetadata(queriedMajorClasses, False, True))
    classMetadata.extend(createClassMetadata(queriedCores, True, True))
    classMetadata.extend(createClassMetadata(queriedRecommendedClasses, False, False))

    # Add current year by 1 if not Fall
    if startQuarter != 'Fall':
        startYear += 1

    fourYearPlan = createFourYearPlan(classMetadata, allClassesTaken, userMajor, cur, startQuarter, startYear, electiveUnits)

    # Close connection to database
    cur.close()
    print("Cursor closed.")
    conn.close()
    print("Connection to database closed.")

    return render_template('schedule.html', fourYearPlan=fourYearPlan)

# Enable debugging when running
if __name__ == '__main__':
    app.run()
