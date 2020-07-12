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
<title>Concentration Form</title>
</head>
<body>
<%
	SystemManager system = (SystemManager) request.getSession().getAttribute("sm");
	DegreeEntryManager sm = system.getDegreeM();


	//Check if an insertion is requested
	String action = request.getParameter("action"); 
	if (action != null && action.equals("insert")) {

		int id = Integer.parseInt(request.getParameter("ID"));
		String name = request.getParameter("NAME");
		double gpa = Double.parseDouble(request.getParameter("GPA"));
		int degreeID = Integer.parseInt(request.getParameter("DEGREE"));
		int unit = Integer.parseInt(request.getParameter("UNIT"));    	 
   		sm.insertConcentration(id, name , gpa, degreeID, unit); 
	}
	
	if (action != null && action.equals("update")) {
	
		int id = Integer.parseInt(request.getParameter("ID"));
		String name = request.getParameter("NAME");
		double gpa = Double.parseDouble(request.getParameter("GPA"));
    	 
    	
/*     	sm.updateDegree( name, required_units, type, department_id); */
    	
	}
	
	if (action != null && action.equals("delete")) {
		int id = Integer.parseInt(request.getParameter("ID"));
		
		 
		   // int id = Integer.parseInt(request.getParameter("id"));
			System.out.println("=======" + id + "======");
			sm.deleteConcentration(id);
		 
	} 

	
%>
	<a href="concentrationCourse.jsp"> Click here to insert courses for concentration.</a>
	<table>
		<tr>
			<th> ID</th>
			<th> Series Name</th>
			<th>Required GPA</th>
			<th>Degree ID </th>
			<th>Unit Required </th>		
		</tr>
		
		<tr>
			<form action="concentration.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="ID" size="10"></th> 
				<th><input value="" name="NAME" size="10"></th> 
				<th><input value="" name="GPA" size="10"></th>	
				<th><input value="" name="DEGREE" size="10"></th>	
				<th><input value="" name="UNIT" size="10"></th>			 

				<th><input type="submit" value="Insert" size ="15"></th>
				
	  		</form>
		</tr>
	<%
	try {
		
		Statement stmt = system.getConnection().createStatement();
		ResultSet rset = stmt.executeQuery ("SELECT c.id, c.name, c.gpa,c.degreeid,c.unit FROM Concentration c");
	
		while (rset.next ()) {
		%><tr>
				<form action=concentration.jsp method="get">
					<input type="hidden" value="update" name="action"> 
					<td><input value="<%= rset.getInt(1) %>" name="ID" size="10" readonly="readonly" ></td>	
					<td><input value="<%= rset.getString(2) %>" name="NAME" size="10" ></td> 
			        <td><input value="<%= rset.getDouble(3) %>" name="GPA" size="10" ></td>			
 					<td><input value="<%= rset.getInt(4) %>" name="DEGREE" size="10" ></td> 
					<td><input value="<%= rset.getInt(5) %>" name="UNIT" size="10" ></td> 
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
		<form action="concentration.jsp" method="get">
					<input type="hidden" value="delete" name="action">
					<input type="hidden" value="<%= rset.getInt(1)%>" name="ID">
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
	
	<a href="index.jsp">GO BACK</a>
	
</body>
</html>