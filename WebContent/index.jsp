<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="cse132b.copy.SystemManager" %>
<%@ page import="java.util.*" %>

<html>
<head>
<meta charset="UTF-8">
<title>hello, cse132</title>
</head>
<body>

	<%
	SystemManager sm = new SystemManager();
	request.getSession().setAttribute("sm",sm);
	
	%>
	<a href="course.jsp">COURSE</a><br>
	<a href="class.jsp">CLASS</a><br>
	<a href="student.jsp">STUDENT</a><br>
	<a href="faculty.jsp">FACULTY</a><br>
	<a href="courseEnrollment.jsp">COURSE ENROLLMENT</a><br>
	<a href="classTaken.jsp">CLASS TAKEN</a><br>
	<a href="thesis.jsp">THESIS</a><br>
	<a href="probation.jsp">PROBATION</a><br>
	<a href="reviewSession.jsp">REVIEW SESSION</a><br>
	<a href="degreeRequirement.jsp">DEGREE REQUIREMENT</a><br>
	<br><br>
	
	<a href="department.jsp">DEPARTMENT</a><br>
	<a href="concentration.jsp"> CONCENTRATION</a><br>
	<a href="technical.jsp"> TECHNICAL ELECTIVE</a><br>	
	
	<br>
	<a href="query.jsp">QUERY</a><br>
</body>
</html>
<!-- 

Course Entry Form: 
Provide forms that prompt for course data, one at a time, and appropriately insert them into the database. 
Course data include prerequisite information.

Class Entry Form: 
Provide forms that prompt for class data (excluding the list of students who are taking the class) and insert them into the database. 
Classes will have to refer to courses you have already entered.

Student Entry Form: 
Forms, again. Exclude information about the classes that the student takes or has taken, 
the probations he may have received, and his committee info. 
They will be covered by forms described below.

Faculty Entry Form

Course Enrollment: 
Provide a form that allows us to insert in the database that student X takes the course Y in the current quarter. 
If the course has multiple sections prompt for section. 
If the course is flexible on the number of units prompt the student for the number of units he wants to take.

Classes taken in the Past: 
Provide a form that allows us to insert in the database that student X took the course Y in quarter Z. 
If the course has multiple sections prompt for section. Also, ask for the grade G of the student.

Thesis Committee Submission: 
Provide a form that allows graduate students to submit their thesis committee.

Probation Info Submission

Review Session Info Submission

Degree Requirements’ Info Submission

-->