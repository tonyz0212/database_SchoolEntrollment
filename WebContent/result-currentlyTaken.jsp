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
		String sid = request.getParameter("sid"); 
	%>
		Report for student <%=sid%>
	<table border = "1">
		<tr>
			<th>Course Code</th>
			<th>Class Title</th>
			<th>Unit</th>
			<th>session ID</th>
			<th>Faculty</th>
			
		</tr>
		
		<tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT co.code, cl.title, e.require_units, s.id, s.faculty "
				+ "FROM course_enrollment e, course co, class cl, session s "
				+ "WHERE e.student = " + sid + " and e.course = co.id and e.session = s.id and s.classid = cl.id");
		while (rset.next ()) {
			%><tr>
					<form action="classTaken.jsp" method="get">
						
						<td><%= rset.getString(1) %></td> 
						<td><%= rset.getString(2) %></td> 
						<td><%= rset.getInt(3) %></td> 
						<td><%= rset.getInt(4) %></td> 
						<td><%= rset.getString(5) %></td> 

						
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
	<a href="query-currentlyTaken.jsp">GO BACK</a> 

</body>
</html>