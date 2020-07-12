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
    	int id = Integer.parseInt(request.getParameter("ID"));
    	String fn = request.getParameter("FIRSTNAME");
    	String mn = request.getParameter("MIDDLENAME");
    	String ln = request.getParameter("LASTNAME");
    	int ssn = Integer.parseInt(request.getParameter("SSN")); 
    	int res = Integer.parseInt(request.getParameter("RESIDENCY")); 
    	boolean enroll = Boolean.parseBoolean(request.getParameter("ENROLLMENT")); 
    	int level = Integer.parseInt(request.getParameter("LEVEL")); 
    	int degree = Integer.parseInt(request.getParameter("DEGREE"));
    	String start = request.getParameter("START");
    	String end = request.getParameter("END");
    	
    	int succ = sm.insertStudent(id, fn, mn, ln, ssn, res, enroll, level, degree, start, end);
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
    	String fn = request.getParameter("FIRSTNAME");
    	String mn = request.getParameter("MIDDLENAME");
    	String ln = request.getParameter("LASTNAME");
    	int res = Integer.parseInt(request.getParameter("RESIDENCY")); 
    	boolean enroll = Boolean.parseBoolean(request.getParameter("ENROLLMENT"));  
    	System.out.println(enroll);
    	int level = Integer.parseInt(request.getParameter("LEVEL")); 
    	int degree = Integer.parseInt(request.getParameter("DEGREE")); 
    	String start = request.getParameter("START");
    	String end = request.getParameter("END");
    	int succ = sm.updateStudent(id, fn, mn, ln, res, enroll, level, degree, start, end);
    	if (succ == 0) {
    		%>
    		<script type="text/javascript" language="javascript">
    		alert("invalid input. Please check again");
    		</script> 
    		<%
    	}
	}
	
	if (action != null && action.equals("delete")) {
		// Create the prepared statement and use it to // DELETE the student FROM the Student table. PreparedStatement 
		System.out.println("=======" + request.getParameter("ID") + "======");
		int succ = sm.deleteStudent(Integer.parseInt(request.getParameter("ID")));
    	if (succ == 0) {
    		%>
    		<script type="text/javascript" language="javascript">
    		alert("invalid input. Please check again");
    		</script> 
    		<%
    	}
		
	}

	
%>	<a href="undergraduate.jsp">Undergraduate Info</a><br>
	<a href="graduate.jsp">Graduate Info</a><br>
	
	<table>
		<tr>
			<th>ID</th>
			<th>First</th>
			<th>Middle</th>
			<th>Last</th>
			<th>SSN</th>
			<th>RESIDENCY</th>
			<th>ENROLLMENT</th>
			<th>LEVEL</th>
			<th>DEGREE</th>
			<th>START</th>
			<th>END</th>
		</tr>
		
		<tr>
			<form action="student.jsp" method="get">
				<input type="hidden" value="insert" name="action"> 
				<th><input value="" name="ID" size="5"></th> 
				<th><input value="" name="FIRSTNAME" size="15"></th> 
				<th><input value="" name="MIDDLENAME" size="15"></th> 
				<th><input value="" name="LASTNAME" size="15"></th> 
				<th><input value="" name="SSN" size="5"></th> 
				
				<th>
				       <select name="RESIDENCY">
                         <option value="0">California</option>
                         <option value="1">non-CA US</option>
                         <option value="2">foreign</option>
                       </select>
                </th> 
                				
				<th>
				       <select name="ENROLLMENT">
                         <option value="true">True</option>
                         <option value="false">False</option>
                       </select>
                </th> 
               				
				<th>
				       <select name="LEVEL">
                         <option value="0">Undergraduate</option>
                         <option value="1">Graduate</option>
                       </select>
                </th> 
				 
				<th><input placeholder = "degree id" value="" name="DEGREE" size="10"></th> 
				<td><input placeholder = "yyyy-mm-dd" value="" name="START" size="10"></td> 
				<td><input placeholder = "yyyy-mm-dd" value="" name="END" size="10"></td> 
				<th><input type="submit" value="Insert" size ="15"></th>
	  		</form>
		</tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT * FROM Student");	
		
		while (rset.next ()) {
		%><tr>
				<form action="student.jsp" method="get">
					<input type="hidden" value="update" name="action"> 
					<td><input value="<%= rset.getInt(1) %>" name="ID" size="5" readonly="readonly"></td> 
					<td><input value="<%= rset.getString(3) %>" name="FIRSTNAME" size="15"></td> 
					<td><input value="<%= rset.getString(4) %>" name="MIDDLENAME" size="15"></td> 
					<td><input value="<%= rset.getString(5) %>" name="LASTNAME" size="15"></td> 
					<td><input value="<%= rset.getInt(2) %>" name="SSN" size="5" readonly="readonly"></td> 
					
					 
					 <% if (rset.getInt(6) == 0) { %>
					 <th>
				       <select id = "residency" name="RESIDENCY">
                         <option value="0" selected = "selected">California</option>
                         <option value="1">non-CA US</option>
                         <option value="2">foreign</option>
                       </select>
                	</th> 
                	<%} if (rset.getInt(6) == 1) { %>
                	<th>
				       <select id = "residency" name="RESIDENCY">
                         <option value="0">California</option>
                         <option value="1" selected = "selected">non-CA US</option>
                         <option value="2">foreign</option>
                       </select>
                	</th> 
                	<%} if (rset.getInt(6) == 2) { %>
                	                	<th>
				       <select id = "residency" name="RESIDENCY">
                         <option value="0">California</option>
                         <option value="1">non-CA US</option>
                         <option value="2" selected = "selected">foreign</option>
                       </select>
                	</th> 
                	
                	<%}%>
                	
                	
                	<% if (rset.getBoolean(7)) { %>
					<th>
				       <select id = "enrollment" name="ENROLLMENT">
                         <option value="true" selected = "selected">True</option>
                         <option value="false">False</option>
                       </select>
                	</th> 
                	<%} if (!rset.getBoolean(7)) { %>
					<th>
				       <select id = "enrollment" name="ENROLLMENT">
                         <option value="true">True</option>
                         <option value="false" selected = "selected">False</option>
                       </select>
                	</th> 
                	<%}%>
                				

               		<% if (rset.getInt(8) == 0) { %>
					<th>
				       <select id = "level" name="LEVEL">
                         <option value="0" selected = "selected">Undergraduate</option>
                         <option value="1">Graduate</option>
                       </select>
                	</th> 
                	<%} if (rset.getInt(8) == 1) { %>
					<th>
				       <select id = "level" name="LEVEL">
                         <option value="0">Undergraduate</option>
                         <option value="1" selected = "selected">Graduate</option>
                       </select>
                	</th> 
                	<%}%>

					 
					<td><input value="<%= rset.getString(9) %>" name="DEGREE" size="10"></td> 
					<td><input value="<%= rset.getDate(10) %>" name="START" size="10"></td> 
					<td><input value="<%= rset.getDate(11) %>" name="END" size="10"></td> 
					
	
					<td><input type="submit" value="Update"></td> 
					
				</form>
				
				<form action="student.jsp" method="get">
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