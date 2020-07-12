-- CREATE TABLE department(
-- 	id INT PRIMARY KEY,
-- 	name VARCHAR(50) 
-- );
TRUNCATE TABLE department CASCADE;
INSERT INTO department VALUES (1, 'Engineering');
INSERT INTO department VALUES (2, 'Computer Science');
INSERT INTO department VALUES (3, 'Philosophy');

-- CREATE TABLE degree(
-- 	id SERIAL PRIMARY KEY,
-- 	name TEXT NOT NULL UNIQUE,
-- 	required_units INT NOT NULL,
-- 	degree_type  TEXT NOT NULL,
-- 	department_id INT REFERENCES department(id)	ON DELETE CASCADE ON UPDATE CASCADE
-- );
TRUNCATE TABLE degree CASCADE;
INSERT INTO degree VALUES (1, 'B.S. in Computer Science', 40, 'BS', 2);
INSERT INTO degree VALUES (2, 'B.S. in Philosophy', 35, 'BS', 3);
INSERT INTO degree VALUES (3, 'B.S. in Mechanical Engineering', 50, 'BS', 1);
INSERT INTO degree VALUES (4, 'M.S. in Computer Science', 45, 'MS', 2);

-- CREATE TABLE student(
--    id          INT      PRIMARY KEY   NOT NULL,
--    ssn         INT      NOT NULL UNIQUE,
--    firstName   VARCHAR(50) NOT NULL,
--    middleName  VARCHAR(50),
--    lastName    VARCHAR(50) NOT NULL,
--    residency   INT      NOT NULL,
--    enrollment  BOOLEAN      NOT NULL,
--    level       INT      NOT NULL,
--    degree      INT      REFERENCES degree(id) ON DELETE CASCADE ON UPDATE CASCADE,
--    start_date  DATE NOT NULL,
--    end_date	   DATE NOT NULL
-- );
TRUNCATE TABLE student CASCADE;
INSERT INTO student VALUES (1, 1, 'Benjamin', '', 'B', 0, 'true', 0, 1, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (2, 2, 'Kristen', '', 'W', 0, 'true', 0, 1, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (3, 3, 'Daniel', '', 'F', 0, 'true', 0, 1, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (4, 4, 'Claire', '', 'J', 0, 'true', 0, 1, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (5, 5, 'Julie', '', 'C', 0, 'true', 0, 1, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (6, 6, 'Kevin', '', 'L', 0, 'true', 0, 3, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (7, 7, 'Michael', '', 'B', 0, 'true', 0, 3, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (8, 8, 'Joseph', '', 'J', 0, 'true', 0, 3, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (9, 9, 'Devin', '', 'P', 0, 'true', 0, 3, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (10, 10, 'Logan', '', 'F', 0, 'true', 0, 3, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (11, 11, 'Vikram', '', 'N', 0, 'true', 0, 2, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (12, 12, 'Rachel', '', 'Z', 0, 'true', 0, 2, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (13, 13, 'Zach', '', 'M', 0, 'true', 0, 2, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (14, 14, 'Justin', '', 'H', 0, 'true', 0, 2, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (15, 15, 'Rahul', '', 'R', 0, 'true', 0, 2, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (16, 16, 'Dave', '', 'C', 0, 'true', 1, 4, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (17, 17, 'Nelson', '', 'H', 0, 'true', 1, 4, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (18, 18, 'Andrew', '', 'P', 0, 'true', 1, 4, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (19, 19, 'Nathan', '', 'S', 0, 'true', 1, 4, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (20, 20, 'John', '', 'H', 0, 'true', 1, 4, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (21, 21, 'Anwell', '', 'W', 0, 'true', 1, 4, '2019-09-01', '2022-06-12');
INSERT INTO student VALUES (22, 22, 'Tim', '', 'K', 0, 'true', 1, 4, '2019-09-01', '2022-06-12');

-- CREATE TABLE student_enrollment(
-- 	id 		  	SERIAL PRIMARY KEY,
-- 	studentid   INT REFERENCES student(id),
-- 	year INT,
-- 	quarter INT
-- );
TRUNCATE TABLE student_enrollment CASCADE;
INSERT INTO student_enrollment VALUES (DEFAULT, 1, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 2, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 3, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 4, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 5, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 6, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 7, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 8, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 9, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 10, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 11, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 12, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 13, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 14, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 15, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 16, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 17, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 18, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 19, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 20, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 21, 2020, 3);
INSERT INTO student_enrollment VALUES (DEFAULT, 22, 2020, 3);

-- CREATE TABLE undergraduate(
-- 	underid SERIAL PRIMARY KEY,
-- 	id  INT REFERENCES student(id) UNIQUE,
-- 	college VARCHAR(50) NOT NULL,
-- 	major VARCHAR(50),
-- 	minor VARCHAR(50)
-- );
TRUNCATE TABLE undergraduate CASCADE;
INSERT INTO undergraduate VALUES (DEFAULT, 1, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT, 2, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT, 3, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT, 4, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT, 5, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT, 6, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT, 7, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT, 8, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT, 9, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT, 10, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT, 11, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT, 12, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT, 13, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT, 14, 'six', 'math', 'music');
INSERT INTO undergraduate VALUES (DEFAULT,15, 'six', 'math', 'music');


-- CREATE TABLE faculty(
-- 	name VARCHAR(50) PRIMARY KEY NOT NULL,
-- 	title INT,
-- 	department INT REFERENCES department(id)
-- );
TRUNCATE TABLE faculty CASCADE;
INSERT INTO faculty VALUES ('Justin Bieber', 2, 2);
INSERT INTO faculty VALUES ('Flo Rida', 3, 3);
INSERT INTO faculty VALUES ('Selena Gomez', 3, 2);
INSERT INTO faculty VALUES ('Adele', 3, 1);
INSERT INTO faculty VALUES ('Taylor Swift', 3, 2);
INSERT INTO faculty VALUES ('Kelly Clarkson', 3, 2);
INSERT INTO faculty VALUES ('Adam Levine', 3, 3);
INSERT INTO faculty VALUES ('Bjork', 3, 1);

INSERT INTO faculty VALUES ('TBA', 1, 1);
-- CREATE TABLE graduate(
-- 	graduateid SERIAL PRIMARY KEY,
-- 	id  INT REFERENCES student(id) NOT NULL UNIQUE,
-- 	department  INT REFERENCES department(id),
-- 	classification INT NOT NULL,
-- 	advisor VARCHAR(50) REFERENCES faculty(name)
-- );
TRUNCATE TABLE graduate CASCADE;
INSERT INTO graduate VALUES (DEFAULT, 16, 1, 0, 'Adele');
INSERT INTO graduate VALUES (DEFAULT, 17, 1, 0, 'Adele');
INSERT INTO graduate VALUES (DEFAULT, 18, 1, 0, 'Adele');
INSERT INTO graduate VALUES (DEFAULT, 19, 1, 0, 'Adele');
INSERT INTO graduate VALUES (DEFAULT, 20, 1, 0, 'Adele');
INSERT INTO graduate VALUES (DEFAULT, 21, 1, 0, 'Adele');
INSERT INTO graduate VALUES (DEFAULT, 22, 1, 0, 'Adele');


-- CREATE TABLE thesis(
-- 	id INT PRIMARY KEY,
-- 	studentid INT REFERENCES student(id)
-- );
TRUNCATE TABLE thesis CASCADE;
INSERT INTO thesis VALUES (0,2);

-- CREATE TABLE thesis_instructor(
-- 	id SERIAL PRIMARY KEY,
-- 	thesisId INT REFERENCES thesis(id) ON DELETE CASCADE ON UPDATE CASCADE,
--  	department INT REFERENCES department(id) ON DELETE CASCADE ON UPDATE CASCADE,
--  	faculty_name VARCHAR(50) UNIQUE REFERENCES faculty(name) 
-- );
TRUNCATE TABLE thesis_instructor CASCADE;
INSERT INTO thesis_instructor VALUES (DEFAULT, 0, 1, 'Adele');
INSERT INTO thesis_instructor VALUES (DEFAULT, 0, 1, 'Flo Rida');
INSERT INTO thesis_instructor VALUES (DEFAULT, 0, 1, 'Bjork');

--
--	id SERIAL PRIMARY KEY,
--	code VARCHAR(50) UNIQUE NOT NULL, -- CSE132B
--	grade_option INT NOT NULL, -- letter/su/both       0/1/2
--	ctype INT,  -- upper/low?     0/1
--	consent BOOLEAN NOT NULL, -- require consent of instructor or not
--	minunit INT NOT NULL,
--	maxunit INT NOT NULL,
--	department INT REFERENCES department(id),
--	lab BOOLEAN NOT NULL -- has lab or not
--

TRUNCATE TABLE course CASCADE;
INSERT INTO course VALUES (1, 'CSE8A', 2, 1, 'true', 2, 4, 2, 'false');
INSERT INTO course VALUES (2, 'CSE105', 2, 0, 'true', 2, 4, 2, 'false');
INSERT INTO course VALUES (3, 'CSE123', 2, 0, 'true', 2, 4, 2, 'false');
INSERT INTO course VALUES (4, 'CSE250A', 2, 0, 'true', 2, 4, 2, 'false');
INSERT INTO course VALUES (5, 'CSE250B', 2, 0, 'true', 2, 4, 2, 'false');
INSERT INTO course VALUES (6, 'CSE255', 2, 0, 'true', 2, 4, 2, 'false');
INSERT INTO course VALUES (7, 'CSE232A', 2, 0, 'true', 2, 4, 2, 'false');
INSERT INTO course VALUES (8, 'CSE221', 2, 0, 'true', 2, 4, 2, 'false');

INSERT INTO course VALUES (9, 'MAE3', 2, 1, 'true', 2, 4, 1, 'false');
INSERT INTO course VALUES (10, 'MAE107', 2, 0, 'true', 2, 4, 1, 'false');
INSERT INTO course VALUES (11, 'MAE108', 2, 0, 'true', 2, 4, 1, 'false');

INSERT INTO course VALUES (12, 'PHIL10', 2, 1, 'true', 2, 4, 3, 'false');
INSERT INTO course VALUES (13, 'PHIL12', 2, 1, 'true', 2, 4, 3, 'false');
INSERT INTO course VALUES (14, 'PHIL165', 2, 0, 'true', 2, 4, 3, 'false');
INSERT INTO course VALUES (15, 'PHIL167', 2, 0, 'true', 2, 4, 3, 'false');


-- CREATE TABLE concentration (
--   id INT PRIMARY KEY,
--   name text NOT NULL UNIQUE,
--   gpa FLOAT(2) NOT NULL,
--   degreeid INT NOT NULL REFERENCES degree(id),
--   unit INT NOT NULL
-- );

TRUNCATE TABLE concentration CASCADE;
INSERT INTO concentration VALUES (1, 'Databases',3,4,4);
INSERT INTO concentration VALUES (2, 'AI', 3.1,4,8);
INSERT INTO concentration VALUES (3, 'Systems',3.3,4, 4);

-- CREATE TABLE concentration_course (
--   id SERIAL PRIMARY KEY,
--   idconcentration integer REFERENCES concentration(id) ,
--   idcourse integer REFERENCES course(id) 
-- );

TRUNCATE TABLE concentration_course CASCADE;
INSERT INTO concentration_course VALUES (DEFAULT, 1, 7);
INSERT INTO concentration_course VALUES (DEFAULT, 2, 4);
INSERT INTO concentration_course VALUES (DEFAULT, 2, 6);
INSERT INTO concentration_course VALUES (DEFAULT, 3, 8);


-- CREATE TABLE class(
-- 	 id INT PRIMARY KEY NOT NULL,
-- 	 title VARCHAR(50) NOT NULL,
-- 	 year INT,
-- 	 quarter INT, 1FALL 2WINTER 3SPRING 4SUMMERI 5SUMMERII
-- 	 courseid INT REFERENCES course(id)
-- );


TRUNCATE TABLE class CASCADE;
INSERT INTO class VALUES (0, 'Introduction to Computer Science: Java', 2017, 2, 1);
INSERT INTO class VALUES (1, 'Introduction to Computer Science: Java', 2017, 1, 1);
INSERT INTO class VALUES (2, 'Introduction to Computer Science: Java', 2018, 1, 1);
INSERT INTO class VALUES (3, 'Introduction to Computer Science: Java', 2021, 3, 1);
INSERT INTO class VALUES (9, 'Introduction to Computer Science: Java', 2020, 3, 1);

INSERT INTO class VALUES (4, 'Intro to Theory', 2017, 3, 2);
INSERT INTO class VALUES (5, 'Intro to Theory', 2020, 1, 2);
INSERT INTO class VALUES (12,'Intro to Theory', 2020, 3, 2);

INSERT INTO class VALUES (6, 'Probabilistic Reasoning', 2017, 2, 4);
INSERT INTO class VALUES (7, 'Probabilistic Reasoning', 2018, 2, 4);
INSERT INTO class VALUES (8, 'Probabilistic Reasoning', 2021, 2, 4);


INSERT INTO class VALUES (10, 'Machine Learning', 2017, 3, 5);
INSERT INTO class VALUES (11, 'Machine Learning', 2021, 1, 5);

INSERT INTO class VALUES (13, 'Data Mining and Predictive Analytics', 2018, 2, 6);
INSERT INTO class VALUES (14, 'Data Mining and Predictive Analytics', 2021, 2, 6);
INSERT INTO class VALUES (17, 'Data Mining and Predictive Analytics', 2020, 3, 6);


INSERT INTO class VALUES (15, 'Databases', 2018, 2, 7);
INSERT INTO class VALUES (16, 'Databases', 2021, 3, 7);

INSERT INTO class VALUES (18, 'Operating System', 2017, 1, 8);
INSERT INTO class VALUES (19, 'Operating System', 2020, 1, 8);
INSERT INTO class VALUES (27, 'Operating System', 2020, 3, 8);


INSERT INTO class VALUES (20, 'Computational Methods', 2017, 1, 10);
INSERT INTO class VALUES (22, 'Computational Methods', 2021, 3, 10);

INSERT INTO class VALUES (23, 'Probability and Statistics', 2017, 2, 11);
INSERT INTO class VALUES (24, 'Probability and Statistics', 2017, 3, 11);
INSERT INTO class VALUES (25, 'Probability and Statistics', 2020, 1, 11);
INSERT INTO class VALUES (32, 'Probability and Statistics', 2020, 3, 11);

INSERT INTO class VALUES (26, 'Intro to Logic', 2018, 2, 12);

INSERT INTO class VALUES (28, 'Scientific Reasoning', 2021, 3, 13);
INSERT INTO class VALUES (33, 'Scientific Reasoning', 2020, 3, 13);


INSERT INTO class VALUES (29, 'Freedom, Equality, and the Law', 2017, 1, 14);
INSERT INTO class VALUES (30, 'Freedom, Equality, and the Law', 2018, 2, 14);
INSERT INTO class VALUES (31, 'Freedom, Equality, and the Law', 2021, 3, 14);
INSERT INTO class VALUES (34, 'Freedom, Equality, and the Law', 2020, 3, 14);



TRUNCATE TABLE prerequest CASCADE;
INSERT INTO prerequest VALUES (DEFAULT, 1, 2);

-- CREATE TABLE session (
-- 	id INT PRIMARY KEY NOT NULL,
-- 	classid INT REFERENCES class(id),
-- 	limit_num INT NOT NULL,
-- 	faculty VARCHAR(50) REFERENCES faculty(name)
-- );

TRUNCATE TABLE session CASCADE;
INSERT INTO session VALUES (0, 1, 0, 'TBA');
INSERT INTO session VALUES (1, 32, 2, 'Adele');
INSERT INTO session VALUES (2, 27, 5, 'Kelly Clarkson');
INSERT INTO session VALUES (3, 17, 5, 'Flo Rida');
INSERT INTO session VALUES (4, 33, 2, 'Adam Levine');
INSERT INTO session VALUES (5, 27, 3, 'Kelly Clarkson');
INSERT INTO session VALUES (6, 12, 3, 'Taylor Swift');
INSERT INTO session VALUES (7, 34, 3, 'Adam Levine');
INSERT INTO session VALUES (8, 32, 1, 'Selena Gomez');
INSERT INTO session VALUES (9, 27, 2, 'Justin Bieber');
INSERT INTO session VALUES (10, 9, 5, 'Adele');

--CREATE TABLE weekly_meeting (
--	id SERIAL PRIMARY KEY,
--	session INT REFERENCES session(id),
---	start_time time NOT NULL,   -- 04:05:00
--  end_time time NOT NULL,  
--	day INT NOT NULL, -- MON/TUE/WED/... 1/2/3/4/5
--	mtype INT NOT NULL, -- LE/DI/LAB/STO... 0/1/2/3
--	location VARCHAR(50) NOT NULL,
--	mandatory BOOLEAN -- only discussion need this field
--);

TRUNCATE TABLE weekly_meeting CASCADE;
-- session 1
INSERT INTO weekly_meeting VALUES (DEFAULT, 1, '10:00:00', '11:00:00', 1, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 1, '10:00:00', '11:00:00', 3, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 1, '10:00:00', '11:00:00', 5, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 1, '10:00:00', '11:00:00', 2, 1, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 1, '10:00:00', '11:00:00', 4, 1, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 1, '18:00:00', '19:00:00', 5, 2, 'building A', 'true');

-- session 2
INSERT INTO weekly_meeting VALUES (DEFAULT, 2, '10:00:00', '11:00:00', 1, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 2, '10:00:00', '11:00:00', 3, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 2, '10:00:00', '11:00:00', 5, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 2, '11:00:00', '12:00:00', 2, 1, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 2, '11:00:00', '12:00:00', 4, 1, 'building A', 'true');

-- session 3
INSERT INTO weekly_meeting VALUES (DEFAULT, 3, '12:00:00', '13:00:00', 1, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 3, '12:00:00', '13:00:00', 3, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 3, '12:00:00', '13:00:00', 5, 0, 'building A', 'true');

-- session 4
INSERT INTO weekly_meeting VALUES (DEFAULT, 4, '12:00:00', '13:00:00', 1, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 4, '12:00:00', '13:00:00', 3, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 4, '12:00:00', '13:00:00', 5, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 4, '13:00:00', '14:00:00', 3, 1, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 4, '13:00:00', '14:00:00', 5, 1, 'building A', 'true');

-- session 5
INSERT INTO weekly_meeting VALUES (DEFAULT, 5, '12:00:00', '13:00:00', 1, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 5, '12:00:00', '13:00:00', 3, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 5, '12:00:00', '13:00:00', 5, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 5, '12:00:00', '13:00:00', 2, 1, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 5, '12:00:00', '13:00:00', 4, 1, 'building A', 'true');

-- session 6
INSERT INTO weekly_meeting VALUES (DEFAULT, 6, '14:00:00', '15:00:00', 2, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 6, '14:00:00', '15:00:00', 4, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 6, '18:00:00', '19:00:00', 5, 1, 'building A', 'true');

-- session 7
INSERT INTO weekly_meeting VALUES (DEFAULT, 7, '15:00:00', '16:00:00', 2, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 7, '15:00:00', '16:00:00', 4, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 7, '13:00:00', '14:00:00', 4, 1, 'building A', 'true');

-- session 8
INSERT INTO weekly_meeting VALUES (DEFAULT, 8, '15:00:00', '16:00:00', 2, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 8, '15:00:00', '16:00:00', 4, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 8, '15:00:00', '16:00:00', 1, 1, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 8, '17:00:00', '18:00:00', 5, 2, 'building A', 'true');

-- session 9
INSERT INTO weekly_meeting VALUES (DEFAULT, 9, '17:00:00', '18:00:00', 2, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 9, '17:00:00', '18:00:00', 4, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 9, '09:00:00', '10:00:00', 1, 1, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 9, '09:00:00', '10:00:00', 5, 1, 'building A', 'true');

-- session 10
INSERT INTO weekly_meeting VALUES (DEFAULT, 10, '17:00:00', '18:00:00', 2, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 10, '17:00:00', '18:00:00', 4, 0, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 10, '19:00:00', '20:00:00', 3, 1, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 10, '15:00:00', '16:00:00', 2, 2, 'building A', 'true');
INSERT INTO weekly_meeting VALUES (DEFAULT, 10, '15:00:00', '16:00:00', 4, 2, 'building A', 'true');


TRUNCATE TABLE waitlist CASCADE;
INSERT INTO waitlist VALUES (DEFAULT, 1, 1);

TRUNCATE TABLE review_session CASCADE;
INSERT INTO review_session VALUES (DEFAULT, 1, 'BUILDING A', '14:00:00', '15:00:00', '2014-05-01');

--CREATE TABLE course_enrollment (
--	id SERIAL PRIMARY KEY,
--	student INT REFERENCES student(id) NOT NULL,
--	course INT REFERENCES course(id) NOT NULL,
--	session INT REFERENCES session(id) NOT NULL,
--	require_units INT NOT NULL,
--	grade_option INT NOT NULL   -- 0 or 1, 0 letter, 1 pnp
--);

TRUNCATE TABLE course_enrollment CASCADE;
INSERT INTO course_enrollment VALUES (DEFAULT, 16, 8, 2, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 17, 8, 9, 4, 1);
INSERT INTO course_enrollment VALUES (DEFAULT, 18, 8, 5, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 19, 8, 2, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 20, 8, 9, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 21, 8, 5, 4, 1);
INSERT INTO course_enrollment VALUES (DEFAULT, 22, 6, 3, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 16, 6, 3, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 17, 6, 3, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 1, 1, 10, 4, 1);
INSERT INTO course_enrollment VALUES (DEFAULT, 5, 1, 10, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 3, 1, 10, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 7, 11, 1, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 8, 11, 1, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 9, 11, 8, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 4, 2, 6, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 12, 13, 4, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 13, 14, 7, 4, 1);
INSERT INTO course_enrollment VALUES (DEFAULT, 14, 13, 4, 4, 0);
INSERT INTO course_enrollment VALUES (DEFAULT, 15, 14, 7, 4, 0);

--CREATE TABLE instruction_date(
--	id SERIAL PRIMARY KEY NOT NULL,
--	start_date DATE NOT NULL,
--	end_date D DATE NOT NULL,
--	year INT NOT NULL,
--	quarter INT NOT NULL
--);

TRUNCATE TABLE instruction_date CASCADE;
INSERT INTO instruction_date VALUES (DEFAULT, '2020-03-30', '2020-06-05', 2020, 3);

-- CREATE TABLE past_class_taken (
--   pastclass_id SERIAL PRIMARY KEY,
--   studentid integer REFERENCES student(id) ,
--   courseid integer REFERENCES course(id),
--   year integer,
--   quarter integer,
--   grade TEXT NOT NULL,
--   unit integer NOT NULL
-- );


TRUNCATE TABLE past_class_taken CASCADE;
											 
INSERT INTO past_class_taken VALUES (DEFAULT, 1, 1, 2017, 2,'A-',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 3, 1, 2017, 2,'B+',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 2, 1, 2017, 1,'C-',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 4, 1, 2018, 2,'A-',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 5, 1, 2018, 2,'B',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 1, 2, 2017, 3,'A-',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 5, 2, 2017, 3,'B+',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 4, 2, 2017,3,'C',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 16, 4, 2017, 2,'C',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 22, 4, 2018, 2,'B+',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 18, 4, 2018, 2,'D',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 19, 4, 2018, 2,'F',4); 
INSERT INTO past_class_taken VALUES (DEFAULT, 17, 5, 2017, 3,'A',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 19, 5, 2017, 3,'A',4);		
INSERT INTO past_class_taken VALUES (DEFAULT, 20, 6, 2018, 2,'B-',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 18, 6, 2018, 2,'B',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 21, 6, 2018, 2,'F',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 17, 7, 2018, 2,'A-',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 22, 2, 2017, 1,'A',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 20, 2, 2017, 1,'A',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 10, 10, 2017, 1,'B+',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 8, 11, 2017, 2,'A-',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 7, 11, 2017, 2,'A',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 6, 11, 2017, 3,'A',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 10, 11, 2017, 3,'B+',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 11, 12, 2018, 2,'A',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 12, 12, 2018, 2,'A',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 13, 12, 2018, 2,'C-',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 14, 12, 2018, 2,'C+',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 15,14, 2017, 1,'F',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 12,14, 2017, 1,'D',4);
INSERT INTO past_class_taken VALUES (DEFAULT, 11,14, 2018, 2,'A',4);

TRUNCATE TABLE probation CASCADE;
INSERT INTO probation VALUES (DEFAULT, 1, 'cheating', '2010-04-05', '2010-05-06');


-- CREATE TABLE lower_division (
-- 	low_div_id SERIAL PRIMARY KEY,
-- 	degree INTEGER REFERENCES degree(id),
-- 	require_units INTEGER NOT NULL,
-- 	gpa FLOAT (2) NOT NULL
-- );
TRUNCATE TABLE lower_division CASCADE;
INSERT INTO lower_division VALUES(DEFAULT,1,10,3.5);
INSERT INTO lower_division VALUES(DEFAULT,2,15,3.5);
INSERT INTO lower_division VALUES(DEFAULT,3,20,3.5);
INSERT INTO lower_division VALUES(DEFAULT,4,0,3.5);

TRUNCATE TABLE upper_division CASCADE;
INSERT INTO upper_division VALUES(DEFAULT,1,15,3);
INSERT INTO upper_division VALUES(DEFAULT,2,20,3);
INSERT INTO upper_division VALUES(DEFAULT,3,20,3);
INSERT INTO upper_division VALUES(DEFAULT,4,0,3);


-- CREATE TABLE technical_division (
-- 	techid SERIAL PRIMARY KEY,
-- 	degree INTEGER UNIQUE REFERENCES degree(id),
-- 	require_units INTEGER NOT NULL ,
-- 	gpa FLOAT (2) NOT NULL
-- );
TRUNCATE TABLE technical_division CASCADE;
INSERT INTO technical_division VALUES(DEFAULT,1,15,3.5);
INSERT INTO technical_division VALUES(DEFAULT,2,0,3.5);
INSERT INTO technical_division VALUES(DEFAULT,3,10,3.5);
INSERT INTO technical_division VALUES(DEFAULT,4,0,3.5);

TRUNCATE TABLE technical_elective CASCADE;
INSERT INTO technical_elective VALUES(DEFAULT,14);
INSERT INTO technical_elective VALUES(DEFAULT,8);
INSERT INTO technical_elective VALUES(DEFAULT,2);
INSERT INTO technical_elective VALUES(DEFAULT,10);
INSERT INTO technical_elective VALUES(DEFAULT,9); 

-- CREATE TABLE faculty_teaching (
-- 	id SERIAL PRIMARY KEY,
-- 	name TEXT  REFERENCES faculty(name),
-- 	course INTEGER NOT NULL REFERENCES course(id),
-- 	session INTEGER REFERENCES session(id),
-- 	quarter INTEGER,
-- 	year INTEGER	
-- );


TRUNCATE TABLE faculty_teaching CASCADE;
INSERT INTO faculty_teaching VALUES(DEFAULT,'Justin Bieber',1,0,2,2017);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Flo Rida',14,0,1,2017);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Selena Gomez',1,0,1,2017);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Adele',11,1,3,2020);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Taylor Swift',2,0,3,2017);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Kelly Clarkson',1,0,2,2018);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Bjork',4,0,2,2017);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Bjork',12,0,2,2018);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Justin Bieber',5,0,3,2017);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Flo Rida',6,3,3,2020);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Selena Gomez',11,8,3,2020);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Adele',1,10,3,2020);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Taylor Swift',2,6,3,2020);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Kelly Clarkson',7,0,2,2018);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Adam Levine',14,0,2,2018);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Bjork',10,0,1,2017);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Justin Bieber',8,9,3,2020);

INSERT INTO faculty_teaching VALUES(DEFAULT,'Selena Gomez',11,0,2,2017);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Adam Levine',13,4,3,2020);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Bjork',4,0,2,2018);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Adam Levine',14,7,3,2020);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Kelly Clarkson',8,2,3,2020);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Kelly Clarkson',8,5,3,2020);

INSERT INTO faculty_teaching VALUES(DEFAULT,'Justin Bieber',6,0,2,2018);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Justin Bieber',8,0,1,2017);
INSERT INTO faculty_teaching VALUES(DEFAULT,'Selena Gomez',11,0,3,2017);


