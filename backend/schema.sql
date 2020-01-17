--  Drop CpreClasses before CoreReqs
DROP TABLE IF EXISTS CoreClasses;

--  Drop Prereqs before Classes
DROP TABLE IF EXISTS Prereqs;
DROP TABLE IF EXISTS CoreReqs;

--  Drop MajorReqs before Classes, MajornEmphasis
DROP TABLE IF EXISTS MajorReqs;
DROP TABLE IF EXISTS ConditionalReqs;

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
    SuggestedClass VARCHAR(255) NOT NULL,
--  FOREIGN KEY (SuggestedClass) REFERENCE Classes(CourseID)
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

CREATE TABLE IF NOT EXISTS ConditionalReqs
(
    ConditionalID VARCHAR(255) NOT NULL,
    CourseID VARCHAR(255) NOT NULL,
    MajorName VARCHAR(255) NOT NULL,
    FOREIGN KEY (ConditionalID) REFERENCES Classes(CourseID),
    FOREIGN KEY (CourseID) REFERENCES Classes(CourseID),
    FOREIGN KEY (MajorName) REFERENCES MajornEmphasis(MajorName)
);

