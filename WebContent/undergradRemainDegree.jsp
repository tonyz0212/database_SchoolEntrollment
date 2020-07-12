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
	<form action="resultUndergradRemainDegree.jsp" method="get">
		
		<th>
		Student in current quarter: 
        <select name="sid">
<%
	SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
	try {
		Statement stmt = system.getConnection().createStatement ();
	    ResultSet rset = stmt.executeQuery ("SELECT s.id, s.ssn, s.firstname, s.middlename, s.lastname" 
				+ " FROM student s, student_enrollment se "	
				+ " where s.id = se.studentid and se.quarter =3 and se.year =2020 and s.level = 0;"); 
		
		while (rset.next ()) {
		%>
             <option value="<%= rset.getInt(1) %>"> <%= rset.getInt(2) %>-<%= rset.getString(3)%>-<%= rset.getString(4)%>-<%= rset.getString(5) %></option>
	<%
		}
		rset.close();
		stmt.close();
	} catch(SQLException e) {
		e.printStackTrace();
	}
	%> 
	 </select>
	 
	 degree: 
        <select name="degreeid">
<%
	 	
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT d.id, d.name, d.degree_type" 
				+ " FROM degree d where d.degree_type='BS'; "); 
		
		while (rset.next ()) {
		%>
             <option value="<%= rset.getInt(1) %>"> <%= rset.getString(2) %></option>
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


	<tr>
<%-- 	<form action="bscDegree.jsp" method="get">
		<th>
		   <br>
		   Bachelor of Science Degree:<br>
		   Degree Name - Degree Type <br>
		   <br>
           <select name="sid">
<%

	
	try {
		Statement stmt = system.getConnection().createStatement ();
	    ResultSet rs2 = stmt.executeQuery ("SELECT d.id, d.name, d.degree_type" 
				+ " FROM degree d where d.degree_type='BS'; "); 
		
		while (rs2.next ()) {
		%>

			       <option value="<%= rs2.getInt(1) %>"> <%= rs2.getString(2) %>-<%= rs2.getString(3) %> </option> 
	<%
		}
		rs2.close();
		stmt.close();
	} catch(SQLException e) {
		e.printStackTrace();
	}
	%> 
	 </select>
	 <td><input type="submit" value="Search"></td> 
					
				</form>
 --%>
			</tr>



	
	<br><br>	
	<a href="query.jsp">GO BACK</a>
	
</body>
</html>