USE PlanToGrad;

--  Drop Prereqs before Classes
DROP TABLE IF EXISTS Prereqs;

--  Drop MajorReqs before Classes, MajornEmphasis
DROP TABLE IF EXISTS MajorReqs;

--  Drop FourYearPlan before Classes, Student
DROP TABLE IF EXISTS FourYearPlan;

--  Drop CoursesTaken before Classes, Student
DROP TABLE IF EXISTS CoursesTaken;

--  Drop Student before MajornEmphasis
DROP TABLE IF EXISTS Student;

DROP TABLE IF EXISTS MajornEmphasis;
CREATE TABLE IF NOT EXISTS MajornEmphasis
(
  MajorName VARCHAR(255) NOT NULL,
  RequiredGPA INT NOT NULL,
  RequiredCredits INT NOT NULL,
  MinEmpClasses INT NOT NULL,
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

CREATE TABLE IF NOT EXISTS Student
(
  StudentID INT NOT NULL,
  Password INT,
  ClassDifficulty INT,
  QuartersCompleted INT NOT NULL,
  MaxQuarters INT NOT NULL,
  MaxUnits INT NOT NULL,
  MajorEmphasis VARCHAR(255) NOT NULL,
  PRIMARY KEY (StudentID),
  FOREIGN KEY (MajorEmphasis) REFERENCES MajornEmphasis(MajorName)
);

CREATE TABLE IF NOT EXISTS FourYearPlan
(
  PlanID INT NOT NULL,
  GradDate DATE,
  CourseID VARCHAR(255) NOT NULL,
  StudentID INT NOT NULL,
  PRIMARY KEY (PlanID),
  FOREIGN KEY (CourseID) REFERENCES Classes(CourseID),
  FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);

CREATE TABLE IF NOT EXISTS CoursesTaken
(
  CourseID VARCHAR(255) NOT NULL,
  StudentID INT NOT NULL,
  PRIMARY KEY (CourseID, StudentID),
  FOREIGN KEY (CourseID) REFERENCES Classes(CourseID),
  FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);
