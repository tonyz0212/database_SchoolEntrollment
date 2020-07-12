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
    	int student = Integer.parseInt(request.getParameter("STUDENT"));
    	String reason = request.getParameter("REASON");
    	String start = request.getParameter("START");
    	String end = request.getParameter("END");

    	sm.insertProbation(student, reason, start, end);
	}
	
	if (action != null && action.equals("update")) {
		int id = Integer.parseInt(request.getParameter("ID"));
    	int student = Integer.parseInt(request.getParameter("STUDENT"));
    	String reason = request.getParameter("REASON");
    	String start = request.getParameter("START");
    	String end = request.getParameter("END");

    	sm.updateProbation(id, student, reason, start, end);
	}
	
	if (action != null && action.equals("delete")) {
		sm.deleteProbation(Integer.parseInt(request.getParameter("ID")));
		
	}

	
%>
	<table>
		<tr>
			<th>STUDENT</th>
			<th>REASON</th>
			<th>START DATE</th>
			<th>END DATE</th>
			
			
		</tr>
		
		<tr>
			<form action="probation.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="STUDENT" size="10"></th> 
				<th><input value="" name="REASON" size="20"></th> 
				<th><input placeholder = "yyyy-mm-dd" value="" name="START" size="15"></th> 
				<th><input placeholder = "yyyy-mm-dd" value="" name="END" size="15"></th>
				<th><input type="submit" value="Insert"></th>
	  		</form>
		</tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT * FROM probation");
		while (rset.next ()) {
		%><tr>
				<form action="probation.jsp" method="get">
					<input type="hidden" value="update" name="action"> 
					<input type="hidden" value="<%= rset.getString(1)%>" name="ID">
					
					<td><input value="<%= rset.getString(2) %>" name="STUDENT" size="10" readonly="readonly"></td> 
					<td><input value="<%= rset.getString(3) %>" name="REASON" size="20"></td>
					<td><input value="<%= rset.getDate(4) %>" name="START" size="15"></td>
					<td><input value="<%= rset.getDate(5) %>" name="END" size="15"></td>
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
				<form action="probation.jsp" method="get">
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