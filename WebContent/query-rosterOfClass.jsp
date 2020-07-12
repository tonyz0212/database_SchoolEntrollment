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
		<tr>
	<form action="result-rosterOfClass.jsp" method="get">
		<th>
		title-year-quarter-courseCode<br>
             <select name="cid">
<%
	SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
	HashMap<Integer, String> quarterHash= new HashMap<>();
	
	quarterHash.put(1, "FALL");
	quarterHash.put(2, "WINTER");
	quarterHash.put(3, "SPRING");
	quarterHash.put(4, "SUMMER I");
	quarterHash.put(5, "SUMMER II");

	
	try {
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT cl.id, cl.title, cl.year, cl.quarter, co.code" 
				+ " FROM class cl, course co"
				+ " where cl.courseid = co.id");
		while (rset.next ()) {
			String q = quarterHash.get(rset.getInt(4));
		%>
        	<option value="<%= rset.getInt(1) %>"> <%= rset.getString(2) %>-<%= rset.getInt(3)%>-<%=q %>-<%= rset.getString(5) %>
        	</option>
	<%
		}
		rset.close();
		stmt.close();
	} catch(SQLException e) {
		e.printStackTrace();
	}
	%> 
	 </select>
	 <td><input type="submit" value="Search"></td> 
					
				</form>

			</tr>
	
	<br><br>	
	<a href="query.jsp">GO BACK</a>
	
</body>
</html>