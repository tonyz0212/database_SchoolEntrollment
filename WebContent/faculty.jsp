<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="org.postgresql.Driver" %>
<%@ page import="cse132b.copy.SystemManager" %>
<%@ page import="cse132b.copy.FacultyManager" %>
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
	FacultyManager fm = system.getFM();
	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {
    	String name = request.getParameter("NAME");
    	int title = Integer.parseInt(request.getParameter("professor_type"));
    	int dm = Integer.parseInt(request.getParameter("DEPARTMENT"));
    	fm.insertFaculty(name, title, dm);
	}
	
	if (action != null && action.equals("update")) {
    	String name = request.getParameter("NAME");
    	int title = Integer.parseInt(request.getParameter("professor_type"));

    	int dm = Integer.parseInt(request.getParameter("DEPARTMENT"));

    	fm.updateFaculty(name,title,dm);
	}
	
	if (action != null && action.equals("delete")) {
		fm.deleteFaculty(request.getParameter("NAME"));
	}

	
%>
	<table>
		<tr>
			<th>NAME</th>
			<th>TITLE</th>
			<th>DEPT. ID</th>
			
		</tr>
		
		<tr>
			<form action="faculty.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="NAME" size="20"></th> 
<!-- 				<th><input value="" name="TITLE" size="10"></th> -->
				<th>
                      <select name="professor_type">
                        <option value="0">Lecturer</option>
                        <option value="1">Assistant Professor</option>
                        <option value="2"> Associate Professor </option>
                        <option value="3"> Professor </option>
                      </select>
                </th> 
				<th><input placeholder = "dept.id" value="" name="DEPARTMENT" size="10"></th> 
				<th><input type="submit" value="Insert"></th>
	  		</form>
		</tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT * FROM faculty");
		while (rset.next ()) {
		%><tr>
				<form action="faculty.jsp" method="get">
					<input type="hidden" value="update" name="action"> 
					<td><input value="<%= rset.getString(1) %>" name="NAME" size="20" readonly="readonly"></td> 
				<%-- 	<td><input value="<%= rset.getInt(2) %>" name="professor_type" size="10"></td>  --%>
					                
                	<% if (rset.getInt(2) == 0) { %>
				<th>
                      <select name="professor_type">
                        <option value="0" selected = "selected">Lecturer</option>
                        <option value="1">Assistant Professor</option>
                        <option value="2"> Associate Professor </option>
                        <option value="3"> Professor </option>
                      </select>
                </th> 
                	<%} if (rset.getInt(2) == 1) { %>
				<th>
                      <select name="professor_type">
                        <option value="0">Lecturer</option>
                        <option value="1" selected = "selected">Assistant Professor</option>
                        <option value="2"> Associate Professor </option>
                        <option value="3"> Professor </option>
                      </select>
                </th> 
                	<%} if (rset.getInt(2) == 2) { %>
				<th>
                      <select name="professor_type">
                        <option value="0">Lecturer</option>
                        <option value="1">Assistant Professor</option>
                        <option value="2" selected = "selected"> Associate Professor </option>
                        <option value="3"> Professor </option>
                      </select>
                </th> 
                	<%} if (rset.getInt(2) == 3) { %>
				<th>
                      <select name="professor_type">
                        <option value="0">Lecturer</option>
                        <option value="1">Assistant Professor</option>
                        <option value="2"> Associate Professor </option>
                        <option value="3" selected = "selected"> Professor </option>
                      </select>
                </th> 
                	
                	<%}%>
					<td><input value="<%= rset.getInt(3) %>" name="DEPARTMENT" size="10"></td>
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
				<form action="faculty.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getString(1)%>" name="NAME">
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