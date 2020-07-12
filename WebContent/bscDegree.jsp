<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="org.postgresql.Driver" %>
<%@ page import="cse132b.copy.SystemManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>BSC Degree </title>
</head>
<body>
	<%	
		SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
		String degreeid = request.getParameter("sid"); 
	%>
		Report for degree: <%=degreeid%>
	<table border = "1">
		<tr>
			<th>Degree Name </th>
			<th>Unit Required for the degree </th>
			<th>Unit Required for upper division course</th>
		    <th>Unit Required for lower division course</th>
 		    <th>Unit Required for technical elective division course</th>
			
		</tr>
		
		<tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT d.name ,d.required_units, u.require_units, l.require_units, t.require_units "
				+ "FROM degree d, lower_division l,upper_division u, technical_division t "+ 
				" WHERE d.id=l.degree and d.id=u.degree and d.id=t.degree and d.degree_type='BS' and d.id="+degreeid+"; ");


		while (rset.next ()) {
			%><tr>
						<td><%= rset.getString(1) %></td> 	
						<td><%= rset.getInt(2) %></td> 						
	 					<td><%= rset.getInt(3) %></td> 
						<td><%= rset.getInt(4) %></td> 
						<td><%= rset.getInt(5) %></td> 


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
	
	<br>
	<a href="undergradRemainDegree.jsp">GO BACK</a> 

</body>
</html>