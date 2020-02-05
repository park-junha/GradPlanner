--  Drop CoreClasses before CoreReqs
DROP TABLE IF EXISTS CoreClasses;

--  Drop Prereqs before Classes
DROP TABLE IF EXISTS Prereqs;
DROP TABLE IF EXISTS CoreReqs;

--  Drop MajorReqs before Classes, MajornEmphasis
DROP TABLE IF EXISTS MajorReqs;
DROP TABLE IF EXISTS ConditionalReqs;

--  Drop MinorReqs before Classes, Minors
DROP TABLE IF EXISTS MinorReqs;

DROP TABLE IF EXISTS MajornEmphasis;
CREATE TABLE IF NOT EXISTS MajornEmphasis
(
    MajorName VARCHAR(255) NOT NULL,
    RequiredGPA INT NOT NULL,
    RequiredCredits INT NOT NULL,
    MinConditionalClasses INT NOT NULL,
    MinMajorClasses INT NOT NULL,
    PRIMARY KEY (MajorName)
);

DROP TABLE IF EXISTS Minors;
CREATE TABLE IF NOT EXISTS Minors
(
    MinorName VARCHAR(255) NOT NULL,
    PRIMARY KEY (MinorName)
);

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

CREATE TABLE IF NOT EXISTS CoreReqs
(
    RecommendedOrder INT NOT NULL,
    CoreReq VARCHAR(255) NOT NULL,
    LeastCreditGiven INT NOT NULL,
    SuggestedClass VARCHAR(255) NOT NULL,
    PRIMARY KEY (CoreReq),
    FOREIGN KEY (SuggestedClass) REFERENCES Classes(CourseID)
);

CREATE TABLE IF NOT EXISTS CoreClasses
(
    CourseID VARCHAR(255) NOT NULL,
    CoreReq VARCHAR(255) NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Classes(CourseID),
    FOREIGN KEY (CoreReq) REFERENCES CoreReqs(CoreReq)
);

CREATE TABLE IF NOT EXISTS Prereqs
(
    PreReqName VARCHAR(255) NOT NULL,
    CourseID VARCHAR(255) NOT NULL,
    FOREIGN KEY (PreReqName) REFERENCES Classes(CourseID),
    FOREIGN KEY (CourseID) REFERENCES Classes(CourseID)
);

CREATE TABLE IF NOT EXISTS MajorReqs
(
    RecommendedOrder INT NOT NULL,
    CourseID VARCHAR(255) NOT NULL,
    MajorName VARCHAR(255) NOT NULL,
    PRIMARY KEY (CourseID, MajorName),
    FOREIGN KEY (CourseID) REFERENCES Classes(CourseID),
    FOREIGN KEY (MajorName) REFERENCES MajornEmphasis(MajorName)
);

CREATE TABLE IF NOT EXISTS MinorReqs
(
    RecommendedOrder INT NOT NULL,
    CourseID VARCHAR(255) NOT NULL,
    MinorName VARCHAR(255) NOT NULL,
    PRIMARY KEY (CourseID, MinorName),
    FOREIGN KEY (CourseID) REFERENCES Classes(CourseID),
    FOREIGN KEY (MinorName) REFERENCES Minors(MinorName)
);

CREATE TABLE IF NOT EXISTS ConditionalReqs
(
    ConditionalID VARCHAR(255) NOT NULL,
    CourseID VARCHAR(255) NOT NULL,
    MajorName VARCHAR(255) NOT NULL,
    FOREIGN KEY (ConditionalID) REFERENCES Classes(CourseID),
    FOREIGN KEY (CourseID) REFERENCES Classes(CourseID),
    FOREIGN KEY (MajorName) REFERENCES MajornEmphasis(MajorName)
);

