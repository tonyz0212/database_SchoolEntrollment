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
<title> result for support part three</title>
</head>
<body>
	<%	
		SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
		String cid = request.getParameter("cid");
		String pid = request.getParameter("pid");
		
		
		HashMap<Integer, String> quarterHash= new HashMap<>();
		quarterHash.put(1, "FALL");
		quarterHash.put(2, "WINTER");
		quarterHash.put(3, "SPRING");
		quarterHash.put(4, "SUMMER I");
		quarterHash.put(5, "SUMMER II");
		
	 
	%>
		<%-- Report for course:<%=cid%> Faculty: <%=pid%>   --%>
		Decision Report Part III 
	<table border = "1">
		<tr>
			<th>Professor Name</th>
			<th>Course ID</th>
			<th>Grade Point Average </th>

		</tr>
		<tr>
 
	<%
	try {
		HashMap<String,Integer> hmap = new HashMap<>();
		Statement stmt = system.getConnection().createStatement ();
		stmt.executeUpdate("drop  view if exists A CASCADE");
		stmt.executeUpdate("drop  view if exists B CASCADE");
		
		// view A : prof name, courseid , grade , grade number
		stmt.executeUpdate("CREATE view A as select f.name,p.courseid, p.grade,g.number_grade "+
		"from faculty_teaching f,  past_class_taken p,GRADE_CONVERSION g where f.year = p.year and f.quarter = p.quarter "+
		"and p.courseid = f.course "+
		"and p.grade=g.letter_grade and p.courseid = f.course and f.course = "+cid+
		" and f.name='"+pid+"';");
	/* 	
		stmt.executeUpdate("ALTER TABLE A drop column grade ;");
		
     	stmt.executeUpdate("CREATE view B as select distinct f.name,p.courseid  "+
				"from faculty_teaching f,  past_class_taken p where p.courseid = f.course  and f.course = "+cid+" and f.name='"+pid+"';");
	  */
		
		ResultSet rset = stmt.executeQuery ("select name,courseid, avg(number_grade) from A Group by name,courseid;");
		
		while (rset.next ()) {
			%> 
			<td> <%=  rset.getString(1)%></td>
			<td> <%=  rset.getInt(2)%></td>
			<td> <%=  rset.getDouble(3)%></td>
			
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
	<a href="decisionSupportFive.jsp">GO BACK</a> 

</body>
</html>