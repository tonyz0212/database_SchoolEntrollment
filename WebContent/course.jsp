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
	
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {
		
    	String code = request.getParameter("CODE");
    	int grade_option = Integer.parseInt(request.getParameter("GRADE")); 
    	int ctype = Integer.parseInt(request.getParameter("TYPE")); 
    	boolean consent = Boolean.parseBoolean(request.getParameter("CONSENT")); 
    	int min_unit = Integer.parseInt(request.getParameter("MINUNIT")); 
    	int max_unit = Integer.parseInt(request.getParameter("MAXUNIT")); 
    	int degree = Integer.parseInt(request.getParameter("DEPARTMENT"));
    	boolean lab = Boolean.parseBoolean(request.getParameter("LAB")); 
    	
    	cm.insertCourse(code, grade_option, ctype, consent, min_unit, max_unit, degree, lab);
	}
	
	if (action != null && action.equals("update")) {
		
    	int id = Integer.parseInt(request.getParameter("ID"));
    	String code = request.getParameter("CODE");
    	int grade_option = Integer.parseInt(request.getParameter("GRADE")); 
    	int ctype = Integer.parseInt(request.getParameter("TYPE")); 
    	boolean consent = Boolean.parseBoolean(request.getParameter("CONSENT")); 
    	int min_unit = Integer.parseInt(request.getParameter("MINUNIT")); 
    	int max_unit = Integer.parseInt(request.getParameter("MAXUNIT")); 
    	int degree = Integer.parseInt(request.getParameter("DEPARTMENT"));
    	boolean lab = Boolean.parseBoolean(request.getParameter("LAB")); 
    	
    	cm.updateCourse(id, code, grade_option, ctype, consent, min_unit, max_unit, degree, lab);
	}	
	
	if (action != null && action.equals("delete")) {
		// Create the prepared statement and use it to // DELETE the student FROM the Student table. PreparedStatement 
		cm.deleteCourse(Integer.parseInt(request.getParameter("ID")));
		
	}

	
%>
	<table>
		<tr>
			<th>ID</th>
			<th>CODE</th>
			<th>GRADE</th>
			<th>TYPE</th>
			<th>CONSENT</th>
			<th>MIN_UNIT</th>
			<th>MAX_UNIT</th>
			<th>DEPT.CODE</th>
			<th>LAB</th>
		</tr>
		
		<tr>
			<form action="course.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<td><input value="" name="ID" size="10" readonly="readonly"></td> 
				<th><input value="" name="CODE" size="15"></th> 
				<!--  <th><input value="" name="GRADE" size="15"></th> --> 
				
				<th>
				       <select name="GRADE">
                         <option value="0">Letter</option>
                         <option value="1">PNP</option>
                         <option value="2">Letter/PNP</option>
                       </select>
                </th> 
				<!-- <th><input value="" name="TYPE" size="15"></th> -->
				
				<th>
				       <select name="TYPE">
                         <option value="0">Upper</option>
                         <option value="1">Lower</option>
                       </select>
                </th> 
                
				<th><input placeholder = "true/false" value="" name="CONSENT" size="15"></th> 
				<th><input value="" name="MINUNIT" size="15"></th> 
				<th><input value="" name="MAXUNIT" size="15"></th> 
				<th><input placeholder = "dept.id" value="" name="DEPARTMENT" size="15"></th> 
				<th><input placeholder = "true/false" value="" name="LAB" size="15"></th> 
				<th><input type="submit" value="Insert" size ="15"></th>
	  		</form>
		</tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT * FROM course");
		while (rset.next ()) {
		%><tr>
				<form action="course.jsp" method="get">
					<input type="hidden" value="update" name="action"> 
					<td><input value="<%= rset.getInt(1) %>" name="ID" size="10" readonly="readonly"></td> 
					<td><input value="<%= rset.getString(2) %>" name="CODE" size="15"></td> 
					<!--  <td><input value="<%= rset.getInt(3) %>" name="GRADE" size="15"></td>  -->
					
										 
					 <% if (rset.getInt(3) == 0) { %>
				<th>
				       <select name="GRADE">
                         <option value="0" selected = "selected">Letter</option>
                         <option value="1">PNP</option>
                         <option value="2">Letter/PNP</option>
                       </select>
                </th> 
                	<%} if (rset.getInt(3) == 1) { %>
				<th>
				       <select name="GRADE">
                         <option value="0">Letter</option>
                         <option value="1" selected = "selected">PNP</option>
                         <option value="2">Letter/PNP</option>
                       </select>
                </th> 
                	<%} if (rset.getInt(3) == 2) { %>
				<th>
				       <select name="GRADE">
                         <option value="0">Letter</option>
                         <option value="1">PNP</option>
                         <option value="2" selected = "selected">Letter/PNP</option>
                       </select>
                </th> 
                	
                	<%}%>
					<!--  <td><input value="<%= rset.getInt(4) %>" name="TYPE" size="15"></td> -->
					
					<% if (rset.getInt(4) == 0) { %>
					<th>
				       <select name="TYPE">
                         <option value="0" selected = "selected">Upper</option>
                         <option value="1">Lower</option>
                       </select>
                	</th> 
                	<%} if (rset.getInt(4) == 1) { %>
					<th>
				       <select name="TYPE">
                         <option value="0">Upper</option>
                         <option value="1" selected = "selected">Lower</option>
                       </select>
                	</th> 
                	<%}%>
                	 
					<td><input value="<%= rset.getBoolean(5) %>" name="CONSENT" size="15"></td> 
					<td><input value="<%= rset.getInt(6) %>" name="MINUNIT" size="15"></td> 
					<td><input value="<%= rset.getInt(7) %>" name="MAXUNIT" size="15"></td> 
					<td><input value="<%= rset.getInt(8) %>" name="DEPARTMENT" size="15"></td> 
					<td><input value="<%= rset.getBoolean(9) %>" name="LAB" size="15"></td> 
					<td><a href="prerequest.jsp?courseid=<%=rset.getInt(1)%>&coursecode=<%=rset.getString(2)%>"> prerequest </td>
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
				<form action="course.jsp" method="get">
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