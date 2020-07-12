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
<title>Degree Remaining</title>
</head>
<body>
	<%	
		SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
		String sid = request.getParameter("sid"); 
		String degreeid = request.getParameter("degreeid"); 
	%>
		Report for student <%=sid%>-<%=degreeid%>
	<table border = "1">
		<tr>
			<th>Degree Name </th>
			<th>Unit Required for the degree </th>
			<th>Unit Required for upper division course</th>
			<th>Unit Remained for upper division course</th>
		    <th>Unit Required for lower division course</th>
		    <th>Unit Remained for lower division course</th>
 		    <th>Unit Required for technical elective division course</th>
 		    <th>Unit Remained for technical elective division course</th>
		</tr>
		
		<tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		
	   //把该学生拿的所有没fail的课列出来
	   stmt.executeUpdate("drop view if exists studentPastCourse CASCADE");	
	   stmt.executeUpdate("create view studentPastCourse as select c.code,p.unit from past_class_taken p, course c where "+
	   "p.studentid= "+sid+ " and p.grade <> 'F' and p.grade <> 'D' and p.courseid = c.id;");
	   //计算该学生拿的upper division course  
	   //计算该学生拿的lower division course
 
		// 判断这课是upper还是lower 
		ResultSet rset = stmt.executeQuery("select * from studentPastCourse");
		int lowSum = 0;
		int upSum = 0;
		int techSum =0;
		while (rset.next ()) {
		 
			String course = rset.getString(1);
			
			int unit = rset.getInt(2);
			if ( course.equals("MAE3") ||   course.equals("CSE105") || 
					course.equals("MAE107")){
				 techSum+=unit;
			}			
			course = course.replaceAll("[^0-9]", ""); 
			
			int courseNum = Integer.parseInt(course);
			if (courseNum > 0 && courseNum < 100){
				 lowSum +=unit;
			}
			if (courseNum > 99 && courseNum < 200 ){
				upSum+=unit;
			}
			System.out.println(upSum);
		}
		
		rset = stmt.executeQuery ("SELECT d.name ,d.required_units, u.require_units, l.require_units, t.require_units  "
				+ "FROM degree d, lower_division l , upper_division u, technical_division t,student s  "+ 
				" WHERE d.id=l.degree and d.id=u.degree and d.id=t.degree and d.degree_type='BS' "+
				"and s.degree = d.id and d.id="+degreeid+" and s.id ="+sid+ ";"); 
					
		while (rset.next ()) {
			int reqUnit = rset.getInt(2);
			%><tr>
						<td><%= rset.getString(1) %></td> 	
						<td><%= rset.getInt(2) %></td>
						<td><%= rset.getInt(3)  %></td>
				 		<td><%= rset.getInt(3)-upSum %></td>
				 		<td><%= rset.getInt(4) %></td>
				 		<td><%= rset.getInt(4)-lowSum %></td>
				 		<td><%= rset.getInt(5) %></td>
				 		<td><%= rset.getInt(5) -techSum %></td>
				 		
					    
				</tr>
		<%
		}
		
 
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