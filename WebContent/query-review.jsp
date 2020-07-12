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
<title>hello, cse132</title>
</head>
<body>

	<form action="result-review.jsp" method="get">
	<table>
		<tr>
			<th>Session ID</th>
			<th>Start Date</th>
			<th>End Date</th>
			
		</tr>
		<tr>
        	<td>
        		<select name="sid">
	<%
					SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
					try {
						Statement stmt = system.getConnection().createStatement ();
						ResultSet rset = stmt.executeQuery ("SELECT s.id, co.code" 
								+ " FROM session s, class cl, course co"
								+ " where s.classid = cl.id AND cl.courseid = co.id AND cl.year = 2020 AND cl.quarter = 3");
						while (rset.next ()) {
						%>
				             <option value="<%= rset.getInt(1) %>"> <%= rset.getInt(1) %>: <%= rset.getString(2) %></option>
					<%
						}
						rset.close();
						stmt.close();
					} catch(SQLException e) {
						e.printStackTrace();
					}
					%> 
				 </select>
			 </td>
			 <td><input placeholder = "yyyy-mm-dd" value="" name="sdate"></td>
			 <td><input placeholder = "yyyy-mm-dd" value="" name="edate"></td>
			 <td><input type="submit" value="Search"></td>
	 	</tr>
	 </table>
					
	 </form>


	
	<br><br>	
	<a href="query.jsp">GO BACK</a>
	
</body>
</html>