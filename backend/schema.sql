--  Drop CoreClasses before CoreReqs
DROP TABLE IF EXISTS CoreClasses;

--  Drop Prereqs before Classes
DROP TABLE IF EXISTS Prereqs;
DROP TABLE IF EXISTS CoreReqs;

--  Drop MajorReqs before Classes, MajornEmphasis
DROP TABLE IF EXISTS MajorReqs;
DROP TABLE IF EXISTS HighlySuggestedClasses;
DROP TABLE IF EXISTS ConditionalReqs;

--  Drop MinorReqs before Classes, Minors
DROP TABLE IF EXISTS MinorReqs;

--  Drop MajornEmphasis before SCUSchools
DROP TABLE IF EXISTS MajornEmphasis;
DROP TABLE IF EXISTS Minors;

DROP TABLE IF EXISTS SCUSchools;

--  This table stores the undergraduate schools of SCU
CREATE TABLE IF NOT EXISTS SCUSchools
(
    SchoolName VARCHAR(255) NOT NULL,
    SchoolID VARCHAR(4) NOT NULL,
    PRIMARY KEY (SchoolID)
);

--  This table stores SCU majors
CREATE TABLE IF NOT EXISTS MajornEmphasis
(
    MajorName VARCHAR(255) NOT NULL,
    SchoolID VARCHAR(255) NOT NULL,
    RequiredGPA INT NOT NULL,
    RequiredCredits INT NOT NULL,
    MinConditionalClasses INT NOT NULL,
    MinMajorClasses INT NOT NULL,
    PRIMARY KEY (MajorName),
    FOREIGN KEY (SchoolID) REFERENCES SCUSchools(SchoolID)
);

--  This table stores SCU minors
CREATE TABLE IF NOT EXISTS Minors
(
    MinorName VARCHAR(255) NOT NULL,
    SchoolID VARCHAR(255) NOT NULL,
    PRIMARY KEY (MinorName),
    FOREIGN KEY (SchoolID) REFERENCES SCUSchools(SchoolID)
);

--  This table stores SCU classes
DROP TABLE IF EXISTS Classes;
CREATE TABLE IF NOT EXISTS Classes
(
    CourseName VARCHAR(255) NOT NULL,
    CourseID VARCHAR(255) NOT NULL,
    QuarterOffered VARCHAR(255) NOT NULL,
    CreditGiven INT NOT NULL,
    CreditReq INT NOT NULL,
    HasPrereqs INT NOT NULL,
    Difficulty INT,
    PRIMARY KEY (CourseID)
);

--  This table stores the core requirements (not the classes)
CREATE TABLE IF NOT EXISTS CoreReqs
(
    RecommendedOrder INT NOT NULL,
    CoreReq VARCHAR(255) NOT NULL,
    LeastCreditGiven INT NOT NULL,
    SuggestedClass VARCHAR(255) NOT NULL,
    PRIMARY KEY (CoreReq),
    FOREIGN KEY (SuggestedClass) REFERENCES Classes(CourseID)
);

--  This table defines what classes satisfy what core requirements
CREATE TABLE IF NOT EXISTS CoreClasses
(
    CourseID VARCHAR(255) NOT NULL,
    CoreReq VARCHAR(255) NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Classes(CourseID),
    FOREIGN KEY (CoreReq) REFERENCES CoreReqs(CoreReq)
);

--  This table defines what classes are prereqs for another class
CREATE TABLE IF NOT EXISTS Prereqs
(
    PreReqName VARCHAR(255) NOT NULL,
    CourseID VARCHAR(255) NOT NULL,
    FOREIGN KEY (PreReqName) REFERENCES Classes(CourseID),
    FOREIGN KEY (CourseID) REFERENCES Classes(CourseID)
);

--  This table decides what classes are required for a major
CREATE TABLE IF NOT EXISTS MajorReqs
(
    RecommendedOrder INT NOT NULL,
    CourseID VARCHAR(255) NOT NULL,
    MajorName VARCHAR(255) NOT NULL,
    PRIMARY KEY (CourseID, MajorName),
    FOREIGN KEY (CourseID) REFERENCES Classes(CourseID),
    FOREIGN KEY (MajorName) REFERENCES MajornEmphasis(MajorName)
);

--  This table decides what classes are recommended for a major
CREATE TABLE IF NOT EXISTS HighlySuggestedClasses
(
    RecommendedOrder INT NOT NULL,
    CourseID VARCHAR(255) NOT NULL,
    MajorName VARCHAR(255) NOT NULL,
    PRIMARY KEY (CourseID, MajorName),
    FOREIGN KEY (CourseID) REFERENCES Classes(CourseID),
    FOREIGN KEY (MajorName) REFERENCES MajornEmphasis(MajorName)
);

--  This table decides what classes are required for a minor
CREATE TABLE IF NOT EXISTS MinorReqs
(
    RecommendedOrder INT NOT NULL,
    CourseID VARCHAR(255) NOT NULL,
    MinorName VARCHAR(255) NOT NULL,
    PRIMARY KEY (CourseID, MinorName),
    FOREIGN KEY (CourseID) REFERENCES Classes(CourseID),
    FOREIGN KEY (MinorName) REFERENCES Minors(MinorName)
);

--  Unused table originally intended to fill in things like "MATH Group A1"
CREATE TABLE IF NOT EXISTS ConditionalReqs
(
    ConditionalID VARCHAR(255) NOT NULL,
    CourseID VARCHAR(255) NOT NULL,
    MajorName VARCHAR(255) NOT NULL,
    FOREIGN KEY (ConditionalID) REFERENCES Classes(CourseID),
    FOREIGN KEY (CourseID) REFERENCES Classes(CourseID),
    FOREIGN KEY (MajorName) REFERENCES MajornEmphasis(MajorName)
);

