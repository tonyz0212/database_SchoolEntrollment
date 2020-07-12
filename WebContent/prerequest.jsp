<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="org.postgresql.Driver" %>
<%@ page import="cse132b.copy.SystemManager" %>
<%@ page import="cse132b.copy.CourseManager" %>
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
	CourseManager cm = system.getCM();
	
	int courseid = Integer.parseInt(request.getParameter("courseid"));
	String coursecode = request.getParameter("coursecode");
	
	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {
    	int requestid = Integer.parseInt(request.getParameter("REQUESTID"));

    	cm.insertPrerequest(courseid, requestid);
	}
		
	if (action != null && action.equals("delete")) {
		cm.deletePrerequest(Integer.parseInt(request.getParameter("ID")));
		
	}	
%>
	<h4>Prerequest for <%=coursecode%></h4>
	<table>

		
		<tr>
			<form action="prerequest.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input placeholder = "courseid" value="" name="REQUESTID" size="20"></th> 
				<input type="hidden" value="<%= courseid%>" name="courseid">
				<input type="hidden" value="<%= coursecode%>" name="coursecode">
				<th><input type="submit" value="Insert"></th>
				
	  		</form>
		</tr>
		
		<tr>
			<th>CourseID</th>
			<th>CourseCode</th>			
		</tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT p.requestid,c.code,p.id FROM prerequest p, course c WHERE p.courseid = c.id AND c.id =  " + courseid + ";");
		while (rset.next ()) {
		%><tr>
				<form action="prerequest.jsp" method="get">
					<td><%= rset.getInt(1) %></td> 
					<td><%= rset.getString(2) %></td> 
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getInt(3)%>" name="ID">
					<input type="hidden" value="<%= courseid%>" name="courseid">
					<input type="hidden" value="<%= coursecode%>" name="coursecode">
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
	<br>
	<a href="course.jsp">GO BACK</a>
	
</body>
</html>