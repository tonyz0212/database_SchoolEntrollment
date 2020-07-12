<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="org.postgresql.Driver" %>
<%@ page import="cse132b.copy.SystemManager" %>
<%@ page import="cse132b.copy.DegreeEntryManager" %>
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
	DegreeEntryManager sm = system.getDegreeM();

	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {
	/* 	int id = Integer.parseInt(request.getParameter("id"));
		System.out.println(" id is "+ id); */
    	String name = request.getParameter("name");
    	int required_units = Integer.parseInt(request.getParameter("required_units"));
    	String type = request.getParameter("degree_type");
    	int department_id = Integer.parseInt(request.getParameter("department_id"));

    	sm.insertDegree(name, required_units, type, department_id);
	}
	
	if (action != null && action.equals("update")) {
		int unit = Integer.parseInt(request.getParameter("required_units"));
		int department_id = Integer.parseInt(request.getParameter("department_id"));
    	sm.updateDegree( unit, department_id);
    	
	}
	
	if (action != null && action.equals("delete")) {
		int id = Integer.parseInt(request.getParameter("id"));
			sm.deleteDegree(id); 		
	} 

	
%>
	<a href="lower.jsp">Lower Division Form</a>
	<br>
	<a href="upper.jsp">Upper Division Form</a>
	<table>
		<tr>
			<th>Name</th>
			<th>Min Unit</th>
			<th>Degree Type</th>
			<th>Department ID</th>		
		</tr>
		
		<tr>
			<form action="degreeRequirement.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
			<!-- 	<th><input value="" name="id" size="10"></th>  -->
				<th><input value="" name="name" size="10"></th> 
				<th><input value="" name="required_units" size="10"></th>
				<th>
                      <select name="degree_type">
                        <option value="bs">bachelor's degree</option>
                        <option value="ms">Master's Degree</option>
                        <option value="phd"> PHD </option>
                      </select>
                </th>
               	<th><input value="" name="department_id" size="10"></th> 
				<th><input type="submit" value="Insert" size ="15"></th>
	  		</form>
		</tr>
	<%
	try {
		
		Statement stmt = system.getConnection().createStatement();
		ResultSet rset = stmt.executeQuery ("SELECT * FROM degree");
		while (rset.next ()) {
		%><tr>
				<form action="degreeRequirement.jsp" method="get">
					<input type="hidden" value="update" name="action"> 
					<%-- <td><input value="<%= rset.getInt(1) %>" name="id" size="5" readonly="readonly" ></td>	 --%>
					<td><input value="<%= rset.getString(2) %>" name="name" readonly ="readonly" size="10" ></td> 
				    <td><input value="<%= rset.getInt(3) %>" name="required_units" size="10" ></td>					
					<td><input value="<%= rset.getString(4) %>" name="degree_type" size="18" readonly ="readonly"></td> 	  		
				    <td><input value="<%= rset.getInt(5) %>" name="department_id" size="10" readonly ="readonly" ></td>					
				
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
		<form action="degreeRequirement.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getInt(1)%>" name="id">
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
		throw new RuntimeException(e);
	}
	%> 
	</table>
	
	<a href="index.jsp">GO BACK</a>
	
</body>
</html>