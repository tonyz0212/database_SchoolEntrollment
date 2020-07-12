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
<title> Class taken in the past  </title>
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
    	int year = Integer.parseInt(request.getParameter("YEAR"));
    	int quarter = Integer.parseInt(request.getParameter("QUARTER"));
    	String grade = request.getParameter("GRADE");
    	int unit = Integer.parseInt(request.getParameter("UNIT"));
     
    	sm.insertPastClass(studentid, classid ,year,quarter, grade,unit);
    	}
	
	if (action != null && action.equals("update")) {
		int id = Integer.parseInt(request.getParameter("ID"));
    	int studentid = Integer.parseInt(request.getParameter("STUDENTID"));
    	int classid = Integer.parseInt(request.getParameter("COURSEID"));
    	int year = Integer.parseInt(request.getParameter("YEAR"));
    	int quarter = Integer.parseInt(request.getParameter("QUARTER"));
    	String grade = request.getParameter("GRADE");
    	int unit = Integer.parseInt(request.getParameter("UNIT"));     
    	sm.updatePastClass(id, studentid, classid, year,quarter,grade,unit);
	}
	
	if (action != null && action.equals("delete")) {
		// Create the prepared statement and use it to // DELETE the student FROM the Student table. PreparedStatement 
		//System.out.println("=======" + request.getParameter("SESSIONID") + "======");
		
		int id = Integer.parseInt(request.getParameter("ID"));
		System.out.println("=======" + id + "======");
		sm.deletePastClass(id);
		
	}

	
%>	
	 
	<table>
		<tr>
			<th>Student ID</th>
			<th>Course ID</th>
			<th>Year</th>
			<th>Quarter</th>
			<th>Grade</th>	
			<th>Unit</th>			
		</tr>
		
		<tr>
			<form action="classTaken.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="STUDENTID" size="10"></th> 
				<th><input value="" name="COURSEID" size="10"></th> 
				<th><input  value="" name="YEAR" size="10"></th>  
			    <th><input  value="" name="QUARTER" size="10"></th>  
				<th><input  value="" name="GRADE" size="10"></th>  
				<th><input  value="" name="UNIT" size="10"></th>  
				<th><input type="submit" value="Insert" size ="15"></th>
	  		</form>
		</tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT * FROM past_class_taken");
		 
		HashMap<Integer, String> quarterHash= new HashMap<>();
		double gpaSum = 0;
		quarterHash.put(1, "FALL");
		quarterHash.put(2, "WINTER");
		quarterHash.put(3, "SPRING");
		quarterHash.put(4, "SUMMER I");
		quarterHash.put(5, "SUMMER II"); %>
		<%
		while (rset.next ()) {
		%><tr>
				<form action="classTaken.jsp" method="get">
					<input type="hidden" value="update" name="action"> 

					<input type = "hidden" value="<%= rset.getInt(1) %>" name="ID" size="10" >
					
					<td><input value="<%= rset.getInt(2) %>" name="STUDENTID" size="10" ></td> 
					<td><input value="<%= rset.getInt(3) %>" name="COURSEID" size="10"></td> 
					<td><input value="<%= rset.getInt(4) %>" name="YEAR" size="10"></td> 
					<td><input value="<%= rset.getInt(5)%>" name="QUARTER" size="10"></td> 
					<td><input value="<%= rset.getString(6) %>" name="GRADE" size="10"></td> 
					<td><input value="<%= rset.getInt(7) %>" name="UNIT" size="10"></td> 
	
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
				<form action=classTaken.jsp method="get">
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
	<a href="decisionSupportTwo.jsp">3.a.2</a>  <br>
	<a href="decisionSupportThree.jsp">3.a.3</a> <br>
	<a href="index.jsp">GO BACK</a>
	
</body>
</html>