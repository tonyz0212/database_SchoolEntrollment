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
<title>hello, cse132</title>
</head>
<body>
	<tr>
	<form action="resultMasterDegreeRemain.jsp" method="get">
		
		<th>
			Master Student  
             <select name="sid">
<%
	SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
	try {
		Statement stmt = system.getConnection().createStatement ();
	    ResultSet rset = stmt.executeQuery ("SELECT s.id, s.ssn, s.firstname, s.middlename, s.lastname" 
				+ " FROM student s, student_enrollment se "
				+ " where s.id = se.studentid and s.level = 1 and se.quarter =3 and se.year =2020;"); 
		
		while (rset.next ()) {
		%>
             <option value="<%= rset.getInt(1) %>"> <%= rset.getInt(2) %>-<%= rset.getString(3)%>-<%= rset.getString(4)%>-<%= rset.getString(5) %>></option>
	<%
		}
		rset.close();
		stmt.close();
	} catch(SQLException e) {
		e.printStackTrace();
	}
	%> 
	 </select>
	 
	 Degree   
             <select name="degreeid">
<%
	 
	try {
		Statement stmt = system.getConnection().createStatement ();
		 ResultSet rset = stmt.executeQuery ("SELECT d.name, d.degree_type" 
					+ " FROM degree d where d.degree_type ='MS'; ");  
		
		while (rset.next ()) {
		%>
             <option value="<%= rset.getString(1) %>"> <%= rset.getString(1) %> </option>
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
	<a href="query.jsp">GO BACK</a>
	
</body>
</html>