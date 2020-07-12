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
<title>Lower Division Form</title>
</head>
<body>
<%
	SystemManager system = (SystemManager) request.getSession().getAttribute("sm");
	DegreeEntryManager sm = system.getDegreeM();


	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {

		int degreeid = Integer.parseInt(request.getParameter("DEGREEID"));
		int unit = Integer.parseInt(request.getParameter("UNIT"));
		double gpa = Double.parseDouble(request.getParameter("GPA"));
    	 
   		sm.insertLower(degreeid,unit,gpa); 
	}
	
	if (action != null && action.equals("update")) {
		int id = Integer.parseInt(request.getParameter("thesis_id"));
		String name = request.getParameter("name");
    	int required_units = Integer.parseInt(request.getParameter("required_units"));
    	String type = request.getParameter("degree_type");
    	int department_id = Integer.parseInt(request.getParameter("department_id"));
    	
/*     	sm.updateDegree( name, required_units, type, department_id); */
    	
	}
	
	if (action != null && action.equals("delete")) {
		int id = Integer.parseInt(request.getParameter("thesis_id"));
		
		 
		   // int id = Integer.parseInt(request.getParameter("id"));
			System.out.println("=======" + request.getParameter("thesis_id") + "======");
			sm.deleteLower(id);
		 
	} 

	
%>
	
	<table>
		<tr>
			<th>Degree ID</th>
			<th>Required Unit</th>
			<th>Required GPA</th>		
		</tr>
		
		<tr>
			<form action="lower.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="DEGREEID" size="10"></th> 
				<th><input value="" name="UNIT" size="10"></th> 
				<th><input value="" name="GPA" size="10"></th>			 

				<th><input type="submit" value="Insert" size ="15"></th>
				
	  		</form>
		</tr>
	<%
	try {
		
		Statement stmt = system.getConnection().createStatement();
		ResultSet rset = stmt.executeQuery ("SELECT l.degree, l.require_units, l.gpa FROM lower_division l");
	
		while (rset.next ()) {
		%><tr>
				<form action=lower.jsp method="get">
					<input type="hidden" value="update" name="action"> 
					<td><input value="<%= rset.getInt(1) %>" name="DEGREEID" size="10" readonly="readonly" ></td>	
					<td><input value="<%= rset.getInt(2) %>" name="UNIT" size="10" ></td> 
			        <td><input value="<%= rset.getDouble(3) %>" name="GPA" size="10" ></td>			
 		
					
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
		<form action="lower.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getInt(1)%>" name="thesis_id">
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
	
	<a href="degreeRequirement.jsp">GO BACK</a>
	
</body>
</html>