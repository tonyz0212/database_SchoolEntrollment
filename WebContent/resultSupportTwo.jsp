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
<title> result for support part two</title>
</head>
<body>
	<%	
		SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
		String cid = request.getParameter("cid");
		String pid = request.getParameter("pid");
		String year = request.getParameter("yid");
		String qid = request.getParameter("qid");
		int yr =  Integer.parseInt(year);  
		int qt =  Integer.parseInt(qid); 
		
		HashMap<Integer, String> quarterHash= new HashMap<>();
		quarterHash.put(1, "FALL");
		quarterHash.put(2, "WINTER");
		quarterHash.put(3, "SPRING");
		quarterHash.put(4, "SUMMER I");
		quarterHash.put(5, "SUMMER II");
		
	 
	%>
		<%-- Report for course:<%=cid%> Faculty: <%=pid%>   --%>
		Decision Report Part II 
	<table border = "1">
		<tr>
			<th>Course ID</th>
			<th>Professor Name</th>
			<th>Year</th>
			<th>Quarter</th>
			<th># of A</th>
			<th># of B</th>
			<th># of C</th>
			<th># of D</th>
			<th># of Others</th>
			
			
		</tr>
		<tr>
 
	<%
	try {
		HashMap<String,Integer> hmap = new HashMap<>();
		Statement stmt = system.getConnection().createStatement ();
				
		
		ResultSet rset = stmt.executeQuery (" select * from CPQG c "+
				" where c.courseid = "+ cid + " and c.name ='"+pid + "' and c.year = "+year + " and c.quarter = "+ qid);
	
		while (rset.next ()) {
			%> 
			<td> <%=  rset.getInt(1)%> </td>
			<td> <%=  rset.getString(2)%></td>
			<td> <%=  rset.getInt(3)%> </td>
			<td> <%=  quarterHash.get(rset.getInt(4))%> </td>
			<td> <%=  rset.getInt(5)%> </td>
			<td> <%=  rset.getInt(6)%> </td>
			<td> <%=  rset.getInt(7)%> </td>
			<td> <%=  rset.getInt(8)%> </td>
			<td> <%=  rset.getInt(9)%> </td>
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
	<a href="classTaken.jsp">Class History</a> 
	<br>
	<br>
	<a href="decisionSupportTwo.jsp">GO BACK</a> 

</body>
</html>