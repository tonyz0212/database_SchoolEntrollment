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
	
	int sessionid = Integer.parseInt(request.getParameter("sessionid"));
	
	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {
    	String start = request.getParameter("START");
    	String end = request.getParameter("END");
		int day = Integer.parseInt(request.getParameter("DAY"));
		int type = Integer.parseInt(request.getParameter("TYPE"));
		String location = request.getParameter("LOCATION");
		boolean mandatory = Boolean.parseBoolean(request.getParameter("MANDATORY"));
    	
		cm.insertWeeklyMeeting(sessionid, start, end, day, type, location, mandatory);
	}
		
	if (action != null && action.equals("update")) {
    	int meetingid = Integer.parseInt(request.getParameter("MEETINGID"));
    	String start = request.getParameter("START");
    	String end = request.getParameter("END");
		int day = Integer.parseInt(request.getParameter("DAY"));
		int type = Integer.parseInt(request.getParameter("TYPE"));
		String location = request.getParameter("LOCATION");
		boolean mandatory = Boolean.parseBoolean(request.getParameter("MANDATORY"));
    	
		cm.updateWeeklyMeeting(meetingid, sessionid, start, end, day, type, location, mandatory);
	}
	
	if (action != null && action.equals("delete")) {
		cm.deleteWeeklyMeeting(Integer.parseInt(request.getParameter("MEETINGID")));
		
	}	
%>
	<h4>Weekly Meeting for Session <%=sessionid%></h4>
	<table>
		<tr>
		
			<th>MeetingID</th>
			<th>Start</th>		
			<th>End</th>
			<th>Day</th>
			<th>Type</th>
			<th>Location</th>
			<th>Mandatory</th>	
		</tr>

		<tr>
			<form action="weeklyMeeting.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input readonly="readonly" value="" name="MEETINGID" size="10"></th> 
				<th><input placeholder = "hh:mm:ss" value="" name="START" size="10"></th>
				<th><input placeholder = "hh:mm:ss" value="" name="END" size="10"></th>
				<!-- <th><input placeholder = "1-7" value="" name="DAY" size="10"></th>   -->
					<th>
				       <select name="DAY">
                         <option value="1">Monday</option>
                         <option value="2">Tuesday</option>
                         <option value="3">Wednesday</option>
                         <option value="4">Thursday</option>
                         <option value="5">Friday</option>
                       </select>
                	</th>			
				
				<!--  <th><input value="" name="TYPE" size="10"></th> -->
				
					<th>
				       <select name="TYPE">
                         <option value="0">Lecture</option>
                         <option value="1">Discussion</option>
                         <option value="2">Lab</option>
                         <option value="3">Stdio</option>
                       </select>
                	</th>
                	
				<th><input value="" name="LOCATION" size="20"></th>
				<th><input placeholder = "true/false" value="" name="MANDATORY" size="10"></th> 
				<input type="hidden" value="<%= sessionid %>" name="sessionid">
				<th><input type="submit" value="Insert"></th>
				
	  		</form>
		</tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT * from weekly_meeting where session =  " + sessionid + ";");
		while (rset.next ()) {
		%><tr>	
				<form action="weeklyMeeting.jsp" method="get">
					<input type="hidden" value="update" name="action"> 
					<td><input value="<%= rset.getInt(1) %>" name="MEETINGID" size="10" readonly="readonly"></td> 
					<td><input value="<%= rset.getTime(3) %>" name="START" size="10"></td>
					<td><input value="<%= rset.getTime(4) %>" name="END" size="10"></td>
					<!--  <td><input value="<%= rset.getInt(5) %>" name="DAY" size="10"></td> -->
					                
                	<% if (rset.getInt(5) == 1) { %>
					<th>
				       <select name="DAY">
                         <option value="1" selected = "selected">Monday</option>
                         <option value="2">Tuesday</option>
                         <option value="3">Wednesday</option>
                         <option value="4">Thursday</option>
                         <option value="5">Friday</option>
                       </select>
                	</th>	
                	<%} if (rset.getInt(5) == 2) { %>
					<th>
				       <select name="DAY">
                         <option value="1">Monday</option>
                         <option value="2" selected = "selected">Tuesday</option>
                         <option value="3">Wednesday</option>
                         <option value="4">Thursday</option>
                         <option value="5">Friday</option>
                       </select>
                	</th>	
                	<%} if (rset.getInt(5) == 3) { %>
					<th>
				       <select name="DAY">
                         <option value="1">Monday</option>
                         <option value="2">Tuesday</option>
                         <option value="3" selected = "selected">Wednesday</option>
                         <option value="4">Thursday</option>
                         <option value="5">Friday</option>
                       </select>
                	</th>	
                	<%} if (rset.getInt(5) == 4) { %>
					<th>
				       <select name="DAY">
                         <option value="1">Monday</option>
                         <option value="2">Tuesday</option>
                         <option value="3">Wednesday</option>
                         <option value="4" selected = "selected">Thursday</option>
                         <option value="5">Friday</option>
                       </select>
                	</th>	
                	<%} if (rset.getInt(5) == 5) { %>
					<th>
				       <select name="DAY">
                         <option value="1">Monday</option>
                         <option value="2">Tuesday</option>
                         <option value="3">Wednesday</option>
                         <option value="4">Thursday</option>
                         <option value="5" selected = "selected">Friday</option>
                       </select>
                	</th>	
                	<%}%>
                	
                	
					<!--  <td><input value="<%= rset.getInt(6) %>" name="TYPE" size="10"></td> -->
 
                
                	<% if (rset.getInt(6) == 0) { %>
					<th>
				       <select name="TYPE">
                         <option value="0" selected = "selected">Lecture</option>
                         <option value="1">Discussion</option>
                         <option value="2">Lab</option>
                         <option value="3">Stdio</option>
                       </select>
                	</th>
                	<%} if (rset.getInt(6) == 1) { %>
					<th>
				       <select name="TYPE">
                         <option value="0">Lecture</option>
                         <option value="1" selected = "selected">Discussion</option>
                         <option value="2">Lab</option>
                         <option value="3">Stdio</option>
                       </select>
                	</th>
                	<%} if (rset.getInt(6) == 2) { %>
  					<th>
				       <select name="TYPE">
                         <option value="0">Lecture</option>
                         <option value="1">Discussion</option>
                         <option value="2" selected = "selected">Lab</option>
                         <option value="3">Stdio</option>
                       </select>
                	</th>
                	<%} if (rset.getInt(6) == 3) { %>
					<th>
				       <select name="TYPE">
                         <option value="0">Lecture</option>
                         <option value="1">Discussion</option>
                         <option value="2">Lab</option>
                         <option value="3" selected = "selected">Stdio</option>
                       </select>
                	</th>
                	
                	<%}%>
                
					<td><input value="<%= rset.getString(7) %>" name="LOCATION" size="20"></td>
					<td><input value="<%= rset.getBoolean(8) %>" name="MANDATORY" size="10"></td>
					<input type="hidden" value="<%= sessionid %>" name="sessionid">
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
				<form action="weeklyMeeting.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getInt(1) %>" name="MEETINGID">
					<input type="hidden" value="<%= sessionid %>" name="sessionid">
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