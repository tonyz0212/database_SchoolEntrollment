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
<title>reviewSession</title>
</head>
<body>
	<%
		SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
		String sid = request.getParameter("sid"); 
		String sdate = request.getParameter("sdate"); 
		String edate = request.getParameter("edate"); 
	%>
		<h3>Report for session <%=sid%>, between <%=sdate %> and <%=edate %></h3>

		
	<% try {
		String insq = "SELECT i.start_date AS start, i.end_date AS end "
				+ "FROM instruction_date i, session s, class c "
				+ "WHERE s.id = " + sid + " AND c.id = s.classid AND c.year = i.year AND c.quarter = i.quarter";
		Statement insqstmt = system.getConnection().createStatement ();
		ResultSet insqrset = insqstmt.executeQuery (insq);
		if (insqrset.next()){
			%>
			<h4>Notice: The Instruction date of this quarter is between <%= insqrset.getDate(1) %> and <%= insqrset.getDate(2)%><br></h4>
			<%
		}
		insqrset.close();
		insqstmt.close();
		
	} catch(SQLException e) {
		e.printStackTrace();

	}  
	%>
	<h5>within instruction date:</h5>
	<table border = "1">
		<tr>

			<th>DATE</th>
			<th>DAY</th>
			<th>START TIME</th>
			<th>END TIME</th>

			
		</tr>
		
		<tr>
	<%
	try {
		String with1 = "WITH alldate AS " 
				+ "(SELECT DAY::DATE AS date, EXTRACT(DOW FROM DAY) AS day "                    
				+ "FROM   generate_series(TIMESTAMP '" + sdate + "','" + edate + "', '1 day') DAY)";
		String with2 = ", ins AS (SELECT i.start_date AS start, i.end_date AS end "
				+ "FROM instruction_date i, session s, class c "
				+ "WHERE s.id = " + sid + " AND c.id = s.classid AND c.year = i.year AND c.quarter = i.quarter) ";
		String query = with1 + with2 +  " SELECT * "
				+ "FROM alldate d, timeslot t, ins i " 
				+ "WHERE NOT EXISTS ( "
						+ "SELECT 1 "
						+ "FROM allweekly w "
						+ "WHERE w.session = " + sid + " AND w.day = d.day AND w.start = t.start_time "
						+ " ) AND NOT EXISTS ("
						+		"SELECT 1 "
						+		"FROM allreview r "
						+		"WHERE r.session = " + sid + " AND r.redate = d.date AND r.start = t.start_time "							
						+		") AND d.date <= i.end AND d.date >= i.start ORDER BY d.date";
		//System.out.println(query);
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery (query);
		while (rset.next ()) {
		%><tr>						
						<td><%= rset.getString(1) %></td> 
						<td><%= rset.getInt(2) %></td> 
						<td><%= rset.getTime(3) %></td> 
						<td><%= rset.getTime(4) %></td> 

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
	
		<h5>beyond instruction date:</h5>
	<table border = "1">
		<tr>

			<th>DATE</th>
			<th>DAY</th>
			<th>START TIME</th>
			<th>END TIME</th>

			
		</tr>
		
		<tr>
	<%
	try {
		String with11 = "WITH alldate AS " 
				+ "(SELECT DAY::DATE AS date, EXTRACT(DOW FROM DAY) AS day "                    
				+ "FROM   generate_series(TIMESTAMP '" + sdate + "','" + edate + "', '1 day') DAY)";
		String with22 = ", ins AS (SELECT i.start_date AS start, i.end_date AS end "
				+ "FROM instruction_date i, session s, class c "
				+ "WHERE s.id = " + sid + " AND c.id = s.classid AND c.year = i.year AND c.quarter = i.quarter) ";
		String query2 = with11 + with22 +  " SELECT * "
				+ "FROM alldate d, timeslot t, ins i "
				+ "WHERE (d.date > i.end OR d.date < i.start)"
				+ " AND NOT EXISTS ("
				+		"SELECT 1 "
				+		"FROM allreview r "
				+		"WHERE r.session = " + sid + " AND r.redate = d.date AND r.start = t.start_time "							
				+		") ORDER BY d.date";
		System.out.println(query2);
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery (query2);
		while (rset.next ()) {
		%><tr>						
						<td><%= rset.getString(1) %></td> 
						<td><%= rset.getInt(2) %></td> 
						<td><%= rset.getTime(3) %></td> 
						<td><%= rset.getTime(4) %></td> 

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
	<a href="query-review.jsp">GO BACK</a> 

</body>
</html>