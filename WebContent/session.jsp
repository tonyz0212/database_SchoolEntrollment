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
	
	int classid = Integer.parseInt(request.getParameter("classid"));
	
	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {
    	int sessionid = Integer.parseInt(request.getParameter("SESSIONID"));
		int limit = Integer.parseInt(request.getParameter("LIMIT"));
		String faculty = request.getParameter("FACULTY");
    	cm.insertSession(sessionid, classid, limit, faculty);
	}
		
	if (action != null && action.equals("update")) {
    	int sessionid = Integer.parseInt(request.getParameter("SESSIONID"));
		int limit = Integer.parseInt(request.getParameter("LIMIT"));
		String faculty = request.getParameter("FACULTY");
    	cm.updateSession(sessionid, classid, limit, faculty);
	}
	
	if (action != null && action.equals("delete")) {
		cm.deleteSession(Integer.parseInt(request.getParameter("SESSIONID")));
		
	}	
%>
	<h4>Sessions for class <%=classid%></h4>
	<table>
		<tr>
			<th>SessionID</th>
			<th>Limit</th>		
			<th>Faculty</th>	
		</tr>
		
		<tr>
			<form action="session.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="SESSIONID" size="10"></th> 
				<th><input value="" name="LIMIT" size="10"></th>
				<th><input value="" name="FACULTY" size="20"></th>
				<input type="hidden" value="<%= classid %>" name="classid">
				<th><input type="submit" value="Insert"></th>
				
	  		</form>
		</tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT * from session where classid =  " + classid + ";");
		while (rset.next ()) {
		%><tr>	
				<form action="session.jsp" method="get">
					<input type="hidden" value="update" name="action"> 
					<td><input value="<%= rset.getInt(1) %>" name="SESSIONID" size="10" readonly="readonly"></td> 
					<td><input value="<%= rset.getInt(3) %>" name="LIMIT" size="10"></td>
					<td><input value="<%= rset.getString(4) %>" name="FACULTY" size="20"></td>
					<input type="hidden" value="<%= classid %>" name="classid">
					<td><a href="weeklyMeeting.jsp?sessionid=<%=rset.getInt(1)%>"> weekly meeting </td>
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
				<form action="session.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getInt(1)%>" name="SESSIONID">
					<input type="hidden" value="<%= classid %>" name="classid">
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
	<a href="class.jsp">GO BACK</a>
	
</body>
</html>