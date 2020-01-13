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
        CourseID LIKE 'CSCI 1##' OR
        CourseID LIKE 'COEN 1##'
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
        CourseID LIKE 'CSCI 1##' OR
        CourseID LIKE 'COEN 1##'
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
    CourseID LIKE 'CSCI 1##';
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
    CourseID LIKE 'CSCI 1##' OR
    CourseID LIKE 'COEN 1##'
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
        CourseID LIKE 'CSCI 1##' OR
        CourseID LIKE 'COEN 1##'
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
    WHERE CASE
        WHEN ReqID = 'MATH Group A1'
        THEN
        (
            CourseID = 'MATH 102' OR
            CourseID = 'MATH 105' OR
            CourseID = 'MATH 153'
        )
        WHEN ReqID = 'MATH Group A2'
        THEN
        (
            CourseID = 'MATH 103' OR
            CourseID = 'MATH 111' OR
        )
        WHEN ReqID = 'MATH Group A3'
        THEN
        (
            CourseID = 'MATH 101' OR
            CourseID = 'MATH 113' OR
            CourseID = 'MATH 122' OR
            CourseID = 'MATH 125' OR
            CourseID = 'MATH 144' OR
            CourseID = 'MATH 155' OR
            CourseID = 'MATH 165' OR
            CourseID = 'MATH 166' OR
            CourseID = 'MATH 174' OR
            CourseID = 'MATH 176' OR
            CourseID = 'MATH 177'
        )
        WHEN ReqID LIKE 'MATH Group B%'
        THEN
        (
            (
                CourseID LIKE 'MATH 1##' OR
                CourseID LIKE 'CSCI 1##'
            ) AND
            CourseID != 'MATH 100'
        )
        END
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
