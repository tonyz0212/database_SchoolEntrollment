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
<title> Course Enrollment  </title>
</head>
<body>
<%
	SystemManager system = (SystemManager) request.getSession().getAttribute("sm");
	CourseManager sm = system.getCM();
	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {
    	int studentid = Integer.parseInt(request.getParameter("STUDENTID"));
    	int classid = Integer.parseInt(request.getParameter("COURSEID"));
    	int sessionid = Integer.parseInt(request.getParameter("SESSIONID"));
    	int unit = Integer.parseInt(request.getParameter("UNIT"));

    	sm.insertCourseEnroll(studentid, classid , sessionid, unit);
    	}
	
	if (action != null && action.equals("update")) {
    	int sessionid = Integer.parseInt(request.getParameter("SESSIONID"));
    	int unit = Integer.parseInt(request.getParameter("UNIT"));
    	int id = Integer.parseInt(request.getParameter("ID"));
    	int grade = Integer.parseInt(request.getParameter("GRADE"));
    	sm.updateCourseEnroll(id, sessionid, unit, grade);
	}
	
	if (action != null && action.equals("delete")) {
		int id = Integer.parseInt(request.getParameter("ID"));
		sm.deleteCourseEnroll(id);
		
	}

	
%>	
	 
	<table>
		<tr>
			<th>Student ID</th>
			<th>Course ID</th>
			<th>Session ID</th>
			<th>Unit</th>
			<th>GradeOption</th>
			 
			
		</tr>
		
		<tr>
			<form action="courseEnrollment.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="STUDENTID" size="10"></th> 
				<th><input value="" name="COURSEID" size="10"></th> 
				<td><input  value="" name="SESSIONID" size="10"></td>  
				<td><input  value="" name="UNIT" size="10"></td>  
				<td><input  placeholder="chose latter" value="" name="UNIT" size="10" readonly="readonly"></td>  
							
				<th><input type="submit" value="Insert" size ="15"></th>
	  		</form>
		</tr>
	<%
	try {

		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT * FROM course_enrollment");
		
		while (rset.next ()) {
			Statement stmt2 = system.getConnection().createStatement ();
			ResultSet GradeOption = stmt2.executeQuery ("SELECT grade_option FROM course c WHERE c.id = " + rset.getString(3) + ";");

			// GradeOption.next();
			int choice = -1;

			while (GradeOption.next()) {
				choice = GradeOption.getInt(1);
			} 
			GradeOption.close();
			stmt2.close();
		%><tr>
		
				<form action="courseEnrollment.jsp" method="get">
					<input type="hidden" value="update" name="action"> 
					<input type = "hidden" value="<%= rset.getInt(1) %>" name="ID" >
					
					<td><input value="<%= rset.getInt(2) %>" name="STUDENTID" size="10" readonly="readonly" ></td> 
					<td><input value="<%= rset.getString(3) %>" name="COURSEID" size="10" readonly="readonly"></td> 
					<td><input value="<%= rset.getString(4) %>" name="SESSIONID" size="10"></td> 
					<td><input value="<%= rset.getString(5) %>" name="UNIT" size="10"></td> 
					
					<% if (choice == 0 && rset.getInt(6) == -1) { %>
					<th>
				       <select id = "grade" name="GRADE">
				         <option value="-1" selected = "selected">--select--</option>
                         <option value="0">LETTER</option>
                       </select>
                	</th> 
                	<%}%>
                	
                	<% if (choice == 0 && rset.getInt(6) != -1) { %>
					<th>
				       <select id = "grade" name="GRADE">
                         <option value="0" selected = "selected">LETTER</option>
                       </select>
                	</th> 
                	<%}%>
                	
                	<% if (choice == 1 && rset.getInt(6) == -1) { %>
					<th>
				       <select id = "grade" name="GRADE">
				         <option value="-1" selected = "selected">--select--</option>
                         <option value="1">PNP</option>
                       </select>
                	</th> 
                	<%}%>
                	
                	<% if (choice == 1 && rset.getInt(6) != -1) { %>
					<th>
				       <select id = "grade" name="GRADE">
                         <option value="1" selected = "selected">PNP</option>
                       </select>
                	</th> 
                	<%}%>
                	
                	<% if (choice == 2 && rset.getInt(6) == -1) { %>
					<th>
				       <select id = "grade" name="GRADE">
				         <option value="-1" selected = "selected">--select--</option>
                         <option value="0">LETTER</option>
                         <option value="1">PNP</option>
                       </select>
                	</th> 
                	<%}%>
                	
                	<% if (choice == 2 && rset.getInt(6) == 0) { %>
					<th>
				       <select id = "grade" name="GRADE">
                         <option value="0" selected = "selected">LETTER</option>
                         <option value="1">PNP</option>
                       </select>
                	</th> 
                	<%}%>
                	
                	<% if (choice == 2 && rset.getInt(6) == 1) { %>
					<th>
				       <select id = "grade" name="GRADE">
                         <option value="0">LETTER</option>
                         <option value="1" selected = "selected">PNP</option>
                       </select>
                	</th> 
                	<%}%>
                	
                	
				
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
				<form action="courseEnrollment.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getInt(1) %>" name="ID" >

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