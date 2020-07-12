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
<title>Concentration Courses Form</title>
</head>
<body>
<%
	SystemManager system = (SystemManager) request.getSession().getAttribute("sm");
	DegreeEntryManager sm = system.getDegreeM();


	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {

		int conid = Integer.parseInt(request.getParameter("CONCENTRATIONID"));
		int courseid = Integer.parseInt(request.getParameter("COURSEID"));
    	 
   		sm.insertConcentrationCourse(conid,courseid); 
	}
	
	if (action != null && action.equals("update")) {
	
		int conid = Integer.parseInt(request.getParameter("CONCENTRATIONID"));
		int courseid = Integer.parseInt(request.getParameter("COURSEID"));
    	sm.updateConcentrationCourse(conid,courseid);

	}
	
	if (action != null && action.equals("delete")) {
		int courseid = Integer.parseInt(request.getParameter("COURSEID"));
		 
		   // int id = Integer.parseInt(request.getParameter("id"));
			System.out.println("=======" + courseid + "======");
			sm.deleteConcentrationCourse(courseid);
		 
	} 

	
%>

	<table>
		<tr>
			<th> Concentration ID</th>
			<th> Course ID</th>		
		</tr>
		
		<tr>
			<form action="concentrationCourse.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="CONCENTRATIONID" size="10"></th> 
				<th><input value="" name="COURSEID" size="10"></th> 	 
				<th><input type="submit" value="Insert" size ="15"></th>
				
	  		</form>
		</tr>
	<%
	try {
		
		Statement stmt = system.getConnection().createStatement();
		ResultSet rset = stmt.executeQuery ("SELECT c.idconcentration, c.idcourse,d.code FROM concentration_course c, course d where d.id =c.idcourse;");
	
		while (rset.next ()) {
		%><tr>
				<form action=concentrationCourse.jsp method="get">
					<input type="hidden" value="update" name="action"> 
					<td><input value="<%= rset.getInt(1) %>" name="CONCENTRATIONID" size="10" readonly="readonly" ></td>	
					<td><input value="<%= rset.getInt(2) %>" name="COURSEID" size="10" ></td> 
			       	<td><input value="<%= rset.getString(3) %>" name="COURSENAME" size="10"  readonly="readonly" ></td> 	
	
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
		<form action="concentrationCourse.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getInt(2)%>" name="COURSEID">
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
	
	<a href="concentration.jsp">GO BACK</a>
	
</body>
</html>