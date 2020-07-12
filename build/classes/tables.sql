CREATE TABLE department(
	id INT PRIMARY KEY,
	name VARCHAR(50) 
);

CREATE TABLE degree(
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL UNIQUE,
	required_units INT NOT NULL,
	degree_type  TEXT NOT NULL,
	department_id INT REFERENCES department(id)	ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE student(
   id          INT      PRIMARY KEY   NOT NULL,
   ssn         INT      NOT NULL UNIQUE,
   firstName   VARCHAR(50) NOT NULL,
   middleName  VARCHAR(50),
   lastName    VARCHAR(50) NOT NULL,
   residency   INT      NOT NULL,
   enrollment  BOOLEAN      NOT NULL,
   level       INT      NOT NULL,  -- 0 undergraduate 1 graduate
   degree      INT      REFERENCES degree(id) ON DELETE CASCADE ON UPDATE CASCADE,
   start_date  DATE NOT NULL,
   end_date	   DATE NOT NULL
);



CREATE TABLE student_enrollment(
	id 		  	SERIAL PRIMARY KEY,
	studentid   INT REFERENCES student(id),
	year INT,
	quarter INT
);



CREATE TABLE undergraduate(
	underid SERIAL PRIMARY KEY,
	id  INT REFERENCES student(id) UNIQUE,
	college VARCHAR(50) NOT NULL,
	major VARCHAR(50),
	minor VARCHAR(50)
);



CREATE TABLE faculty(
	name VARCHAR(50) PRIMARY KEY NOT NULL,
	title INT,
	department INT REFERENCES department(id)
);



CREATE TABLE graduate(
	graduateid SERIAL PRIMARY KEY,
	id  INT REFERENCES student(id) NOT NULL UNIQUE,
	department  INT REFERENCES department(id),
	classification INT NOT NULL,
	advisor VARCHAR(50) REFERENCES faculty(name)
);


CREATE TABLE thesis(
	id INT PRIMARY KEY,
	studentid INT REFERENCES student(id)

);


CREATE TABLE thesis_instructor(
	id SERIAL PRIMARY KEY,
	thesisId INT REFERENCES thesis(id) ON DELETE CASCADE ON UPDATE CASCADE,
 	department INT REFERENCES department(id) ON DELETE CASCADE ON UPDATE CASCADE,
 	faculty_name VARCHAR(50) UNIQUE REFERENCES faculty(name) 
);




CREATE TABLE course (
	id SERIAL PRIMARY KEY,
	code VARCHAR(50) UNIQUE NOT NULL, -- CSE132B
	grade_option INT NOT NULL, -- letter/su/both
	ctype INT,  -- upper/low?
	consent BOOLEAN NOT NULL, -- require consent of instructor or not
	minunit INT NOT NULL,
	maxunit INT NOT NULL,
	department INT REFERENCES department(id),
	lab BOOLEAN NOT NULL -- has lab or not
);


CREATE TABLE concentration (
  id INT PRIMARY KEY,
  name text NOT NULL UNIQUE,
  gpa FLOAT(2) NOT NULL,
  degreeid INT NOT NULL REFERENCES degree(id),
  unit INT NOT NULL
);


CREATE TABLE concentration_course (
  id SERIAL PRIMARY KEY,
  idconcentration integer REFERENCES concentration(id) ,
  idcourse integer REFERENCES course(id) 
);


CREATE TABLE class(
	id INT PRIMARY KEY NOT NULL,
	title VARCHAR(50) NOT NULL,
	year INT,
	quarter INT,
	courseid INT REFERENCES course(id)
);


CREATE TABLE prerequest (
	id SERIAL PRIMARY KEY,
	courseid INT REFERENCES course(id) NOT NULL,
	requestid INT REFERENCES course(id) NOT NULL
);

CREATE TABLE session (
	id INT PRIMARY KEY NOT NULL,
	classid INT REFERENCES class(id),
	limit_num INT NOT NULL,
	faculty VARCHAR(50) REFERENCES faculty(name)
);


CREATE TABLE waitlist (
	id SERIAL PRIMARY KEY,
	sessionid INT REFERENCES session(id),
	studentid INT REFERENCES student(id)
);

CREATE TABLE weekly_meeting (
	id SERIAL PRIMARY KEY,
	session INT REFERENCES session(id),
	start_time time NOT NULL,   -- 04:05:00
	end_time time NOT NULL,  
	day INT NOT NULL, -- MON/TUE/WED/...
	mtype INT NOT NULL, -- LE/DI/LAB/...
	location VARCHAR(50) NOT NULL,
	mandatory BOOLEAN -- only discussion need this field
);



CREATE TABLE review_session (
 	id SERIAL PRIMARY KEY, 	
	session INT REFERENCES session(id),
 	location VARCHAR(50) NOT NULL,
 	start_time time NOT NULL,   -- 04:05:00
 	end_time time NOT NULL,  
 	re_date DATE NOT NULL -- yyyy-mm-dd
 );
 
CREATE TABLE course_enrollment (
	id SERIAL PRIMARY KEY,
	student INT REFERENCES student(id) NOT NULL,
	course INT REFERENCES course(id) NOT NULL,
	session INT REFERENCES session(id) NOT NULL,
	require_units INT NOT NULL,
	grade_option INT NOT NULL   -- 0 or 1, 0 letter, 1 pnp
);

CREATE TABLE past_class_taken (
  pastclass_id SERIAL PRIMARY KEY,
  studentid integer REFERENCES student(id) ,
  courseid integer REFERENCES course(id),
  year integer,
  quarter integer,
  grade TEXT NOT NULL,
  unit integer NOT NULL
);

-- CREATE TABLE quarter (
--   quarter_id SERIAL PRIMARY KEY,
--   year INTEGER NOT NULL,
--   season TEXT NOT NULL
-- );

CREATE TABLE probation (
	id SERIAL PRIMARY KEY,
	student INT REFERENCES student(id) NOT NULL,
	reason text,
	startDate DATE NOT NULL,  -- yyyy-mm-dd
	endDate DATE NOT NULL
);

CREATE TABLE degree_history (
	id SERIAL PRIMARY KEY,
	student INT REFERENCES student(id) NOT NULL,
	degree VARCHAR(50) NOT NULL
);

CREATE TABLE lower_division (
	low_div_id SERIAL PRIMARY KEY,
	degree INTEGER REFERENCES degree(id),
	require_units INTEGER NOT NULL,
	gpa FLOAT (2) NOT NULL
);

CREATE TABLE upper_division (
	up_div_id SERIAL PRIMARY KEY,
	degree INTEGER REFERENCES degree(id),
	require_units INTEGER NOT NULL ,
	gpa FLOAT (2) NOT NULL
);

CREATE TABLE technical_division (
	techid SERIAL PRIMARY KEY,
	degree INTEGER UNIQUE REFERENCES degree(id),
	require_units INTEGER NOT NULL ,
	gpa FLOAT (2) NOT NULL
);

CREATE TABLE technical_elective (
 	techid SERIAL PRIMARY KEY,
 	courseid INTEGER UNIQUE REFERENCES course(id)
);

CREATE TABLE faculty_teaching (
	id SERIAL PRIMARY KEY,
	name TEXT  REFERENCES faculty(name),
	course INTEGER NOT NULL REFERENCES course(id),
	session INTEGER REFERENCES session(id),
	quarter INTEGER,
	year INTEGER	
);

create table GRADE_CONVERSION(
	LETTER_GRADE CHAR(2) NOT NULL,
    NUMBER_GRADE DECIMAL(2,1)
);
 

--- VIEWS ----

-- All sesion for student for this term
CREATE VIEW mandatoryMeeting AS
	SELECT DISTINCT s.ssn, cl.title, co.code, w.day, start_time, end_time
	FROM student s, course_enrollment e, class cl, session se, weekly_meeting w, course co
	WHERE s.id = e.student AND e.session = se.id AND se.classid = cl.id AND cl.year = 2020 AND cl.quarter = 3
			AND w.session = se.id AND co.id = e.course AND w.mandatory = 'true';
			
-- this quarter class
CREATE VIEW currentClass AS
	SELECT DISTINCT id
	FROM class c
	WHERE c.year = 2020 AND c.quarter = 3;
	
-- current taken class
CREATE VIEW takenClass AS
	SELECT DISTINCT e.student as student, c.id as class
	FROM course_enrollment e, currentClass c, session se
	WHERE  e.session = se.id AND se.classid = c.id;

-- untaken class
CREATE VIEW untakenClass AS
	SELECT DISTINCT s.id as student, c.id as class
	FROM student s, currentClass c
	WHERE NOT EXISTS (SELECT 1 FROM takenClass t WHERE t.student = s.id AND c.id = t.class)
	ORDER BY s.id;

-- can't taken class
CREATE VIEW canttake AS
	SELECT DISTINCT cl.student, cl.class, s.ssn
	FROM untakenclass cl, student s
	WHERE cl.student = s.id AND
		NOT EXISTS (
			SELECT 1
			FROM session se
			WHERE se.classid = cl.class AND
			NOT EXISTS (
				SELECT 1
				FROM weekly_meeting w, mandatoryMeeting m
				WHERE m.ssn = s.ssn AND w.session = se.id AND w.day = m.day AND w.start_time = m.start_time
			)
		);
		

CREATE TABLE tableA(
	id INT PRIMARY KEY,
	letter VARCHAR(50) 
);

CREATE TABLE tableB(
	id INT PRIMARY KEY,
	letter VARCHAR(50) 
);

CREATE TABLE tableC(
	id INT PRIMARY KEY,
	letter VARCHAR(50) 
);
CREATE TABLE tableD(
	id INT PRIMARY KEY,
	letter VARCHAR(50) 
);
CREATE TABLE tableOther(
	id INT PRIMARY KEY,
	letter VARCHAR(50) 
);

insert into tablea values(1,'A');
insert into tableb values(1,'B');
insert into tablec values(1,'C');
insert into tabled values(1,'D');
insert into tableother values(1,'OHTER');		
		

-- the sessions that students take s1 also take
CREATE VIEW allsession AS
	SELECT DISTINCT s1.id AS checked, s2.id AS contain
	FROM session s1, session s2
	WHERE EXISTS (
		SELECT 1
		FROM course_enrollment e1, course_enrollment e2
		WHERE e1.student = e2.student AND e1.session = s1.id AND e2.session = s2.id
	)
	ORDER BY s1.id;

-- the weeklymeeting that students take this session have
CREATE VIEW allweekly AS
	SELECT DISTINCT s.checked AS session, w.id AS meeting, w.day AS day, w.start_time AS start, w.end_time AS end
	FROM weekly_meeting w, allsession s
	WHERE s.contain = w.session;
	
-- the review session that students take this session have
CREATE VIEW allreview AS
	SELECT DISTINCT s.checked AS session, r.id AS meeting, r.re_date AS redate, r.start_time AS start, r.end_time AS end
	FROM review_session r, allsession s
	WHERE s.contain = r.session;


CREATE TABLE timeslot(
	start_time time NOT NULL,   -- 04:05:00
 	end_time time NOT NULL
);

CREATE TABLE instruction_date(
	id SERIAL PRIMARY KEY NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	year INT NOT NULL,
	quarter INT NOT NULL
);

INSERT INTO timeslot VALUES ('08:00:00', '09:00:00');
INSERT INTO timeslot VALUES ('09:00:00', '10:00:00');
INSERT INTO timeslot VALUES ('10:00:00', '11:00:00');
INSERT INTO timeslot VALUES ('11:00:00', '12:00:00');
INSERT INTO timeslot VALUES ('12:00:00', '13:00:00');
INSERT INTO timeslot VALUES ('13:00:00', '14:00:00');
INSERT INTO timeslot VALUES ('14:00:00', '15:00:00');
INSERT INTO timeslot VALUES ('15:00:00', '16:00:00');
INSERT INTO timeslot VALUES ('16:00:00', '17:00:00');
INSERT INTO timeslot VALUES ('17:00:00', '18:00:00');
INSERT INTO timeslot VALUES ('18:00:00', '19:00:00');
INSERT INTO timeslot VALUES ('19:00:00', '20:00:00');