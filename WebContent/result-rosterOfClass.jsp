<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="org.postgresql.Driver" %>
<%@ page import="cse132b.copy.SystemManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>classTaken</title>
</head>
<body>
	<%	
		SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
		String cid = request.getParameter("cid"); 
		
		HashMap<Integer, String> res = new HashMap<>();
		res.put(0, "California");
		res.put(1, "non-CA US");
		res.put(2, "foreign");
		
		HashMap<Integer, String> gra = new HashMap<>();
		gra.put(0, "LETTER");
		gra.put(1, "PNP");
		
		HashMap<Integer, String> lev = new HashMap<>();
		lev.put(0, "Undergraduate");
		lev.put(1, "Graduate");
		

	%>
		Report for class <%=cid%>
	<table border = "1">
		<tr>

			<th>Student ID</th>
			<th>SSN</th>
			<th>Name</th>
			<th>Residency</th>
			<th>Enrollment</th>
			<th>Level</th>
			<th>Degree</th>
			<th>Unit</th>
			<th>GradeOption</th>

			
		</tr>
		
		<tr>
	<%
	/*
	SELECT  s.id, s.ssn, s.firstname, s.middlename, s.lastname, s.residency, s.enrollment, s.level, d.name, e.require_units, e.grade_option"
	FROM student s, course_enrolment e, session se, degree d
	WHERE e.student = " + cid + " AND e.course = co.id AND e.session = se.id AND se.classid = cl.id;
				
	, s.ssn, s.firstname, s.middlename, s.lastname, s.residency, s.enrollment, s.level, d.name, e.require_units, e.grade_option
	*/
	try {
		String query = "SELECT s.id	, s.ssn, s.firstname, s.middlename, s.lastname, s.residency, s.enrollment, s.level, d.name, e.require_units, e.grade_option "
				+ "FROM student s, course_enrollment e, session se, degree d "
				+ "WHERE se.classid = " + cid + " AND s.id = e.student AND se.id = e.session AND d.id = s.degree";
		//System.out.println(query);
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery (query);

		
		while (rset.next ()) {
			String residency = res.get(rset.getInt(6));
			String level = lev.get(rset.getInt(8));
			String grade = gra.get(rset.getInt(11));
			%><tr>
					<form action="classTaken.jsp" method="get">
						
						<td><%= rset.getInt(1) %></td> 
						<td><%= rset.getInt(2) %></td> 
						<td><%= rset.getString(3)  + " " +  rset.getString(4) + " " + rset.getString(5)%></td> 
						<td><%= residency %></td> 
						<td><%= rset.getBoolean(7) %></td> 
						<td><%= level %></td> 
						<td><%= rset.getString(9) %></td> 
						<td><%= rset.getInt(10) %></td> 
						<td><%= grade %></td> 

						
					</form>
				</tr>
		<%
		}
			rset.close();
			stmt.close();
	} catch(SQLException e) {
		e.printStackTrace();

	}
	%>
	</table>
	
	<br>
	<a href="query-rosterOfClass.jsp">GO BACK</a> 

</body>
</html>