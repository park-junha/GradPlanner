DELETE FROM ConditionalReqs;

--  CSCI Algorithms Emphasis
SET ReqID = 'CSCI Emphasis IV';
CSCIAlgReqs: BEGIN
    INSERT INTO ConditionalReqs
    (
        ConditionalID,
        CourseID,
        MajorName
    )
    SELECT
        ReqID,
        CourseID,
        'Computer Science, Algorithms and Complexity Emphasis';
    FROM
        Classes
    WHERE
        CourseID = 'MATH 175' OR
        CourseID = 'MATH 176' OR
        CourseID = 'MATH 178' OR
        CourseID = 'MATH 101' OR
        CourseID LIKE 'CSCI%' OR
        CourseID LIKE 'COEN%'
    ;
    IF ReqID = 'CSCI Emphasis IV' THEN
        SET ReqID = 'CSCI Emphasis V';
        ITERATE CSCIAlgReqs;
    END IF;
END CSCIAlgReqs;

--  CSCI Data Science Emphasis
SET ReqID = 'CSCI Emphasis IV';
CSCIDataSciReqs: BEGIN
    INSERT INTO ConditionalReqs
    (
        ConditionalID,
        CourseID,
        MajorName
    )
    SELECT
        ReqID,
        CourseID,
        'Computer Science, Data Science Emphasis';
    FROM
        Classes
    WHERE
        CourseID LIKE 'CSCI%' OR
        CourseID LIKE 'COEN%'
    ;
    IF ReqID = 'CSCI Emphasis IV' THEN
        SET ReqID = 'CSCI Emphasis V';
        ITERATE CSCIAlgReqs;
    END IF;
END CSCIDataSciReqs;

--  CSCI Software Emphasis
INSERT INTO ConditionalReqs
(
    ConditionalID,
    CourseID,
    MajorName
)
SELECT
    'CSCI Emphasis IV',
    CourseID,
    'Computer Science, Software Emphasis';
FROM
    Classes
WHERE
    CourseID LIKE 'CSCI%';
;
INSERT INTO ConditionalReqs
(
    ConditionalID,
    CourseID,
    MajorName
)
SELECT
    'CSCI Emphasis V',
    CourseID,
    'Computer Science, Software Emphasis';
FROM
    Classes
WHERE
    CourseID LIKE 'CSCI%' OR
    CourseID LIKE 'COEN%'
;

--  CSCI Security Emphasis
SET ReqID = 'CSCI Emphasis IV';
CSCISecurityReqs: BEGIN
    INSERT INTO ConditionalReqs
    (
        ConditionalID,
        CourseID,
        MajorName
    )
    SELECT
        ReqID,
        CourseID,
        'Computer Science, Security Emphasis';
    FROM
        Classes
    WHERE
        CourseID = 'MATH 175' OR
        CourseID LIKE 'CSCI%' OR
        CourseID LIKE 'COEN%'
    ;
    IF ReqID = 'CSCI Emphasis IV' THEN
        SET ReqID = 'CSCI Emphasis V';
        ITERATE CSCIAlgReqs;
    END IF;
END CSCISecurityReqs;

--  MATH Groups A1-3, B1-4
SET GroupNum = 1;
SET GroupLetter = 'A';
MATHGroups: BEGIN
    SET ReqID = CONCAT('MATH Group ', GroupLetter, GroupNum);
    INSERT INTO ConditionalReqs
    (
        ConditionalID,
        CourseID,
        MajorName
    )
    SELECT
        ReqID,
        CourseID,
        'Mathematics';
    FROM
        Classes
    WHERE
        --  Group A1
        CourseID = 'MATH 102' OR
        CourseID = 'MATH 105' OR
        CourseID = 'MATH 153'
    ;
    IF GroupNum < 4 THEN
        SET GroupNum = GroupNum + 1;
        IF GroupLetter = 'A' AND GroupNum > 3 THEN
            SET GroupLetter = 'B';
            SET GroupNum = 1;
        END IF;
        ITERATE CSCIAlgReqs;
    END IF;
END MATHGroups;
