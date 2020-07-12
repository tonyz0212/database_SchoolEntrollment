<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="org.postgresql.Driver" %>
<%@ page import="cse132b.copy.SystemManager" %>
<%@ page import="cse132b.copy.StudentManager" %>
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
	StudentManager sm = system.getSM();
	//Check if an insertion is requested
	String action = request.getParameter("action");
	if (action != null && action.equals("insert")) {
    	int studentid = Integer.parseInt(request.getParameter("STUDENTID"));
    	int department = Integer.parseInt(request.getParameter("DEPARTMENT"));
    	int classification = Integer.parseInt(request.getParameter("CLASSIFICATION"));
    	String  advisor = request.getParameter("ADVISOR");
    	sm.insertGrad(studentid, department, classification, advisor);
	}
	
	if (action != null && action.equals("update")) {
    	int gradid = Integer.parseInt(request.getParameter("GRADID"));
    	int department = Integer.parseInt(request.getParameter("DEPARTMENT"));
    	int classification = Integer.parseInt(request.getParameter("CLASSIFICATION"));
    	String advisor = request.getParameter("ADVISOR");

    	sm.insertGrad(gradid, department, classification, advisor);
	}
	
	if (action != null && action.equals("delete")) {
		sm.deleteGrad(Integer.parseInt(request.getParameter("GRADID")));
	}

	
%>

	<table>
		<tr>
			<th>STD ID</th>
			<th>DEPARTMENT</th>
			<th>CLASSIFICATION</th>
			<th>ADVISOR</th>			
		</tr>
		
		<tr>
			<form action="graduate.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="STUDENTID" size="20"></th> 
				<th><input placeholder = "department id" value="" name="DEPARTMENT" size="20"></th> 
				<!-- <th><input value="" name="CLASSIFICATION" size="20"></th>  -->
				
				<th>
				       <select name="CLASSIFICATION">
                         <option value="0">MS</option>
                         <option value="1">PHD candidates</option>
                         <option value="2">PHD pre-candidates</option>
                         <option value="3">Bachelor/MS</option>
                       </select>
                </th> 
				
				<th><input value="" name="ADVISOR" size="20"></th> 
				<th><input type="submit" value="Insert"></th>
	  		</form>
		</tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT * FROM graduate");
		while (rset.next ()) {
		%><tr>
				<form action="graduate.jsp" method="get">
					<input type="hidden" value="update" name="action">
					<input type = "hidden" value="<%= rset.getInt(1) %>" name="GRADID" size="10">
					<td><input value="<%= rset.getInt(2) %>" name="STUDENTID" size="20" readonly = "readonly" ></td>
					<td><input value="<%= rset.getInt(3) %>" name="DEPARTMENT" size="20"></td>
					<!-- <td><input value="<%= rset.getInt(4) %>" name="CLASSIFICATION" size="20"></td>  -->
					
					
					 <% if (rset.getInt(4) == 0) { %>
				
				<th>
				       <select name="CLASSIFICATION">
                         <option value="0" selected = "selected">MS</option>
                         <option value="1">PHD candidates</option>
                         <option value="2">PHD pre-candidates</option>
                         <option value="3">Bachelor/MS</option>
                       </select>
                </th> 
                	<%} if (rset.getInt(4) == 1) { %>				
				<th>
				       <select name="CLASSIFICATION">
                         <option value="0">MS</option>
                         <option value="1" selected = "selected">PHD candidates</option>
                         <option value="2">PHD pre-candidates</option>
                         <option value="3">Bachelor/MS</option>
                       </select>
                </th> 
                	<%} if (rset.getInt(4) == 2) { %>
				
				<th>
				       <select name="CLASSIFICATION">
                         <option value="0">MS</option>
                         <option value="1">PHD candidates</option>
                         <option value="2" selected = "selected">PHD pre-candidates</option>
                         <option value="3">Bachelor/MS</option>
                       </select>
                </th> 
                     <%} if (rset.getInt(4) == 3) { %>
				
				<th>
				       <select name="CLASSIFICATION">
                         <option value="0">MS</option>
                         <option value="1">PHD candidates</option>
                         <option value="2">PHD pre-candidates</option>
                         <option value="3" selected = "selected">Bachelor/MS</option>
                       </select>
                </th> 
                	
                	<%}%>
                	
                	
					<td><input value="<%= rset.getString(5) %>" name="ADVISOR" size="20"></td>
					
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
				<form action="graduate.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getInt(1) %>" name="GRADID">
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
	
	<a href="student.jsp">GO BACK</a>
	
</body>
</html>