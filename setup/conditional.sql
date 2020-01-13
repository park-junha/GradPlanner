DELETE FROM ConditionalReqs;

--  CSCI Algorithms Emphasis
DROP PROCEDURE CSCIAlgEmphases;
DELIMITER $$
CREATE PROCEDURE CSCIAlgEmphases()
BEGIN
    DECLARE ReqID VARCHAR(64);
    SET ReqID = 'CSCI Emphasis IV';
    CSCIAlgReqs: LOOP
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
        LEAVE CSCIAlgReqs;
    END LOOP CSCIAlgReqs;
END$$

--  CSCI Data Science Emphasis
DROP PROCEDURE CSCIDataSciEmphases;
DELIMITER $$
CREATE PROCEDURE CSCIDataSciEmphases()
BEGIN
    DECLARE ReqID VARCHAR(64);
    SET ReqID = 'CSCI Emphasis IV';
    CSCIDataSciReqs: LOOP
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
            ITERATE CSCIDataSciReqs;
        END IF;
        LEAVE CSCIDataSciReqs;
    END LOOP CSCIDataSciReqs;
END$$

--  CSCI Software Emphasis
DROP PROCEDURE CSCISoftwareEmphases;
DELIMITER $$
CREATE PROCEDURE CSCISoftwareEmphases()
BEGIN
    DECLARE ReqID VARCHAR(64);
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
END$$

--  CSCI Security Emphasis
DROP PROCEDURE CSCISecurityEmphases;
DELIMITER $$
CREATE PROCEDURE CSCISecurityEmphases()
BEGIN
    DECLARE ReqID VARCHAR(64);
    SET ReqID = 'CSCI Emphasis IV';
    CSCISecurityReqs: LOOP
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
            ITERATE CSCISecurityReqs;
        END IF;
        LEAVE CSCISecurityReqs;
    END LOOP CSCISecurityReqs;
END$$

--  MATH Groups A1-3, B1-4
DROP PROCEDURE MATHGroup;
DELIMITER $$
CREATE PROCEDURE MATHGroup()
BEGIN
    DECLARE ReqID VARCHAR(64);
    DECLARE GroupNum INT;
    DECLARE GroupLetter VARCHAR(1);
    SET GroupNum = 1;
    SET GroupLetter = 'A';
    MATHGroups: LOOP
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
            ITERATE MATHGroups;
        END IF;
        LEAVE MATHGroups;
    END LOOP MATHGroups;
END$$
