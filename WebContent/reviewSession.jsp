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
<title>Review Session </title>
</head>
<body>
<%
	SystemManager system = (SystemManager) request.getSession().getAttribute("sm");
	CourseManager cm = system.getCM();
	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {
    	int id = Integer.parseInt(request.getParameter("SESSIONID"));
    	String start = request.getParameter("START");
    	String end = request.getParameter("END");
    	String reviewDate = request.getParameter("REVIEWDATE");
    	String location  = request.getParameter("LOCATION");
    	cm.insertReviewSession(id,location,start,end,reviewDate);
	}
	
	if (action != null && action.equals("update")) {
		int id = Integer.parseInt(request.getParameter("ID"));
		int sessionid = Integer.parseInt(request.getParameter("SESSIONID"));
    	String start = request.getParameter("START");
    	String end = request.getParameter("END");
    	String reviewDate = request.getParameter("REVIEWDATE");
    	String location  = request.getParameter("LOCATION");
    	cm.updateReviewSession(id, sessionid, location,start,end,reviewDate);
	}
	
	if (action != null && action.equals("delete")) {
		cm.deleteReviewSession(Integer.parseInt(request.getParameter("ID")));
	}

	
%>	
	<!-- <a href="undergraduate.jsp">Undergraduate Info</a><br>
	<a href="graduate.jsp">Graduate Info</a><br>
	 -->
	<table>
		<tr>
			<th>Session ID</th>
			<th>Location</th>
			<th>Start Time</th>
			<th>End Time</th>
			<th>Review Date</th>
			
		</tr>
		
		<tr>
			<form action="reviewSession.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="SESSIONID" size="10"></th> 
				<th><input value="" name="LOCATION" size="10"></th> 
				<td><input placeholder = "HH:MM:SS" value="" name="START" size="10"></td> 
				<td><input placeholder = "HH:MM:SS" value="" name="END" size="10"></td>  
				<td><input placeholder = "yyyy-mm-dd" value="" name="REVIEWDATE" size="10"></td> 
			
	
				<th><input type="submit" value="Insert" size ="15"></th>
	  		</form>
		</tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT * FROM review_session");
		while (rset.next ()) {
		%><tr>
				<form action="reviewSession.jsp" method="get">
					<input type="hidden" value="update" name="action"> 
					<%-- <td><input value="<%= rset.getInt(1) %>" name="ID" size="10" ></td>  --%>
					<input type="hidden" value="<%= rset.getInt(1)%>" name="ID">
					
					<td><input value="<%= rset.getInt(2) %>" name="SESSIONID" size="10" ></td> 
					<td><input value="<%= rset.getString(3) %>" name="LOCATION" size="10"></td> 
					<td><input value="<%= rset.getTime(4) %>" name="START" size="10"></td> 
					<td><input value="<%= rset.getTime(5) %>" name="END" size="10"></td> 
					<td><input value="<%= rset.getDate(6) %>" name="REVIEWDATE" size="10"></td>		
			
	
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
				<form action="reviewSession.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getInt(1)%>" name="ID">
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
	
	<a href="index.jsp">GO BACK</a>
	
</body>
</html>