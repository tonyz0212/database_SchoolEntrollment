<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="org.postgresql.Driver" %>
<%@ page import="cse132b.copy.SystemManager" %>
<%@ page import="cse132b.copy.DepartmentManager" %>
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
	DepartmentManager dm = system.getDM();
	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {
    	int id = Integer.parseInt(request.getParameter("ID"));
    	String name = request.getParameter("NAME");

    	int succ = dm.insertDepartment(id, name);
    	if (succ == 0) {
    		%>
    		<script type="text/javascript" language="javascript">
    		alert("invalid input. Please check again");
    		</script> 
    		<%
    	}
	}
	
	if (action != null && action.equals("update")) {
		int id = Integer.parseInt(request.getParameter("ID"));
    	String name = request.getParameter("NAME");

    	dm.updateDepartment(id,name);
	}
	
	if (action != null && action.equals("delete")) {
		dm.deleteDepartment(Integer.parseInt(request.getParameter("ID")));
		
	}
	

	
%>
	<table>
		<tr>
			<th>ID</th>
			<th>NAME</th>
		</tr>
		
		<tr>
			<form action="department.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="ID" size="10"></th> 
				<th><input value="" name="NAME" size="20"></th> 
				<th><input type="submit" value="Insert"></th>
	  		</form>
		</tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT * FROM department");
		while (rset.next ()) {
		%><tr>
				<form action="department.jsp" method="get">
					<input type="hidden" value="update" name="action"> 
					<td><input value="<%= rset.getInt(1) %>" name="ID" size="10" readonly="readonly"></td> 
					<td><input value="<%= rset.getString(2) %>" name="NAME" size=20"></td>
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
				<form action="department.jsp" method="get">
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