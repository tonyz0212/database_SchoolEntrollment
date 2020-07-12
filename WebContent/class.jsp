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
	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {
    	int id = Integer.parseInt(request.getParameter("ID"));
    	String title = request.getParameter("TITLE");
    	int year = Integer.parseInt(request.getParameter("YEAR"));
    	int quarter = Integer.parseInt(request.getParameter("QUARTER"));
    	int course = Integer.parseInt(request.getParameter("COURSE"));
    	
    	cm.insertClass(id, title, year, quarter, course);
	}
	
	if (action != null && action.equals("update")) {
    	int id = Integer.parseInt(request.getParameter("ID"));
    	String title = request.getParameter("TITLE");
    	int year = Integer.parseInt(request.getParameter("YEAR"));
    	int quarter = Integer.parseInt(request.getParameter("QUARTER"));
    	int course = Integer.parseInt(request.getParameter("COURSE"));
    	
    	cm.updateClass(id, title, year, quarter, course);
	}
	
	if (action != null && action.equals("delete")) {
		cm.deleteClass(Integer.parseInt(request.getParameter("ID")));
		
	}
	
%>

	<table>
		<tr>
			<th>ID</th>
			<th>CODE</th>
			<th>TITLE</th>
			<th>YEAR</th>
			<th>QUARTER</th>
			<th>COURSEID</th>
			
		</tr>
		
		<tr>
			<form action="class.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="ID" size=10"></th> 
				<th><input value="" size=10 readonly="readonly"></th>
				<th><input value="" name="TITLE" size="30"></th> 
				<th><input placeholder = "yyyy" value="" name="YEAR" size="10"></th> 
				<!-- <th><input value="" name="QUARTER" size="10"></th>  -->
				
					<th>
				       <select name="QUARTER">
                         <option value="1">FALL</option>
                         <option value="2">WINTER</option>
                         <option value="3">SPRING</option>
                         <option value="4">SUMMER I</option>
                         <option value="5">SUMMER II</option>
                       </select>
                	</th>		
				
				<th><input placeholder = "Courseid" value="" name="COURSE" size="15"></th> 
				<th><input type="submit" value="Insert"></th>
	  		</form>
		</tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT c.*,co.code FROM class c, course co WHERE c.courseid = co.id");
		while (rset.next ()) {
		%><tr>
				<form action="class.jsp" method="get">
					<input type="hidden" value="update" name="action"> 
					<td><input value="<%= rset.getInt(1) %>" name="ID" size="10" readonly="readonly"></td> 
					<th><input value="<%= rset.getString(6) %>" size=10 readonly="readonly"></th>
					<td><input value="<%= rset.getString(2) %>" name="TITLE" size="30"></td>
					<td><input value="<%= rset.getInt(3) %>" name="YEAR" size="10"></td>
					<!--  <td><input value="<%= rset.getInt(4) %>" name="QUARTER" size="10"></td>  -->
					
					<% if (rset.getInt(4) == 1) { %>
					<th>
				       <select name="QUARTER">
                         <option value="1" selected = "selected">Fall</option>
                         <option value="2">Winter</option>
                         <option value="3">Spring</option>
                         <option value="4">Summer I</option>
                         <option value="5">Summer II</option>
                       </select>
                	</th>	
                	<%} if (rset.getInt(4) == 2) { %>
					<th>
				       <select name="QUARTER">
                         <option value="1">Fall</option>
                         <option value="2" selected = "selected">Winter</option>
                         <option value="3">Spring</option>
                         <option value="4">Summer I</option>
                         <option value="5">Summer II</option>
                       </select>
                	</th>	
                	<%} if (rset.getInt(4) == 3) { %>
					<th>
				       <select name="QUARTER">
                         <option value="1">Fall</option>
                         <option value="2">Winter</option>
                         <option value="3" selected = "selected">Spring</option>
                         <option value="4">Summer I</option>
                         <option value="5">Summer II</option>
                       </select>
                	</th>
                	<%} if (rset.getInt(4) == 4) { %>
					<th>
				       <select name="QUARTER">
                         <option value="1">Fall</option>
                         <option value="2">Winter</option>
                         <option value="3">Spring</option>
                         <option value="4" selected = "selected">Summer I</option>
                         <option value="5">Summer II</option>
                       </select>
                	</th>	
                	<%} if (rset.getInt(4) == 5) { %>
					<th>
				       <select name="QUARTER">
                         <option value="1">Fall</option>
                         <option value="2">Winter</option>
                         <option value="3">Spring</option>
                         <option value="4">Summer I</option>
                         <option value="5" selected = "selected">Summer II</option>
                       </select>
                	</th>
                	<%}%>
					
					
					<td><input value="<%= rset.getInt(5) %>" name="COURSE" size="15"></td>
					<td><a href="session.jsp?classid=<%=rset.getInt(1)%>"> session list </td>
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
				<form action="class.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getString(1)%>" name="ID">
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