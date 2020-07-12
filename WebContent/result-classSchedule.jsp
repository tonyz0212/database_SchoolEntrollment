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
<title>classSchedule</title>
</head>
<body>
	<%	
		SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
		String ssn = request.getParameter("ssn"); 
	%>
		Report for student <%=ssn%>
		<br>
		Can't take class
	<table border = "1">
		<tr>
			<th>Course Code</th>
			<th>Class Title</th>
		</tr>
		
		<tr>
	<%
	try {
		
		
		
		
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT co.code, cl.title "
				+ "FROM canttake c, class cl, course co "
				+ "WHERE c.ssn = " + ssn + " AND c.class = cl.id AND co.id = cl.courseid");
		while (rset.next ()) {
			%><tr>
						
						<td><%= rset.getString(1) %></td> 
						<td><%= rset.getString(2) %></td> 
						
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
	<a href="query-classSchedule.jsp">GO BACK</a> 

</body>
</html>