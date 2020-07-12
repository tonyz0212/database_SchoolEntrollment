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
<title>Thesis Instructor</title>
</head>
<body>
<%
	SystemManager system = (SystemManager) request.getSession().getAttribute("sm");
	ThesisManager sm = system.getThesis();


	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {

		int id = Integer.parseInt(request.getParameter("thesis_id"));
    	int department  = Integer.parseInt(request.getParameter("department"));
    	String faculty = request.getParameter("faculty");
	
   		sm.insertThesisInstructor(id,department,faculty); 
	}
	
	if (action != null && action.equals("update")) {
	
		int id = Integer.parseInt(request.getParameter("departmentname"));
		String faculty = request.getParameter("faculty");
     	sm.updateThesisInstructor(id,faculty); 
    	
	}
	
	if (action != null && action.equals("delete")) {
		int id = Integer.parseInt(request.getParameter("id"));
		 if (request.getParameter("id") == null){
			System.out.println("null");
		} 
		 else{
		   // int id = Integer.parseInt(request.getParameter("id"));
			sm.deleteThesisInstructor(id); 
		 }
	} 

	
%>
	
	<table>
		<tr>
			<th>Thesis ID</th>
			<th>Department</th>
			<th>Faculty</th>		
		</tr>
		
		<tr>
			<form action="thesis_instructor.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="thesis_id" size="15"></th> 
				<th><input placeholder = "dept.id" value="" name="department" size="15"></th> 
				<th><input value="" name="faculty" size="15"></th>  
                
                
				<th><input type="submit" value="Insert" size ="15"></th>
				
	  		</form>
		</tr>
		
	<%
	try {
		
		Statement stmt = system.getConnection().createStatement();
		//ResultSet rset = stmt.executeQuery ("SELECT * FROM thesis_instructor");
		ResultSet rset = stmt.executeQuery ("SELECT t.thesisId, d.name, t.faculty_name, t.id FROM department d, thesis_instructor t  where d.id = t.department;"); 
	
		
		while (rset.next ()) {
		%><tr>
				<form action=thesis_instructor.jsp method="get">
			     	<input type="hidden" value="update" name="action"> 
					
				    <td><input value="<%= rset.getInt(1) %>" name="departmentname" size="15"readonly="readonly" ></td>	
					<td><input value="<%= rset.getString(2) %>" name="thesis_id" size="15" readonly="readonly" ></td>	
					<td><input value="<%= rset.getString(3) %>" name="faculty" size="15" ></td> 
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
		<form action="thesis_instructor.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getInt(4)%>" name="id">
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
	<a href="thesis.jsp">GO BACK</a> 
	
	
	
</body>
</html>