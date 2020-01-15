DELETE FROM ConditionalReqs;

--  CSCI Algorithms Emphasis
INSERT INTO ConditionalReqs
(
    ConditionalID,
    CourseID,
    MajorName
)
SELECT
    'CSCI Emphasis IV',
    CourseID,
    'Computer Science, Algorithms and Complexity Emphasis'
FROM
    Classes
WHERE
    CourseID = 'MATH 175' OR
    CourseID = 'MATH 176' OR
    CourseID = 'MATH 178' OR
    CourseID = 'MATH 101' OR
    CourseID REGEXP 'CSCI 1[0-9]{2}' OR
    CourseID REGEXP 'COEN 1[0-9]{2}'
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
    'Computer Science, Algorithms and Complexity Emphasis'
FROM
    Classes
WHERE
    CourseID = 'MATH 175' OR
    CourseID = 'MATH 176' OR
    CourseID = 'MATH 178' OR
    CourseID = 'MATH 101' OR
    CourseID REGEXP 'CSCI 1[0-9]{2}' OR
    CourseID REGEXP 'COEN 1[0-9]{2}'
;

--  CSCI Data Science Emphasis
INSERT INTO ConditionalReqs
(
    ConditionalID,
    CourseID,
    MajorName
)
SELECT
    'CSCI Emphasis IV',
    CourseID,
    'Computer Science, Data Science Emphasis'
FROM
    Classes
WHERE
    CourseID REGEXP 'CSCI 1[0-9]{2}' OR
    CourseID REGEXP 'COEN 1[0-9]{2}'
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
    'Computer Science, Data Science Emphasis'
FROM
    Classes
WHERE
    CourseID REGEXP 'CSCI 1[0-9]{2}' OR
    CourseID REGEXP 'COEN 1[0-9]{2}'
;

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
    'Computer Science, Software Emphasis'
FROM
    Classes
WHERE
    CourseID REGEXP 'CSCI 1[0-9]{2}';
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
    'Computer Science, Software Emphasis'
FROM
    Classes
WHERE
    CourseID REGEXP 'CSCI 1[0-9]{2}' OR
    CourseID REGEXP 'COEN 1[0-9]{2}'
;

--  CSCI Security Emphasis
INSERT INTO ConditionalReqs
(
    ConditionalID,
    CourseID,
    MajorName
)
SELECT
    'CSCI Emphasis IV',
    CourseID,
    'Computer Science, Security Emphasis'
FROM
    Classes
WHERE
    CourseID = 'MATH 175' OR
    CourseID REGEXP 'CSCI 1[0-9]{2}' OR
    CourseID REGEXP 'COEN 1[0-9]{2}'
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
    'Computer Science, Security Emphasis'
FROM
    Classes
WHERE
    CourseID = 'MATH 175' OR
    CourseID REGEXP 'CSCI 1[0-9]{2}' OR
    CourseID REGEXP 'COEN 1[0-9]{2}'
;

--  MATH Groups A1-3, B1-4
INSERT INTO ConditionalReqs
(
    ConditionalID,
    CourseID,
    MajorName
)
SELECT
    'MATH Group A1',
    CourseID,
    'Mathematics'
FROM
    Classes
WHERE
    CourseID = 'MATH 102' OR
    CourseID = 'MATH 105' OR
    CourseID = 'MATH 153'
;

INSERT INTO ConditionalReqs
(
    ConditionalID,
    CourseID,
    MajorName
)
SELECT
    'MATH Group A2',
    CourseID,
    'Mathematics'
FROM
    Classes
WHERE
    CourseID = 'MATH 103' OR
    CourseID = 'MATH 111'
;

INSERT INTO ConditionalReqs
(
    ConditionalID,
    CourseID,
    MajorName
)
SELECT
    'MATH Group A3',
    CourseID,
    'Mathematics'
FROM
    Classes
WHERE
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
;

INSERT INTO ConditionalReqs
(
    ConditionalID,
    CourseID,
    MajorName
)
SELECT
    'MATH Group B1',
    CourseID,
    'Mathematics'
FROM
    Classes
WHERE
    CourseID REGEXP 'MATH 1[0-9]{2}' OR
    CourseID REGEXP 'CSCI 1[0-9]{2}'
AND
    CourseID != 'MATH 100'
;

INSERT INTO ConditionalReqs
(
    ConditionalID,
    CourseID,
    MajorName
)
SELECT
    'MATH Group B2',
    CourseID,
    'Mathematics'
FROM
    Classes
WHERE
    CourseID REGEXP 'MATH 1[0-9]{2}' OR
    CourseID REGEXP 'CSCI 1[0-9]{2}'
AND
    CourseID != 'MATH 100'
;

INSERT INTO ConditionalReqs
(
    ConditionalID,
    CourseID,
    MajorName
)
SELECT
    'MATH Group B3',
    CourseID,
    'Mathematics'
FROM
    Classes
WHERE
    CourseID REGEXP 'MATH 1[0-9]{2}' OR
    CourseID REGEXP 'CSCI 1[0-9]{2}'
AND
    CourseID != 'MATH 100'
;

INSERT INTO ConditionalReqs
(
    ConditionalID,
    CourseID,
    MajorName
)
SELECT
    'MATH Group B4',
    CourseID,
    'Mathematics'
FROM
    Classes
WHERE
    CourseID REGEXP 'MATH 1[0-9]{2}' OR
    CourseID REGEXP 'CSCI 1[0-9]{2}'
AND
    CourseID != 'MATH 100'
;
