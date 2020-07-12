-- The lectures ('LE'), discussions('DI') and lab('LAB') meetings of a section should not happen at the same time.
CREATE OR REPLACE FUNCTION 
	check_meeting() RETURNS TRIGGER 
AS $$
	BEGIN
		IF EXISTS(
			select session, count(id)
			from weekly_meeting w
			where w.session = new.session AND w.day = new.day 
					AND (
					(w.start_time >= new.start_time AND w.start_time < new.end_time)
					OR (w.end_time > new.start_time AND w.end_time <= new.end_time)
					OR (w.start_time < new.start_time AND w.end_time > new.end_time)
					)
			group by w.session
			having count(id) > 1
		) 
		THEN
			RAISE EXCEPTION 'Conflict with other meeting in this section!';
		END IF;
		
		RETURN NEW;
	END;
$$ language plpgsql;

CREATE TRIGGER no_conflict_meeting 
AFTER INSERT OR UPDATE ON weekly_meeting
FOR EACH ROW 
EXECUTE PROCEDURE check_meeting();

-- If the enrollment limit of a section has been reached then additional enrollments should be rejected. 
-- It is not required to update the waitlist.
CREATE OR REPLACE FUNCTION 
	check_enrollment_limit() RETURNS TRIGGER 
AS $$
	BEGIN
		IF EXISTS(
			select e.session, count(e.student)
			from course_enrollment e, session s
			where e.session = new.session AND e.session = s.id
			group by e.session, s.limit_num
			having count(e.student) > s.limit_num
		) 
		THEN
			RAISE EXCEPTION 'Sorry, this section already full!';
		END IF;
		
		RETURN NEW;
	END;
$$ language plpgsql;

CREATE TRIGGER section_limit
AFTER INSERT OR UPDATE ON course_enrollment
FOR EACH ROW 
EXECUTE PROCEDURE check_enrollment_limit();


-- A professor should not have multiple sections at the same time. 
-- For example, a professor that is scheduled to teach classes X and Y should not have conflicting sections, mainly overlapping meetings. 
-- It is enough to check for the regular meetings (e.g., "LE"). 
-- Extra credit is given for checking conflicts on the irregular meetings too.
CREATE OR REPLACE VIEW facultyMeeting AS
	SELECT DISTINCT s.faculty, c.title, c.year, c.quarter, w.day, w.start_time, w.end_time
	FROM session s, weekly_meeting w, class c
	WHERE s.id = w.session AND s.classid = c.id;

CREATE OR REPLACE FUNCTION 
	check_faculty_meeting() RETURNS TRIGGER 
AS $$
	BEGIN
		IF EXISTS(
			select f.faculty, count(*)
			from facultyMeeting f, session s, class c
			where s.id = new.session AND c.id = s.classid AND f.faculty = s.faculty
					AND f.year = c.year AND f.quarter = c.quarter
					AND f.day = new.day 
					AND (
					(f.start_time >= new.start_time AND f.start_time < new.end_time)
					OR (f.end_time > new.start_time AND f.end_time <= new.end_time)
					OR (f.start_time < new.start_time AND f.end_time > new.end_time)
					) AND f.faculty != 'TBA'
			group by f.faculty
			having count(*) > 1
		) 
		THEN
			RAISE EXCEPTION 'Conflict with another meeting of the same Professor!';
		END IF;
		
		RETURN NEW;
	END;
$$ language plpgsql;

CREATE TRIGGER faculty_meeting 
AFTER INSERT OR UPDATE ON weekly_meeting
FOR EACH ROW 
EXECUTE PROCEDURE check_faculty_meeting();

CREATE OR REPLACE FUNCTION 
	check_faculty_session() RETURNS TRIGGER 
AS $$
	BEGIN
		IF new.faculty != 'TBA'
		THEN
			IF EXISTS(
				select f.faculty, count(*)
				from facultyMeeting f, class c, weekly_meeting m
				where c.id = new.classid AND f.faculty = new.faculty AND m.session = new.id
						AND f.year = c.year AND f.quarter = c.quarter
						AND f.day = m.day
						AND (
						(f.start_time >= m.start_time AND f.start_time < m.end_time)
						OR (f.end_time > m.start_time AND f.end_time <= m.end_time)
						OR (f.start_time < m.start_time AND f.end_time > m.end_time)
						)
				group by f.faculty
				having count(*) > 1
			) 
			THEN
				RAISE EXCEPTION 'Conflict with other meetings of the same Professor!';
			END IF;
		END IF;
		
		RETURN NEW;
	END;
$$ language plpgsql;

CREATE TRIGGER faculty_session
AFTER INSERT OR UPDATE ON session
FOR EACH ROW 
EXECUTE PROCEDURE check_faculty_session();



-- cpqg trigger for update and insert 

drop trigger update_cpqg on past_class_taken;
CREATE OR REPLACE FUNCTION update_cpqg() RETURNS TRIGGER
AS $BODY$
BEGIN

if (tg_op = 'INSERT') then
update cpqg set
"A" = case when ( new.grade IN('A-','A','A+') ) then "A"+1 ELSE "A" end,
"B" = case when ( new.grade IN('B-','B','B+') ) then "B"+1 ELSE "B"end,
"C" = case when ( new.grade IN('C-','C','C+') ) then "C"+1 ELSE "C" end,
"D" = case when ( new.grade IN('D-','D','D+') ) then "D"+1 ELSE "D"end,
"others" = case when new.grade IN('F','S','U') then "others"+1 ELSE "others" end
from past_class_taken pt
where pt.courseid=new.courseid and new.courseid = cpqg.courseid and new.year = cpqg.year and new.quarter=cpqg.quarter ;

end if;




if (tg_op = 'UPDATE') then
update cpqg set
"A" = case when ( new.grade IN('A-','A','A+') ) then "A"+1 ELSE "A" end,
"B" = case when ( new.grade IN('B-','B','B+') ) then "B"+1 ELSE "B"end,
"C" = case when ( new.grade IN('C-','C','C+') ) then "C"+1 ELSE "C" end,
"D" = case when ( new.grade IN('D-','D','D+') ) then "D"+1 ELSE "D"end,
"others" = case when new.grade IN('F','S','U') then "others"+1 ELSE "others" end
from past_class_taken pt
where pt.courseid=new.courseid and pt.studentid = new.studentid and pt.year = new.year 
and pt.quarter = new.quarter and pt.grade = new.grade and pt.courseid = cpqg.courseid and pt.year = cpqg.year and pt.quarter=cpqg.quarter ;




update cpqg set
"A" = case when ( old.grade IN('A-','A','A+') ) then "A"-1 ELSE "A" end,
"B" = case when ( old.grade IN('B-','B','B+') ) then "B"-1 ELSE "B"end,
"C" = case when ( old.grade IN('C-','C','C+') ) then "C"-1 ELSE "C" end,
"D" = case when ( old.grade IN('D-','D','D+') ) then "D"-1 ELSE "D"end,
"others" = case when old.grade IN('F','S','U') then "others"-1 ELSE "others" end
from past_class_taken pt
where pt.courseid=new.courseid and pt.studentid = new.studentid and pt.courseid = new.courseid and pt.year = new.year 
and pt.quarter = new.quarter and pt.grade = new.grade
and pt.courseid = cpqg.courseid and pt.year = cpqg.year and pt.quarter=cpqg.quarter ;

end if;

return new;
end;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_cpqg AFTER UPDATE OR INSERT on past_class_taken
for each row 
EXECUTE PROCEDURE update_cpqg();




  --------------------- CPG part -----------------------



-- cpg trigger for update and insert 

drop trigger update_cpg on past_class_taken;
CREATE OR REPLACE FUNCTION update_cpg() RETURNS TRIGGER
AS $BODY$
	BEGIN

if (tg_op = 'INSERT') then
update cpg set
"A" = case when ( new.grade IN('A-','A','A+') ) then "A"+1 ELSE "A" end,
"B" = case when ( new.grade IN('B-','B','B+') ) then "B"+1 ELSE "B"end,
"C" = case when ( new.grade IN('C-','C','C+') ) then "C"+1 ELSE "C" end,
"D" = case when ( new.grade IN('D-','D','D+') ) then "D"+1 ELSE "D"end,
"others" = case when new.grade IN('F','S','U') then "others"+1 ELSE "others" end
from past_class_taken pt,faculty_teaching f  
where pt.courseid=new.courseid and pt.year = new.year and pt.quarter = new.quarter 
and f.course =new.courseid and f.quarter = new.quarter and f.year = new.year 
and cpg.courseid = new.courseid and cpg.cname = f.name;


 end if;

if (tg_op = 'UPDATE') then
update cpg set
"A" = case when ( new.grade IN('A-','A','A+') ) then "A"+1 ELSE "A" end,
"B" = case when ( new.grade IN('B-','B','B+') ) then "B"+1 ELSE "B"end,
"C" = case when ( new.grade IN('C-','C','C+') ) then "C"+1 ELSE "C" end,
"D" = case when ( new.grade IN('D-','D','D+') ) then "D"+1 ELSE "D"end,
"others" = case when new.grade IN('F','S','U') then "others"+1 ELSE "others" end
from past_class_taken pt,faculty_teaching f 
where pt.courseid=new.courseid and pt.year = new.year and pt.quarter = new.quarter 
and f.course =new.courseid and f.quarter = new.quarter and f.year = new.year 
and cpg.courseid = new.courseid and cpg.cname = f.name;

-- where pt.courseid=new.courseid and new.cname = f.name and f.course =new.courseid and f.quarter = pt.quarter
-- and f.year = pt.year;
 

update cpg set
"A" = case when ( old.grade IN('A-','A','A+') ) then "A"-1 ELSE "A" end,
"B" = case when ( old.grade IN('B-','B','B+') ) then "B"-1 ELSE "B"end,
"C" = case when ( old.grade IN('C-','C','C+') ) then "C"-1 ELSE "C" end,
"D" = case when ( old.grade IN('D-','D','D+') ) then "D"-1 ELSE "D"end,
"others" = case when old.grade IN('F','S','U') then "others"-1 ELSE "others" end
from past_class_taken pt,faculty_teaching f 
where pt.courseid=new.courseid and pt.year = new.year and pt.quarter = new.quarter 
and f.course =new.courseid and f.quarter = new.quarter and f.year = new.year 
and cpg.courseid = new.courseid and cpg.cname = f.name;

-- where pt.courseid=new.courseid and new.cname = f.name and f.course =new.courseid and f.quarter = pt.quarter
-- and f.year = pt.year;

 
end if;

return new;
end;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER update_cpg AFTER UPDATE OR INSERT on past_class_taken
for each row 
EXECUTE PROCEDURE update_cpg();



