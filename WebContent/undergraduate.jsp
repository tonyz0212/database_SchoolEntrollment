<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="org.postgresql.Driver" %>
<%@ page import="cse132b.copy.SystemManager" %>
<%@ page import="cse132b.copy.StudentManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<html>
<head>
<meta charset="UTF-8">
<title>hello, cse132</title>
</head>
<body>
	
<%
	SystemManager system = (SystemManager) request.getSession().getAttribute("sm");
	StudentManager sm = system.getSM();
	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	
	
	if (action != null && action.equals("insert")) {
		int studentid = Integer.parseInt(request.getParameter("STUDENTID"));
		String college = request.getParameter("COLLEGE");
		String major = request.getParameter("MAJOR");
		String minor = request.getParameter("MINOR");
	
		sm.insertUnder(studentid, college, major, minor);
	}
	
	if (action != null && action.equals("update")) {
		int underid = Integer.parseInt(request.getParameter("UNDERID"));
		String college = request.getParameter("COLLEGE");
		String major = request.getParameter("MAJOR");
		String minor = request.getParameter("MINOR");
	
		sm.updateUnder(underid, college, major, minor);
	}
	
	if (action != null && action.equals("delete")) {
		sm.deleteUnder(Integer.parseInt(request.getParameter("UNDERID")));
		
	}

	
%>
	<table>
		<tr>
			<th>STD ID</th>
			<th>COLLEGE</th>
			<th>MAJOR</th>
			<th>MINOR</th>
			
		</tr>
		
		<tr>
			<form action="undergraduate.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="STUDENTID" size="10"></th> 
				<th><input value="" name="COLLEGE" size="10"></th> 
				<th><input value="" name="MAJOR" size="10"></th> 
				<th><input value="" name="MINOR" size="10"></th> 
				<th><input type="submit" value="Insert"></th>
	  		</form>
		</tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT * FROM undergraduate");
		while (rset.next ()) {
		%><tr>
				<form action="undergraduate.jsp" method="get">
					<input type="hidden" value="update" name="action">
					<input type = "hidden" value="<%= rset.getInt(1) %>" name="UNDERID" size="10">
					<td><input value="<%= rset.getInt(2) %>" name="STUDENTID" size="10" readonly = "readonly" ></td>
					<td><input value="<%= rset.getString(3) %>" name="COLLEGE" size="10"></td>
					<td><input value="<%= rset.getString(4) %>" name="MAJOR" size="10"></td> 
					<td><input value="<%= rset.getString(5) %>" name="MINOR" size="10"></td>
					
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
				<form action="undergraduate.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getInt(1) %>" name="UNDERID">
					<td><input type="submit" value="Delete"></td> 
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
	
	<a href="student.jsp">GO BACK</a>
	
</body>
</html>