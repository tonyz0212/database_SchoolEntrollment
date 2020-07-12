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
<title> result for support part four</title>
</head>
<body>
	<%	
		SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
		String cid = request.getParameter("cid");
		HashMap<Integer, String> quarterHash= new HashMap<>();
		quarterHash.put(1, "FALL");
		quarterHash.put(2, "WINTER");
		quarterHash.put(3, "SPRING");
		quarterHash.put(4, "SUMMER I");
		quarterHash.put(5, "SUMMER II");
		
	 
	%>
		<%-- Report for course:<%=cid%> Faculty: <%=pid%>   --%>
		Decision Report Part IIII
	<table border = "1">
		<tr>
			<th>Course ID</th>
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
		stmt.executeUpdate("drop view if exists A CASCADE");
		stmt.executeUpdate("drop view if exists B CASCADE");
		
		// view A : prof name, courseid , grade
		stmt.executeUpdate("CREATE view A as select p.courseid, p.grade "+
		"from faculty_teaching f,  past_class_taken p where p.courseid = f.course and f.course = "+cid+";");
		
     	stmt.executeUpdate("CREATE view B as select distinct p.courseid  "+
				"from faculty_teaching f,  past_class_taken p where p.courseid = f.course  and f.course = "+cid+";");
	 
		
		ResultSet rset = stmt.executeQuery ("select count(grade) from A where grade ='A' OR grade ='A+' OR grade ='A-' ;");
		while(rset.next()){
			hmap.put("A",rset.getInt(1));
		}
		rset = stmt.executeQuery ("select count(grade) from A where grade ='B'OR grade ='B+' OR grade ='B-' ;");
		while(rset.next()){
			hmap.put("B",rset.getInt(1));
		}
		
		rset = stmt.executeQuery ("select count(grade) from A where grade ='C'OR grade ='C+' OR grade ='C-' ;");
		while(rset.next()){
			hmap.put("C",rset.getInt(1));
		}
		rset = stmt.executeQuery ("select count(grade) from A where grade ='D' ;");
		while(rset.next()){
			hmap.put("D",rset.getInt(1));
		}
		rset = stmt.executeQuery ("select count(grade) from A where grade ='F' ;");
		while(rset.next()){
			hmap.put("F",rset.getInt(1));
		}
		rset =stmt.executeQuery ("select * from B ;");
		while (rset.next ()) {
			%> 
			<td> <%=  rset.getInt(1)%></td>
			<td> <%=  hmap.get("A")%> </td>
			<td> <%=  hmap.get("B")%> </td>
			<td> <%=  hmap.get("C")%> </td>
			<td> <%=  hmap.get("D")%> </td>
			<td> <%=  hmap.get("F")%> </td>
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
	<a href="decisionSupportFour.jsp">GO BACK</a> 

</body>
</html>