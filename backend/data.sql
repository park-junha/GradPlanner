--  Delete tables with foreign keys first
DELETE FROM CoreClasses;

DELETE FROM Prereqs;
DELETE FROM CoreReqs;
DELETE FROM MajorReqs;
DELETE FROM HighlySuggestedClasses;

DELETE FROM MinorReqs;

DELETE FROM MajornEmphasis;
DELETE FROM Minors;

DELETE FROM SCUSchools;
INSERT INTO SCUSchools
(
    SchoolName,
    SchoolID
)
VALUES
(
    'The College of Arts and Sciences',
    'ASCI'
),
(
    'The School of Engineering',
    'ENGR'
),
(
    'The Leavey School of Business',
    'BUSN'
);

INSERT INTO MajornEmphasis
(
    MajorName,
    SchoolID,
    RequiredGPA,
    RequiredCredits,
    MinConditionalClasses,
    MinMajorClasses
)
VALUES
(
    'Computer Science, Algorithms and Complexity Emphasis',
    'ASCI',
    2,
    175,
    2,
    20
),
(
    'Computer Science, Data Science Emphasis', 
    'ASCI',
    2,
    175,
    2,
    20
),
(
    'Computer Science, Software Emphasis',
    'ASCI',
    2,
    175,
    2,
    20
),
(
    'Computer Science, Security Emphasis',
    'ASCI',
    2,
    175,
    2,
    20
),
(
    'Mathematics',
    'ASCI',
    2,
    175,
    7,
    18
),
(
	'Mechanical Engineering',
    'ENGR',
    2,
    175,
    7,
    18
)
;

INSERT INTO Minors
(
    MinorName,
    SchoolID
)
VALUES
(
    'Mathematics',
    'ASCI'
),
(
    'Computer Science',
    'ASCI'
);

DELETE FROM Classes;
INSERT INTO Classes
(
    CourseName,
    CourseID,
    QuarterOffered,
    CreditGiven,
    CreditReq,
    HasPrereqs
)
VALUES
(
	'Introduction to Programming',
    'COEN 10 and L',
    'F',
    5,
    0,
    0
),
(
	'Advanced Programming',
    'COEN 11 and L',
    'FW',
    5,
    0,
    1
),
(
	'MECH Upper Div Elective II',
    'MECH Upper Div Elective II',
    'FWS',
    4,
    0,
    1
),
(
	'MECH Upper Div Elective I',
    'MECH Upper Div Elective I',
    'FWS',
    4,
    0,
    1
),
(
	'Advanced Design III: Completion and Evaluation',
    'MECH 196',
    'S',
    3,
    0,
    1
),
(
	'Advanced Design II: Implementation',
    'MECH 195',
    'W',
    4,
    0,
    1
),
(
	'Advanced Design I: Tools',
    'MECH 194',
    'F',
    3,
    0,
    1
),
(
	'Modern Instrumentation for Engineers',
    'MECH 160 and L',
    'FS',
    5,
    0,
    1
),
(
	'Control Systems, Analysis, and Design',
    'MECH 142 and L',
    'WS',
    5,
    0,
    1
),
(
	'Mechanical Vibrations',
    'MECH 141 and L',
    'FW',
    5,
    0,
    1
),
(
	'Dynamics',
    'MECH 140',
    'FS',
    4,
    0,
    1
),
(
	'Thermal Systems Design',
    'MECH 125',
    'S',
    4,
    0,
    1
),
(
	'Heat Transfer',
    'MECH 123 and L',
    'FW',
    5,
    0,
    1
),
(
	'Fluid Mechanics',
    'MECH 122 and L',
    'FS',
    5,
    0,
    1
),
(
	'Thermodynamics',
    'MECH 121',
    'FWS',
    4,
    0,
    1
),
(
	'Machine Design II',
    'MECH 115',
    'S',
    4,
    0,
    1
),
(
	'Machine Design I',
    'MECH 114',
    'W',
    4,
    0,
    1
),
(
	'Machining Laboratory',
    'MECH 101L',
    'F',
    4,
    0,
    1
),
(
	'Materials for Manufacturing Process',
    'MECH 11',
    'FW',
    4,
    0,
    1
),
(
	'Graphical Communication in Design',
    'MECH 10 and L',
    'FWS',
    5,
    0,
    0
),
(
	'Electric Circuits I',
    'ELEN 50 and L',
    'FWS',
    5,
    0,
    1
),
(
	'Applied Programming in C',
    'COEN 44 and L',
    'F',
    5,
    0,
    1
),
(
	'Mechanis II: Strength of Materials',
    'CENG 43 and L',
    'S',
    5,
    0,
    1
),
(
	'Mechanics I: Statics',
    'CENG 41',
    'FW',
    4,
    0,
    1
),
(
	'Introduction to Engineering',
    'ENGR 1 and L',
    'FWS',
    2,
    0,
    0
),
(
	'Engineering Communications: Practical Writing and Presentation Skills for Engineers',
    'ENGL 181',
    'FWS',
    4,
    0,
    1
),
(
	'Introduction to Mathematical Methods in Mechanical Engineering',
    'MECH 102',
    'FS',
    4,
    0,
    0
),
(
	'Physics for Scientists and Engineers III',
    'PHYS 33',
    'F',
    5,
    0,
    1
),
(
	'Introduction to Materials Science Laboratory',
    'MECH 15 and L',
    'WS',
    5,
    0,
    1    
),
(
	'General Chemistry 1: Bonding and Energy',
    'CHEM 11 and L',
    'F',
    5,
    0,
    0
),
(
	'Differential Equations',
    'AMTH 106',
    'FWS',
    4,
    0,
    1
),
(
	'Probability and Statistics',
    'AMTH 108',
    'FWS',
    4,
    0,
    1
),
(
	'Numerical Methods',
    'AMTH 118',
    'FS',
    4,
    0,
    1
),
(
    'Intro to Cultural Anthropology',
    'ANTH 3',
    'FWS',
    4,
    0,
    0
),
(
    'Basic Drawing',
    'ARTS 30',
    'FWS',
    4,
    0,
    0
),
(
    'Cultural Competence & Humility',
    'CHST 4',
    'FWS',
    4,
    0,
    0
),
(
    'Introduction to Computer Science',
    'CSCI 10 and L',
    'FWS',
    5,
    0,
    0
),
(
    'Object-Oriented Programming',
    'CSCI 60 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Data Structures',
    'CSCI 61',
    'FWS',
    4,
    0,
    1
),
(
    'Theory of Automata and Languages',
    'CSCI 161',
    'FW',
    5,
    0,
    1
),
(
    'Computational Complexity',
    'CSCI 162',
    'WE',
    5,
    0,
    1
),
(
    'Theory of Algorithms',
    'CSCI 163A',
    'FWS',
    5,
    0,
    1
),
(
    'Advanced Theory of Algorithms',
    'CSCI 163B',
    'W',
    5,
    0,
    1
),
(
    'Computer Simulation',
    'CSCI 164',
    'FWS',
    5,
    0,
    1
),
(
    'Linear Programming',
    'CSCI 165',
    'WO',
    5,
    0,
    0
),
(
    'Numerical Analysis',
    'CSCI 166',
    'W',
    5,
    0,
    1
),
(
    'Switching Theory and Boolean Algebra',
    'CSCI 167',
    'FWS',
    5,
    0,
    0
),
(
    'Computer Graphics',
    'CSCI 168',
    'F',
    5,
    0,
    1
),
(
    'Programming Languages',
    'CSCI 169',
    'S',
    5,
    0,
    1
),
(
    'Computer Security',
    'CSCI 180',
    'F',
    5,
    0,
    1
),
(
    'Applied Cryptography',
    'CSCI 181',
    'SO',
    5,
    0,
    1
),
(
    'Digital Steganography',
    'CSCI 182',
    'FWS',
    5,
    0,
    1
),
(
    'Data Science',
    'CSCI 183',
    'WS',
    5,
    0,
    1
),
(
    'Applied Machine Learning',
    'CSCI 184',
    'S',
    5,
    0,
    1
),
(
    'The Design and Management of Software',
    'CSCI 187',
    'F',
    5,
    0,
    1
),
(
    'Advanced Topics',
    'CSCI 197',
    'FWS',
    5,
    0,
    0
),
(
    'Introduction to Embedded Systems',
    'COEN 20 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Introduction to Logic Design',
    'COEN 21 and L',
    'FWS',
    5,
    0,
    0
),
(
    'Real-Time Systems',
    'COEN 120 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Computer Architecture',
    'COEN 122 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Advanced Logic Design',
    'COEN 127 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Introduction to Parallel Programming',
    'COEN 145 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Computer Networks',
    'COEN 146 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Computer Graphics Systems',
    'COEN 148',
    'FWS',
    4,
    0,
    1
),
(
    'Introduction to Information Security',
    'COEN 150',
    'FWS',
    4,
    88,
    0
),
(
    'Introduction to Computer Forensics',
    'COEN 152 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Object-Oriented Analysis, Design, and Programming',
    'COEN 160 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Web Development',
    'COEN 161 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Web Infrastructure',
    'COEN 162',
    'FWS',
    4,
    0,
    1
),
(
    'Web Usability',
    'COEN 163 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Advanced Web Development',
    'COEN 164 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Introduction to 3D Animation and Modeling/Modeling and Control Rigid Body Dynamics',
    'COEN 165',
    'FWS',
    4,
    0,
    0
),
(
    'Artificial Intelligence',
    'COEN 166 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Mobile Application Development',
    'COEN 168 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Web Information Management',
    'COEN 169',
    'FWS',
    4,
    0,
    1
),
(
    'Principles of Design and Implementation of Programming Languages',
    'COEN 171',
    'FWS',
    4,
    0,
    1
),
(
    'Structure and Interpretation of Computer Programs',
    'COEN 172 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Logic Programming',
    'COEN 173 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Software Engineering Laboratory',
    'COEN 174 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Operating Systems',
    'COEN 177 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Introduction to Database Systems',
    'COEN 178 and L',
    'FWS',
    5,
    0,
    1
),
(
    'Introduction to Information Storage',
    'COEN 180',
    'FWS',
    4,
    0,
    1
),
(
    'Technology and Communication',
    'COMM 12',
    'FWS',
    4,
    0,
    0
),
(
    'Critical Thinking & Writing I',
    'ENGL 1A',
    'FWS',
    4,
    0,
    0
),
(
    'Critical Thinking & Writing II',
    'ENGL 2A',
    'FWS',
    4,
    0,
    1
),
(
    'Cultures and Ideas I',
    'HIST 11A',
    'FWS',
    4,
    0,
    0
),
(
    'Cultures and Ideas II',
    'HIST 12A',
    'FWS',
    4,
    0,
    1
),
(
    'Calculus and Analytic Geometry I',
    'MATH 11',
    'FWS',
    4,
    0,
    0
),
(
    'Calculus and Analytic Geometry II',
    'MATH 12',
    'FWS',
    4,
    0,
    1
),
(
    'Calculus and Analytic Geometry III',
    'MATH 13',
    'FWS',
    4,
    0,
    1
),
(
    'Calculus and Analytic Geometry IV',
    'MATH 14',
    'FWS',
    4,
    0,
    1
),
(
    'Differential Equations',
    'MATH 22',
    'FWS',
    4,
    0,
    1
),
--  Only one of MATH 22, 23, or AMTH 106 may be taken for credit
(
    'Series and Differential Equations',
    'MATH 23',
    'FWS',
    4,
    0,
    1
),
(
    'Discrete Mathematics',
    'MATH 51',
    'FWS',
    4,
    0,
    0
),
(
    'Introduction to Abstract Algebra',
    'MATH 52',
    'FWS',
    4,
    0,
    1
),
(
    'Linear Algebra',
    'MATH 53',
    'FWS',
    4,
    0,
    1
),
(
    'Writing in the Mathematical Sciences',
    'MATH 100',
    'FWS',
    5,
    0,
    1
),
(
    'A Survey of Geometry',
    'MATH 101',
    'WO',
    5,
    0,
    1
),
(
    'Advanced Calculus',
    'MATH 102',
    'F',
    5,
    0,
    1
),
(
    'Advanced Linear Algebra',
    'MATH 103',
    'F',
    5,
    0,
    1
),
(
    'Theory of Functions of a Complex Variable',
    'MATH 105',
    'WE',
    5,
    0,
    0
),
(
    'Abstract Algebra I',
    'MATH 111',
    'WE',
    5,
    0,
    1
),
(
    'Topology',
    'MATH 113',
    'SO',
    5,
    0,
    1
),
(
    'Probability and Statistics I',
    'MATH 122',
    'FW',
    5,
    0,
    1
),
(
    'Probability and Statistics II',
    'MATH 123',
    'WS',
    5,
    0,
    1
),
(
    'Mathematical Finance',
    'MATH 125',
    'S',
    5,
    0,
    1
),
(
    'Partial Differential Equations',
    'MATH 144',
    'SO',
    5,
    0,
    1
),
(
    'Intermediate Analysis I',
    'MATH 153',
    'WO',
    5,
    0,
    1
),
(
    'Ordinary Differential Equations',
    'MATH 155',
    'SE',
    5,
    0,
    1
),
(
    'Linear Programming',
    'MATH 165',
    'WO',
    5,
    0,
    0
),
(
    'Numerical Analysis',
    'MATH 166',
    'W',
    5,
    0,
    1
),
(
    'Differential Geometry',
    'MATH 174',
    'SE',
    5,
    0,
    1
),
(
    'Theory of Numbers',
    'MATH 175',
    'SO',
    5,
    0,
    1
),
(
    'Combinatorics',
    'MATH 176',
    'S',
    5,
    0,
    1
),
(
    'Graph Theory',
    'MATH 177',
    'WE',
    5,
    0,
    1
),
(
    'Cryptography',
    'MATH 178',
    'W',
    5,
    0,
    0
),
(
    'Hands-On Physics!',
    'PHYS 1',
    'FWS',
    4,
    0,
    0
),
(
    'Physics for Scientists and Engineers I',
    'PHYS 31',
    'FWS',
    4,
    0,
    1
),
(
    'Physics for Scientists and Engineers II',
    'PHYS 32',
    'FWS',
    4,
    0,
    1
),
(
    'Ways of Understanding Religion',
    'RSOC 9',
    'FWS',
    4,
    0,
    0
),
(
    'Elementary Spanish I',
    'SPAN 1',
    'F',
    4,
    0,
    1
),
(
    'Elementary Spanish II',
    'SPAN 2',
    'W',
    4,
    0,
    1
),
(
    'Upper Division CSCI/COEN Course',
    'CSCI Emphasis IV',
    'FWS',
    5,
    0,
    0
),
(
    'Upper Division CSCI/COEN Course',
    'CSCI Emphasis V',
    'FWS',
    5,
    0,
    0
),
(
    'Upper Division CSCI Course',
    'CSCI Upper I',
    'FWS',
    5,
    0,
    0
),
(
    'Upper Division CSCI Course',
    'CSCI Upper II',
    'FWS',
    5,
    0,
    0
),
(
    'MATH 102, 105, or 153',
    'MATH Group A1',
    'FWS',
    5,
    0,
    0
),
(
    'MATH 103 or 111',
    'MATH Group A2',
    'FWS',
    5,
    0,
    0
),
(
    'MATH 101, 113, 174, 176, 177, 122, 125, 144, 155, 165, or 166',
    'MATH Group A3',
    'FWS',
    5,
    0,
    0
),
(
    'Upper Division MATH/CSCI Course',
    'MATH Group B1',
    'FWS',
    5,
    0,
    0
),
(
    'Upper Division MATH/CSCI Course',
    'MATH Group B2',
    'FWS',
    5,
    0,
    0
),
(
    'Upper Division MATH/CSCI Course',
    'MATH Group B3',
    'FWS',
    5,
    0,
    0
),
(
    'Upper Division MATH/CSCI Course',
    'MATH Group B4',
    'FWS',
    5,
    0,
    0
),
(
    'Upper Division MATH Course',
    'MATH Group C1',
    'FWS',
    5,
    0,
    0
),
(
    'Upper Division MATH Course',
    'MATH Group C2',
    'FWS',
    5,
    0,
    0
),
(
    'Upper Division MATH Course',
    'MATH Group C3',
    'FWS',
    5,
    0,
    0
),
(
    'Advanced Writing',
    'Advanced Writing',
    'FWS',
    4,
    0,
    0
),
(
    'Ethics',
    'Ethics',
    'FWS',
    4,
    0,
    0
),
(
    'RTC 2',
    'RTC 2',
    'FWS',
    4,
    0,
    0
),
(
    'RTC 3',
    'RTC 3',
    'FWS',
    5,
    88,
    0
),
(
    'Culture and Ideas 3',
    'Culture and Ideas 3',
    'FWS',
    4,
    0,
    0
),
(
    'Experiential Learning and Social Justice',
    'ELSJ',
    'FWS',
    4,
    0,
    0
);

INSERT INTO CoreReqs
(
    RecommendedOrder,
    CoreReq,
    LeastCreditGiven,
    SuggestedClass
)
VALUES
(
    1,
    'CTW 1',
    4,
    'ENGL 1A'
),
(
    2,
    'Culture and Ideas 1',
    4,
    'HIST 11A'
),
(
    3,
    'Mathematics Core',
    4,
    'MATH 11'
),
(
    4,
    'CTW 2',
    4,
    'ENGL 2A'
),
(
    5,
    'Culture and Ideas 2',
    4,
    'HIST 12A'
),
(
    6,
    'Diversity',
    4,
    'CHST 4'
),
(
    7,
    'RTC 1',
    4,
    'RSOC 9'
),
(
    8,
    'Arts',
    4,
    'ARTS 30'
),
(
    9,
    'Social Science',
    4,
    'ANTH 3'
),
(
    10,
    'RTC 2',
    4,
    'RTC 2'
),
(
    11,
    'Civic Engagement',
    4,
    'CHST 4'
),
(
    12,
    'Language 1',
    4,
    'SPAN 1'
),
(
    13,
    'Advanced Writing',
    4,
    'Advanced Writing'
),
(
    14,
    'Language 2',
    4,
    'SPAN 2'
),
(
    15,
    'Ethics',
    4,
    'Ethics'
),
(
    16,
    'Culture and Ideas 3',
    4,
    'Culture and Ideas 3'
),
(
    17,
    'Science, Technology, and Society',
    4,
    'COMM 12'
),
(
    18,
    'ELSJ',
    4,
    'ANTH 3'
),
(
    19,
    'RTC 3',
    4,
    'RTC 3'
),
(
    20,
    'Natural Science',
    4,
    'PHYS 1'
);

INSERT INTO Prereqs
(
    PreReqName,
    CourseID
)
VALUES
(
	'MECH 195',
    'MECH 196'
),
(
	'MECH 194',
    'MECH 195'
),
(
	'MECH 115',
    'MECH 194'
),
(
	'MECH 141 and L',
    'MECH 160 and L'
),
(
	'MECH 123 and L',
    'MECH 160 and L'
),
(
	'MECH 141 and L',
    'MECH 142 and L'
),
(
	'MECH 140',
    'MECH 141 and L'
),
(
	'AMTH 106',
    'MECH 141 and L'
),
(
	'AMTH 106',
    'MECH 140'
),
(
	'MECH 123 and L',
    'MECH 125'
),
(
	'AMTH 118',
    'MECH 123 and L'
),
(
	'MECH 122 and L',
    'MECH 123 and L'
),
(
	'MECH 121',
    'MECH 123 and L'
),
(
	'MECH 140',
    'MECH 122 and L'
),
(
	'PHYS 32',
    'MECH 121'
),
(
	'MECH 114',
    'MECH 115'
),
(
	'CENG 43 and L',
    'MECH 114'
),
(
	'MECH 15 and L',
    'MECH 114'
),
(
	'MECH 10 and L',
    'MECH 114'
),
/* MECH101 L Co-Req is MECH194*/
(
	'MECH 15 and L',
    'MECH 11'
),
/*ELEN 50 and L Co-Req is PHY 33 */
(
	'MATH 13',
    'COEN 44 and L'
),
(
	'CENG 41',
    'CENG 43 and L'
),
(
	'PHYS 31',
    'CENG 41'
),
(
	'CHEM 11 and L',
    'MECH 15 and L'
),
(
	'PHYS 32',
    'PHYS 33'
),
(
	'MATH 12',
    'PHYS 32'
),
(
	'MATH 11',
    'PHYS 31'
),
(
	'COEN 10 and L',
    'COEN 11 and L'
),
(
	'AMTH 118',
    'COEN 11 and L'
),
(
	'AMTH 106',
    'AMTH 118'
),
(
	'ENGL 2A',
    'ENGL 181'
),
(
	'ENGL 1A',
    'ENGL 181'
),
(
	'MATH 13',
    'AMTH 106'
),
(
    'CSCI 10 and L',
    'CSCI 60 and L'
),
(
    'CSCI 60 and L',
    'CSCI 61'
),
(
    'MATH 11',
    'MATH 12'
),
(
    'MATH 12',
    'MATH 13'
),
(
    'MATH 13',
    'MATH 14'
),
(
    'CSCI 60 and L',
    'COEN 20 and L'
),
(
    'MATH 13',
    'MATH 53'
),
(
    'MATH 51',
    'CSCI 161'
),
(
    'CSCI 61',
    'CSCI 163A'
),
(
    'MATH 51',
    'CSCI 163A'
),
(
    'MATH 14',
    'MATH 122'
),
(
    'COEN 20 and L',
    'COEN 177 and L'
),
(
    'CSCI 61',
    'COEN 177 and L'
),
(
    'CSCI 161',
    'CSCI 162'
),
(
    'CSCI 163A',
    'CSCI 163B'
),
(
    'MATH 51',
    'MATH 177'
),
(
    'CSCI 61',
    'CSCI 183'
),
(
    'MATH 53',
    'CSCI 183'
),
(
    'MATH 122',
    'CSCI 183'
),
(
    'CSCI 183',
    'CSCI 184'
),
(
    'MATH 53',
    'MATH 123'
),
(
    'MATH 122',
    'MATH 123'
),
(
    'CSCI 61',
    'CSCI 169'
),
(
    'MATH 51',
    'CSCI 169'
),
(
    'CSCI 61',
    'CSCI 187'
),
(
    'CSCI 61',
    'COEN 146 and L'
),
(
    'COEN 20 and L',
    'CSCI 180'
),
(
    'MATH 178',
    'CSCI 181'
),
(
    'CSCI 10 and L',
    'CSCI 181'
),
(
    'CSCI 10 and L',
    'CSCI 166'
),
(
    'MATH 53',
    'CSCI 166'
),
(
    'CSCI 10 and L',
    'CSCI 168'
),
(
    'MATH 13',
    'CSCI 168'
),
(
    'CSCI 61',
    'COEN 120 and L'
),
(
    'COEN 20 and L',
    'COEN 122 and L'
),
(
    'COEN 21 and L',
    'COEN 122 and L'
),
(
    'COEN 21 and L',
    'COEN 127 and L'
),
(
    'CSCI 61',
    'COEN 145 and L'
),
(
    'CSCI 61',
    'COEN 148'
),
(
    'MATH 53',
    'COEN 148'
),
(
    'CSCI 61',
    'COEN 152 and L'
),
(
    'COEN 20 and L',
    'COEN 152 and L'
),
(
    'CSCI 61',
    'COEN 160 and L'
),
(
    'CSCI 61',
    'COEN 161 and L'
),
(
    'COEN 146 and L',
    'COEN 162'
),
(
    'CSCI 61',
    'COEN 163 and L'
),
(
    'COEN 161 and L',
    'COEN 164 and L'
),
(
    'CSCI 61',
    'COEN 166 and L'
),
(
    'MATH 51',
    'COEN 166 and L'
),
(
    'COEN 20 and L',
    'COEN 168 and L'
),
(
    'CSCI 61',
    'COEN 169'
),
(
    'MATH 122',
    'COEN 169'
),
(
    'CSCI 61',
    'COEN 171'
),
(
    'CSCI 61',
    'COEN 172 and L'
),
(
    'MATH 51',
    'COEN 172 and L'
),
(
    'CSCI 61',
    'COEN 173 and L'
),
(
    'MATH 51',
    'COEN 173 and L'
),
(
    'CSCI 61',
    'COEN 174 and L'
),
(
    'CSCI 61',
    'COEN 178 and L'
),
(
    'CSCI 61',
    'COEN 180'
),
(
    'MATH 13',
    'MATH 101'
),
(
    'MATH 52',
    'MATH 175'
),
(
    'MATH 51',
    'MATH 176'
),
(
    'MATH 51',
    'MATH 52'
),
(
    'MATH 14',
    'MATH 102'
),
(
    'MATH 51',
    'MATH 102'
),
(
    'MATH 53',
    'MATH 102'
),
(
    'MATH 53',
    'MATH 103'
),
(
    'MATH 52',
    'MATH 111'
),
(
    'MATH 53',
    'MATH 111'
),
(
    'MATH 14',
    'MATH 113'
),
(
    'MATH 51',
    'MATH 113'
),
(
    'MATH 53',
    'MATH 125'
),
(
    'MATH 122',
    'MATH 125'
),
--  Prereq missing in catalog, found on CourseAvail Fall 2019
(
    'MATH 14',
    'MATH 144'
),
(
    'MATH 51',
    'MATH 153'
),
--  either 102 or 105
(
    'MATH 102',
    'MATH 153'
),
(
    'MATH 53',
    'MATH 155'
),
(
    'CSCI 10 and L',
    'MATH 166'
),
(
    'MATH 53',
    'MATH 166'
),
(
    'MATH 53',
    'MATH 174'
),
(
    'PHYS 31',
    'PHYS 32'
),
(
    'ENGL 1A',
    'ENGL 2A'
),
(
    'HIST 11A',
    'HIST 12A'
),
(
    'SPAN 1',
    'SPAN 2'
);

INSERT INTO MajorReqs
(
    RecommendedOrder,
    CourseID,
    MajorName
)
VALUES
(
	1,
    'MATH 11',
    'Mechanical Engineering'
),
(
	2,
    'MECH 10 and L',
    'Mechanical Engineering'
),
(
	3,
    'CHEM 11 and L',
    'Mechanical Engineering'
),
(
	4,
    'ENGR 1 and L',
    'Mechanical Engineering'
),
(
	5,
    'MATH 12',
    'Mechanical Engineering'
),
(
	6,
    'PHYS 31',
    'Mechanical Engineering'
),
(
	7,
    'MATH 13',
    'Mechanical Engineering'
),
(
	8,
    'MECH 15 and L',
    'Mechanical Engineering'
),
(
	9,
    'PHYS 32',
    'Mechanical Engineering'
),
(
	10,
    'MATH 14',
    'Mechanical Engineering'
),
(
	11,
    'PHYS 33',
    'Mechanical Engineering'
),
(
	12,
    'CENG 41',
    'Mechanical Engineering'
),
(
	13,
    'COEN 44 and L',
    'Mechanical Engineering'
),
(
	14,
    'AMTH 106',
    'Mechanical Engineering'
),
(
	15,
    'MECH 11',
    'Mechanical Engineering'
),
(
	16,
    'ELEN 50 and L',
    'Mechanical Engineering'
),
(
	17,
    'MECH 102',
    'Mechanical Engineering'
),
(
	18,
    'MECH 121',
    'Mechanical Engineering'
),
(
	19,
    'MECH 140',
    'Mechanical Engineering'
),
(
	20,
    'CENG 43 and L',
    'Mechanical Engineering'
),
(
	21,
    'AMTH 118',
    'Mechanical Engineering'
),
(
	22,
    'MECH 122 and L',
    'Mechanical Engineering'
),
(
	23,
    'MECH 123 and L',
    'Mechanical Engineering'
),
(
	24,
    'MECH 141 and L',
    'Mechanical Engineering'
),
(
	25,
    'MECH 114',
    'Mechanical Engineering'
),
(
	26,
    'MECH 125',
    'Mechanical Engineering'
),
(
	27,
    'MECH 142 and L',
    'Mechanical Engineering'
),
(
	28,
    'MECH 115',
    'Mechanical Engineering'
),
(
	29,
    'MECH 160 and L',
    'Mechanical Engineering'
),
(
	30,
    'MECH 101L',
    'Mechanical Engineering'
),
(
	31,
    'MECH 194',
    'Mechanical Engineering'
),
(
	32,
    'MECH 195',
    'Mechanical Engineering'
),
(
	33,
    'MECH 196',
    'Mechanical Engineering'
),
(
	34,
    'MECH Upper Div Elective I',
    'Mechanical Engineering'
),
(
	35,
    'MECH Upper Div Elective II',
    'Mechanical Engineering'
),
(
    1,
    'CSCI 10 and L',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    2,
    'CSCI 60 and L',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    3,
    'CSCI 61',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    4,
    'MATH 11',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    5,
    'MATH 12',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    6,
    'MATH 13',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    7,
    'MATH 14',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    9,
    'COEN 20 and L',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    12,
    'COEN 21 and L',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    8,
    'MATH 51',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    10,
    'MATH 53',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    17,
    'CSCI 161',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    11,
    'CSCI 163A',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    14,
    'MATH 122',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    13,
    'COEN 177 and L',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    15,
    'CSCI 162',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    16,
    'CSCI 163B',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    18,
    'MATH 177',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    19,
    'CSCI Emphasis IV',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    20,
    'CSCI Emphasis V',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    1,
    'CSCI 10 and L',
    'Computer Science, Data Science Emphasis'
),
(
    2,
    'CSCI 60 and L',
    'Computer Science, Data Science Emphasis'
),
(
    3,
    'CSCI 61',
    'Computer Science, Data Science Emphasis'
),
(
    4,
    'MATH 11',
    'Computer Science, Data Science Emphasis'
),
(
    5,
    'MATH 12',
    'Computer Science, Data Science Emphasis'
),
(
    6,
    'MATH 13',
    'Computer Science, Data Science Emphasis'
),
(
    7,
    'MATH 14',
    'Computer Science, Data Science Emphasis'
),
(
    9,
    'COEN 20 and L',
    'Computer Science, Data Science Emphasis'
),
(
    12,
    'COEN 21 and L',
    'Computer Science, Data Science Emphasis'
),
(
    8,
    'MATH 51',
    'Computer Science, Data Science Emphasis'
),
(
    10,
    'MATH 53',
    'Computer Science, Data Science Emphasis'
),
(
    17,
    'CSCI 161',
    'Computer Science, Data Science Emphasis'
),
(
    11,
    'CSCI 163A',
    'Computer Science, Data Science Emphasis'
),
(
    14,
    'MATH 122',
    'Computer Science, Data Science Emphasis'
),
(
    13,
    'COEN 177 and L',
    'Computer Science, Data Science Emphasis'
),
(
    15,
    'CSCI 183',
    'Computer Science, Data Science Emphasis'
),
(
    16,
    'CSCI 184',
    'Computer Science, Data Science Emphasis'
),
(
    18,
    'MATH 123',
    'Computer Science, Data Science Emphasis'
),
(
    19,
    'CSCI Emphasis IV',
    'Computer Science, Data Science Emphasis'
),
(
    20,
    'CSCI Emphasis V',
    'Computer Science, Data Science Emphasis'
),
(
    1,
    'CSCI 10 and L',
    'Computer Science, Software Emphasis'
),
(
    2,
    'CSCI 60 and L',
    'Computer Science, Software Emphasis'
),
(
    3,
    'CSCI 61',
    'Computer Science, Software Emphasis'
),
(
    4,
    'MATH 11',
    'Computer Science, Software Emphasis'
),
(
    5,
    'MATH 12',
    'Computer Science, Software Emphasis'
),
(
    6,
    'MATH 13',
    'Computer Science, Software Emphasis'
),
(
    7,
    'MATH 14',
    'Computer Science, Software Emphasis'
),
(
    9,
    'COEN 20 and L',
    'Computer Science, Software Emphasis'
),
(
    12,
    'COEN 21 and L',
    'Computer Science, Software Emphasis'
),
(
    8,
    'MATH 51',
    'Computer Science, Software Emphasis'
),
(
    10,
    'MATH 53',
    'Computer Science, Software Emphasis'
),
(
    17,
    'CSCI 161',
    'Computer Science, Software Emphasis'
),
(
    11,
    'CSCI 163A',
    'Computer Science, Software Emphasis'
),
(
    14,
    'MATH 122',
    'Computer Science, Software Emphasis'
),
(
    13,
    'COEN 177 and L',
    'Computer Science, Software Emphasis'
),
(
    15,
    'CSCI 169',
    'Computer Science, Software Emphasis'
),
(
    16,
    'CSCI 187',
    'Computer Science, Software Emphasis'
),
(
    18,
    'COEN 146 and L',
    'Computer Science, Software Emphasis'
),
(
    19,
    'CSCI Emphasis IV',
    'Computer Science, Software Emphasis'
),
(
    20,
    'CSCI Emphasis V',
    'Computer Science, Software Emphasis'
),
(
    1,
    'CSCI 10 and L',
    'Computer Science, Security Emphasis'
),
(
    2,
    'CSCI 60 and L',
    'Computer Science, Security Emphasis'
),
(
    3,
    'CSCI 61',
    'Computer Science, Security Emphasis'
),
(
    4,
    'MATH 11',
    'Computer Science, Security Emphasis'
),
(
    5,
    'MATH 12',
    'Computer Science, Security Emphasis'
),
(
    6,
    'MATH 13',
    'Computer Science, Security Emphasis'
),
(
    7,
    'MATH 14',
    'Computer Science, Security Emphasis'
),
(
    9,
    'COEN 20 and L',
    'Computer Science, Security Emphasis'
),
(
    12,
    'COEN 21 and L',
    'Computer Science, Security Emphasis'
),
(
    8,
    'MATH 51',
    'Computer Science, Security Emphasis'
),
(
    10,
    'MATH 53',
    'Computer Science, Security Emphasis'
),
(
    17,
    'CSCI 161',
    'Computer Science, Security Emphasis'
),
(
    11,
    'CSCI 163A',
    'Computer Science, Security Emphasis'
),
(
    14,
    'MATH 122',
    'Computer Science, Security Emphasis'
),
(
    13,
    'COEN 177 and L',
    'Computer Science, Security Emphasis'
),
(
    15,
    'MATH 178',
    'Computer Science, Security Emphasis'
),
(
    16,
    'CSCI 180',
    'Computer Science, Security Emphasis'
),
(
    18,
    'CSCI 181',
    'Computer Science, Security Emphasis'
),
(
    19,
    'CSCI Emphasis IV',
    'Computer Science, Security Emphasis'
),
(
    20,
    'CSCI Emphasis V',
    'Computer Science, Security Emphasis'
),
(
    1,
    'MATH 11',
    'Mathematics'
),
(
    2,
    'MATH 12',
    'Mathematics'
),
(
    3,
    'MATH 13',
    'Mathematics'
),
(
    4,
    'MATH 14',
    'Mathematics'
),
(
    5,
    'PHYS 31',
    'Mathematics'
),
(
    6,
    'PHYS 32',
    'Mathematics'
),
(
    7,
    'MATH 51',
    'Mathematics'
),
(
    8,
    'MATH 52',
    'Mathematics'
),
(
    9,
    'MATH 53',
    'Mathematics'
),
(
    10,
    'CSCI 10 and L',
    'Mathematics'
),
(
    11,
    'MATH 23',
    'Mathematics'
),
(
    12,
    'MATH Group A1',
    'Mathematics'
),
(
    13,
    'MATH Group B1',
    'Mathematics'
),
(
    14,
    'MATH Group A3',
    'Mathematics'
),
(
    15,
    'MATH Group B2',
    'Mathematics'
),
(
    16,
    'MATH Group A2',
    'Mathematics'
),
(
    17,
    'MATH Group B3',
    'Mathematics'
),
(
    18,
    'MATH Group B4',
    'Mathematics'
);

INSERT INTO HighlySuggestedClasses
(
    RecommendedOrder,
    CourseID,
    MajorName
)
VALUES
(
    1,
    'MATH 175',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    2,
    'MATH 176',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    3,
    'MATH 178',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    4,
    'CSCI 165',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    5,
    'CSCI 181',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    6,
    'MATH 101',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    7,
    'MATH 103',
    'Computer Science, Algorithms and Complexity Emphasis'
),
(
    1,
    'CSCI 164',
    'Computer Science, Data Science Emphasis'
),
(
    2,
    'CSCI 166',
    'Computer Science, Data Science Emphasis'
),
(
    3,
    'COEN 166 and L',
    'Computer Science, Data Science Emphasis'
),
(
    4,
    'COEN 122 and L',
    'Computer Science, Data Science Emphasis'
),
(
    5,
    'COEN 178 and L',
    'Computer Science, Data Science Emphasis'
),
(
    6,
    'COEN 146 and L',
    'Computer Science, Data Science Emphasis'
),
(
    1,
    'COEN 178 and L',
    'Computer Science, Software Emphasis'
),
(
    2,
    'COEN 122 and L',
    'Computer Science, Software Emphasis'
),
(
    3,
    'COEN 161 and L',
    'Computer Science, Software Emphasis'
),
(
    4,
    'CSCI 183',
    'Computer Science, Software Emphasis'
),
(
    5,
    'CSCI 168',
    'Computer Science, Software Emphasis'
),
(
    6,
    'CSCI 164',
    'Computer Science, Software Emphasis'
),
(
    7,
    'CSCI 184',
    'Computer Science, Software Emphasis'
),
(
    1,
    'COEN 146 and L',
    'Computer Science, Security Emphasis'
),
(
    2,
    'COEN 152 and L',
    'Computer Science, Security Emphasis'
),
(
    3,
    'COEN 161 and L',
    'Computer Science, Security Emphasis'
),
(
    4,
    'MATH 175',
    'Computer Science, Security Emphasis'
),
(
    5,
    'COEN 178 and L',
    'Computer Science, Security Emphasis'
),
(
    6,
    'COEN 122 and L',
    'Computer Science, Security Emphasis'
),
(
    7,
    'CSCI 169',
    'Computer Science, Security Emphasis'
);

INSERT INTO MinorReqs
(
    RecommendedOrder,
    CourseID,
    MinorName
)
VALUES
(
    1,
    'MATH 11',
    'Mathematics'
),
(
    2,
    'MATH 12',
    'Mathematics'
),
(
    3,
    'MATH 13',
    'Mathematics'
),
(
    4,
    'MATH 14',
    'Mathematics'
),
(
    5,
    'MATH 53',
    'Mathematics'
),
(
    6,
    'MATH Group C1',
    'Mathematics'
),
(
    7,
    'MATH Group C2',
    'Mathematics'
),
(
    8,
    'MATH Group C3',
    'Mathematics'
),
(
    1,
    'CSCI 10 and L',
    'Computer Science'
),
(
    2,
    'CSCI 60 and L',
    'Computer Science'
),
(
    3,
    'CSCI 61',
    'Computer Science'
),
(
    4,
    'MATH 51',
    'Computer Science'
),
(
    5,
    'COEN 20 and L',
    'Computer Science'
),
(
    6,
    'CSCI Upper I',
    'Computer Science'
),
(
    7,
    'CSCI Upper II',
    'Computer Science'
),
(
    8,
    'CSCI Emphasis IV',
    'Computer Science'
);

INSERT INTO CoreClasses
(
    CourseID,
    CoreReq
)
VALUES
(
    'MATH 11',
    'Mathematics Core'
),
(
    'CSCI 10 and L',
    'Science, Technology, and Society'
),
(
    'PHYS 31',
    'Natural Science'
);

--  DELETE FROM ConditionalReqs;

--  --  CSCI Algorithms Emphasis
--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'CSCI Emphasis IV',
--      CourseID,
--      'Computer Science, Algorithms and Complexity Emphasis'
--  FROM
--      Classes
--  WHERE
--      CourseID = 'MATH 175' OR
--      CourseID = 'MATH 176' OR
--      CourseID = 'MATH 178' OR
--      CourseID = 'MATH 101' OR
--      CourseID REGEXP 'CSCI 1[0-9]{2}' OR
--      CourseID REGEXP 'COEN 1[0-9]{2}'
--  ;

--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'CSCI Emphasis V',
--      CourseID,
--      'Computer Science, Algorithms and Complexity Emphasis'
--  FROM
--      Classes
--  WHERE
--      CourseID = 'MATH 175' OR
--      CourseID = 'MATH 176' OR
--      CourseID = 'MATH 178' OR
--      CourseID = 'MATH 101' OR
--      CourseID REGEXP 'CSCI 1[0-9]{2}' OR
--      CourseID REGEXP 'COEN 1[0-9]{2}'
--  ;

--  --  CSCI Data Science Emphasis
--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'CSCI Emphasis IV',
--      CourseID,
--      'Computer Science, Data Science Emphasis'
--  FROM
--      Classes
--  WHERE
--      CourseID REGEXP 'CSCI 1[0-9]{2}' OR
--      CourseID REGEXP 'COEN 1[0-9]{2}'
--  ;

--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'CSCI Emphasis V',
--      CourseID,
--      'Computer Science, Data Science Emphasis'
--  FROM
--      Classes
--  WHERE
--      CourseID REGEXP 'CSCI 1[0-9]{2}' OR
--      CourseID REGEXP 'COEN 1[0-9]{2}'
--  ;

--  --  CSCI Software Emphasis
--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'CSCI Emphasis IV',
--      CourseID,
--      'Computer Science, Software Emphasis'
--  FROM
--      Classes
--  WHERE
--      CourseID REGEXP 'CSCI 1[0-9]{2}';
--  ;

--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'CSCI Emphasis V',
--      CourseID,
--      'Computer Science, Software Emphasis'
--  FROM
--      Classes
--  WHERE
--      CourseID REGEXP 'CSCI 1[0-9]{2}' OR
--      CourseID REGEXP 'COEN 1[0-9]{2}'
--  ;

--  --  CSCI Security Emphasis
--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'CSCI Emphasis IV',
--      CourseID,
--      'Computer Science, Security Emphasis'
--  FROM
--      Classes
--  WHERE
--      CourseID = 'MATH 175' OR
--      CourseID REGEXP 'CSCI 1[0-9]{2}' OR
--      CourseID REGEXP 'COEN 1[0-9]{2}'
--  ;

--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'CSCI Emphasis V',
--      CourseID,
--      'Computer Science, Security Emphasis'
--  FROM
--      Classes
--  WHERE
--      CourseID = 'MATH 175' OR
--      CourseID REGEXP 'CSCI 1[0-9]{2}' OR
--      CourseID REGEXP 'COEN 1[0-9]{2}'
--  ;

--  --  MATH Groups A1-3, B1-4
--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'MATH Group A1',
--      CourseID,
--      'Mathematics'
--  FROM
--      Classes
--  WHERE
--      CourseID = 'MATH 102' OR
--      CourseID = 'MATH 105' OR
--      CourseID = 'MATH 153'
--  ;

--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'MATH Group A2',
--      CourseID,
--      'Mathematics'
--  FROM
--      Classes
--  WHERE
--      CourseID = 'MATH 103' OR
--      CourseID = 'MATH 111'
--  ;

--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'MATH Group A3',
--      CourseID,
--      'Mathematics'
--  FROM
--      Classes
--  WHERE
--      CourseID = 'MATH 101' OR
--      CourseID = 'MATH 113' OR
--      CourseID = 'MATH 122' OR
--      CourseID = 'MATH 125' OR
--      CourseID = 'MATH 144' OR
--      CourseID = 'MATH 155' OR
--      CourseID = 'MATH 165' OR
--      CourseID = 'MATH 166' OR
--      CourseID = 'MATH 174' OR
--      CourseID = 'MATH 176' OR
--      CourseID = 'MATH 177'
--  ;

--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'MATH Group B1',
--      CourseID,
--      'Mathematics'
--  FROM
--      Classes
--  WHERE
--      CourseID REGEXP 'MATH 1[0-9]{2}' OR
--      CourseID REGEXP 'CSCI 1[0-9]{2}'
--  AND
--      CourseID != 'MATH 100'
--  ;

--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'MATH Group B2',
--      CourseID,
--      'Mathematics'
--  FROM
--      Classes
--  WHERE
--      CourseID REGEXP 'MATH 1[0-9]{2}' OR
--      CourseID REGEXP 'CSCI 1[0-9]{2}'
--  AND
--      CourseID != 'MATH 100'
--  ;

--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'MATH Group B3',
--      CourseID,
--      'Mathematics'
--  FROM
--      Classes
--  WHERE
--      CourseID REGEXP 'MATH 1[0-9]{2}' OR
--      CourseID REGEXP 'CSCI 1[0-9]{2}'
--  AND
--      CourseID != 'MATH 100'
--  ;

--  INSERT INTO ConditionalReqs
--  (
--      ConditionalID,
--      CourseID,
--      MajorName
--  )
--  SELECT
--      'MATH Group B4',
--      CourseID,
--      'Mathematics'
--  FROM
--      Classes
--  WHERE
--      CourseID REGEXP 'MATH 1[0-9]{2}' OR
--      CourseID REGEXP 'CSCI 1[0-9]{2}'
--  AND
--      CourseID != 'MATH 100'
--  ;

SELECT * FROM SCUSchools;
SELECT * FROM MajornEmphasis;
SELECT * FROM Minors;
SELECT * FROM Classes;
SELECT * FROM CoreReqs;
SELECT * FROM CoreClasses;
SELECT * FROM Prereqs;
SELECT * FROM MajorReqs;
SELECT * FROM HighlySuggestedClasses;
SELECT * FROM MinorReqs;
