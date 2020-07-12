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
		Report for student <%=sid%>  <%=degreeid%>
	<table border = "1">
		<tr>
			<th>Degree Name </th>
			<th>Unit Required for the degree </th>			
			<th>Unit remained for the degree </th>
		</tr>
		
		<tr>
	<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		//把该学生拿的所有没fail的课列出来
		stmt.executeUpdate("drop view if exists masterPastCourse CASCADE");	
		stmt.executeUpdate("create view masterPastCourse as select c.code,p.unit from past_class_taken p, course c where "+
		   "p.studentid= "+sid+ " and p.grade <> 'F' and p.grade <> 'D' and p.courseid = c.id;");
		
		int masterSum = 0;
		ResultSet rset = stmt.executeQuery ("select unit from masterPastCourse;");
		while(rset.next()){
			masterSum+=rset.getInt(1);
		}
		
		 rset = stmt.executeQuery ("SELECT distinct d.name ,d.required_units  "
					+ "FROM degree d, lower_division l , upper_division u, technical_division t  "+ 
					" WHERE d.id=l.degree and d.id=u.degree and d.id=t.degree and d.degree_type ='MS' ; ");		
			 
		while (rset.next ()) {
			int reqUnit = rset.getInt(2);
			%><tr>
						<td><%= rset.getString(1) %></td> 	
						<td><%= rset.getInt(2) %></td>
				 		<td><%= rset.getInt(2) - masterSum %></td>
					    
				</tr>
		<%
		}
		

			//rset.close();
		
			//	r2.close();
			/* r3.close();  */
			stmt.close();
	} catch(SQLException e) {
		e.printStackTrace();
	}
	%>
	</table>
	

	
	<br>
	
	<b> The student's concentration information:</b> 
	<br>
	<table border = "1">
		<tr>
			<th>Concentration  </th>
			<th> Courses in Concentration </th>
		</tr>
		
		<!-- create a hashmap for concentration, key is the concentration, value is the # of course that it needs to take -->
		<% 
		HashMap <String, Integer>required  = new HashMap<>(); 
		List <String> concentration_name = new ArrayList<>();
		try{
			Statement stmt = system.getConnection().createStatement ();
			ResultSet rset = stmt.executeQuery ("SELECT c.name, co.code from course co, concentration c, concentration_course cs, student s, degree d "
					+" where d.id = s.degree and co.id = cs.idcourse and cs.idconcentration = c.id and c.degreeid = d.id and s.id = " +sid+"; ");	
		
			while (rset.next ()) {
				if( !required.containsKey(rset.getString(1))){
					required.put(rset.getString(1), 1);
				}
				else{
					required.put(rset.getString(1), required.get(rset.getString(1))+1);
				}
		 
					 
			 
			}
		}catch( SQLException e ){
			e.printStackTrace();
		}
		for (Map.Entry entry : required.entrySet())
		   {
			   int j = (int)entry.getValue();
			   String k = entry.getKey().toString();
			   concentration_name.add(k);
			/* 	System.out.println("key is " + k);
				System.out.println("count is " + j); */
			   
		   }
		
		
		%>
		
		<%
	try {
		Statement stmt = system.getConnection().createStatement ();
	 
		 
		ResultSet rset = stmt.executeQuery ("SELECT c.name, co.code from course co, concentration c, concentration_course cs, student s, degree d "
				+" where d.id = s.degree and co.id = cs.idcourse and cs.idconcentration = c.id and c.degreeid = d.id and s.id = " +sid+"; ");		
 
 
		while (rset.next ()) {
			 
			%><tr>
						<td><%= rset.getString(1) %></td> 	
						 <td><%= rset.getString(2) %></td> 	
					    
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
	
	<b> Display the Completed Concentration for the student </b>
	<table border = "1">
		<tr>
			<th>Completed Concentration  </th>
			 
		</tr>
		
		<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		Statement s2 = system.getConnection().createStatement ();
		
	/* 	ResultSet rset = stmt.executeQuery ("SELECT c.name, co.code from course co, concentration c, concentration_course cs, student s, degree d "
				+" where d.id = s.degree and co.id = cs.idcourse and cs.idconcentration = c.id and c.degreeid = d.id and s.id = " +sid+"; ");		
  */
		//clear query 
		stmt.executeUpdate("drop  view if exists testa CASCADE");
		stmt.executeUpdate("drop view if exists testb CASCADE");		
  		stmt.executeUpdate("drop view if exists testc CASCADE"); 
  		stmt.executeUpdate("drop view if exists final CASCADE"); 
		//  the student concentration  that the student took and the avg gpa of it 
		stmt.executeUpdate ("create view testa as  SELECT distinct con.name,avg(g.number_grade) FROM student stu, course co, "+
		"class cl, past_class_taken pst, grade_conversion g, degree d,  concentration_course concon , concentration con"+
		" WHERE pst.studentid = "+sid+" and pst.courseid = co.id and  cl.courseid = co.id and  pst.grade = g.letter_grade and "+
		"co.id =concon.idcourse and con.id =concon.idconcentration group by con.name;");
	 	
		// C is required table
		stmt.executeUpdate("create view testc as SELECT distinct c.name, c.gpa,c.unit from course co, concentration c, concentration_course cs,"+
		" student s, degree d  where d.id = s.degree and co.id = cs.idcourse and cs.idconcentration = c.id and c.degreeid = d.id "+
		"and s.id = "+ sid +";");
		 	
		// the student concentration  that the student took and the sum unit of it  
		stmt.executeUpdate(" create view testb as "+
				"select con.name, sum(pst.unit) from concentration_course concon, concentration con,past_class_taken pst, "+
				"course co where concon.idconcentration = con.id and concon.idcourse = co.id and "+
				"pst.courseid = concon.idcourse and pst.studentid = "+sid + "group by con.name;");
	
		stmt.executeUpdate(" create view final as select testa.name,testa.avg,testb.sum from testa join testb on testa.name = testb.name;");
		//  ResultSet rset  = stmt.executeQuery(" create view final as select testa.name,testa.avg,testb.sum from testa join testb on testa.name = testb.name;");
		ResultSet rset =  stmt.executeQuery("select f.name from final f, testc tc where f.avg >= tc.gpa and f.name=tc.name and f.sum >= tc.unit;"); 		  
		
		while (rset.next ()) {	 
			%>
			     
			     
			     <tr>
						<td><%= rset.getString(1) %></td> 		    
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
	
	<b> Uncompleted Concentration Course </b>
	<table border = "1">
		<tr>
			<th>Course name  </th>
			<th> Next available time </th>
		</tr>
		<%
	try {
		Statement stmt = system.getConnection().createStatement ();
		stmt.executeUpdate("drop  view if exists pasttaken CASCADE");
		stmt.executeUpdate("drop  view if exists con_required CASCADE");
		stmt.executeUpdate("drop  view if exists pasttakenfail CASCADE");
		stmt.executeUpdate("drop  view if exists retakefail CASCADE");
		
		// 之前拿过的课
		stmt.executeUpdate("create view pasttaken as SELECT distinct co.code FROM student stu, course co, class cl, "+
		"past_class_taken pst, grade_conversion g  WHERE pst.studentid ="+sid+" and pst.courseid = co.id and "+
		"cl.courseid = co.id and g.letter_grade = pst.grade;" );
		
 
		// 之前拿过的 cencentration course 加上 number grade 
	 	stmt.executeUpdate("create view pasttakenfail as SELECT distinct co.code,pst.grade, g.number_grade FROM student stu, course co, class cl, "+
	 			"past_class_taken pst, grade_conversion g  WHERE pst.studentid ="+sid+" and pst.courseid = co.id and "+
	 			"cl.courseid = co.id and g.letter_grade = pst.grade;"); 
		
		// 之前拿过的不满足gpa的concentration课 
	 	stmt.executeUpdate ("create view gg as SELECT distinct pf.code from pasttakenfail pf , course co, class cl,"+
	 	" concentration c, concentration_course cs, past_class_taken pst, grade_conversion g, "+
	 			 "student s, degree d  where d.id = s.degree and co.id = cs.idcourse and cs.idconcentration = c.id and c.degreeid = d.id"+
	 			 " and s.id ="+sid +" and pf.number_grade < c.gpa and cl.courseid = cs.idcourse ;");
		
		 stmt.executeUpdate ("create view con_required as SELECT co.code ,cl.year,cl.quarter from course co, class cl, "+
		 "concentration c, concentration_course cs, student s, degree d  where d.id = s.degree and co.id = cs.idcourse "+
		 " and cs.idconcentration = c.id and c.degreeid = d.id and s.id ="+sid+ "and cl.year>=2020 and "+
		 "cl.courseid = cs.idcourse and (cl.year <>2020 or  cl.quarter<>3); ");
		 
		 stmt.executeUpdate ("create view retakefail as SELECT co.code ,cl.year,cl.quarter from course co, class cl, "+
				 "concentration c, concentration_course cs, student s, degree d  where d.id = s.degree and co.id = cs.idcourse "+
				 " and cs.idconcentration = c.id and c.degreeid = d.id and s.id ="+sid+ "and cl.year>=2020 and "+
				 "cl.courseid = cs.idcourse and (cl.year <>2020 or  cl.quarter<>3); ");
		
		ResultSet rset = stmt.executeQuery(" select code,year,quarter from con_required c where code not in (select * from pasttaken);");
		HashMap<Integer, String> quarterHash= new HashMap<>();
		quarterHash.put(1, "FALL");
		quarterHash.put(2, "WINTER");
		quarterHash.put(3, "SPRING");
		quarterHash.put(4, "SUMMER I");
		quarterHash.put(5, "SUMMER II"); 
		while (rset.next ()) {	 
			%>
			     <tr>
						<td><%= rset.getString(1) %></td>  
 						<td><%= rset.getInt(2)  %> - <%= quarterHash.get(rset.getInt(3))%> </td>
				</tr>
			<% 
			
		}
		rset = stmt.executeQuery("select code,year,quarter from retakefail  where code in (select * from gg);");
	 	while (rset.next()){
	 		%>
	 		   <tr>
						<td><%= rset.getString(1) %></td>  
 						<td><%= rset.getInt(2)  %> - <%= quarterHash.get(rset.getInt(3))%> </td>
				</tr>
	 		
	 		<%  
	 	}
		
 		// rset.close();
		 
			stmt.close();
	} catch(SQLException e) {
		e.printStackTrace();
	}
	%>
		
	</table>
	<br> 
	<a href="queryMasterRemainDegree.jsp">GO BACK</a> 

</body>
</html>