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
<title>report part two</title>
</head>
<body>
	
	<tr>
	<form action="resultSupportFive.jsp" method="get">
		 
		CourseID: 
        <select name="cid">
<%
	SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT distinct c.id" 
				+ " FROM course c ORDER BY c.id;");
		while (rset.next ()) {
		%>
             <option value="<%= rset.getInt(1) %>"> <%= rset.getInt(1) %> </option>
	<%
		}
		rset.close();
		stmt.close();
	} catch(SQLException e) {
		e.printStackTrace();
	}
	%> 
	 </select>
	 	 
	 	Professor:  
        <select name="pid">
<%
 
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT f.name from faculty f; ");
		while (rset.next ()) {
		%>
             <option value="<%= rset.getString(1) %>"> <%= rset.getString(1) %></option>
	<%
		}
		rset.close();
		stmt.close();
	} catch(SQLException e) {
		e.printStackTrace();
	}
	%> 
	 </select>
	 
		 
	 
	 <td><input type="submit" value="Search"></td> 
					
				</form>

	</tr>
	
	<br><br>	
	<a href="reportThree.jsp">Go Back</a>
	
</body>
</html>