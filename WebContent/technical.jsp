<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="org.postgresql.Driver" %>
<%@ page import="cse132b.copy.SystemManager" %>
<%@ page import="cse132b.copy.ThesisManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>


<html>
<head>
<meta charset="UTF-8">
<title>Technical Elective</title>
</head>
<body>
<%
	SystemManager system = (SystemManager) request.getSession().getAttribute("sm");
	ThesisManager sm = system.getThesis();


	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {

		//int id = Integer.parseInt(request.getParameter("techid"));
		int courseid = Integer.parseInt(request.getParameter("courseid"));

   		sm.insertTechnical( courseid); 
	}
	
	if (action != null && action.equals("update")) {
		int id = Integer.parseInt(request.getParameter("thesis_id"));
		int student_id = Integer.parseInt(request.getParameter("student_id"));
		System.out.println("student_id = " + student_id);
   		sm.updateThesis(id,student_id);     	
	}
	
	if (action != null && action.equals("delete")) {
		int id = Integer.parseInt(request.getParameter("techid"));
		
			sm.deleteTechnical(id);
		 
	} 

	
%>
	
	<table>
		<tr>
			<th>Elective ID</th>
			<th>Course ID</th>		
		</tr>
		
		<tr>
			<form action="technical.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="techid" size="10" readonly = 'readonly'></th> 
				<th><input value="" name="courseid" size="10"></th> 
				<th><input type="submit" value="Insert" size ="15"></th>
				
	  		</form>
		</tr>
	<%
	try {
		
		Statement stmt = system.getConnection().createStatement();
		ResultSet rset = stmt.executeQuery ("SELECT t.techid,t.courseid, c.code FROM technical_elective t, course c where t.courseid = c.id");
	
		while (rset.next ()) {
		%><tr>
				<form action="technical.jsp" method="get">
					<input type="hidden" value="update" name="action"> 
					<td><input value="<%= rset.getInt(1) %>" name="techid" size="10" readonly="readonly" ></td>	
					<td><input value="<%= rset.getInt(2) %>" name="courseid" size="10" ></td> 
					<td><input value="<%= rset.getString(3) %>" name="coursename" size="10" ></td> 
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
		<form action="technical.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getInt(1)%>" name="techid">
					<td><input type="submit" value="Delete"></td> 
				</form> 
			</tr>
	<%
		}
		rset.close();
		stmt.close();
	}
	catch(SQLException e) {
		e.printStackTrace();
	}
	%> 
	</table>
	
	<a href="index.jsp">GO BACK</a>
	
</body>
</html>