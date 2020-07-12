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
<title>Display Classes</title>
</head>
<body>
	<%	
		SystemManager system = (SystemManager) request.getSession().getAttribute("sm");		
		String sid = request.getParameter("sid"); 
	%>
		Report for student <%=sid%>
	<table border = "1">
		<tr>
			<th>Course Code</th>
			<th>Class Title</th>
			<th>Unit</th>
			<th>Year</th>
			<th>Quarter</th>
			<th>Grade Received</th>
			<th>GPA Received</th>			
		</tr>
		
		<tr>
		<% 
		HashMap<Integer, String> quarterHash= new HashMap<>();
		double gpaSum = 0;
		quarterHash.put(1, "FALL");
		quarterHash.put(2, "WINTER");
		quarterHash.put(3, "SPRING");
		quarterHash.put(4, "SUMMER I");
		quarterHash.put(5, "SUMMER II"); %>
	<%
	try {
/* 		double gpaSum = 0; */
		int count =0;
	 	double gpaCumulative =0;
		 HashMap <String,Double> quarterGpa = new HashMap<>();
		 HashMap <String,Integer> coursesPerQuarter = new HashMap<>();			 
		Statement stmt = system.getConnection().createStatement ();
		ResultSet rset = stmt.executeQuery ("SELECT distinct co.code, cl.title, pst.unit , pst.year, pst.quarter,pst.grade, g.number_grade"+
		" FROM course co, class cl,past_class_taken pst, grade_conversion g WHERE pst.studentid ="+sid+
		" and pst.year = cl.year and pst.quarter = cl.quarter and pst.courseid = co.id and cl.courseid = co.id"+
		" and g.letter_grade = pst.grade ORDER BY pst.year,pst.quarter;") ; 
		while (rset.next ()) {
			%><tr>
			<% int year = rset.getInt(4);
			
			   // append year and quarter and store into a hashmap
			   String yearStr = String.valueOf(year);
			   String quarter = quarterHash.get(rset.getInt(5));
			   count+=1;
			   gpaCumulative+=rset.getDouble(7);
 			  /*   System.out.println(" count "+ count);
			    System.out.println(" sum "+ gpaCumulative);   */			   
		       StringBuilder sb = new StringBuilder();
			   sb.append(yearStr+"-"+quarter);
			   
			   String sbs = sb.toString();

			   // when encounter a new quarter, reset GPA
			   if(!quarterGpa.containsKey(sbs)){
				   gpaSum=0;
			   }
			   gpaSum+=rset.getDouble(7);
			   quarterGpa.put(sbs,gpaSum);
			   
			   // count the number of courses in each quarter
			   coursesPerQuarter.put(sbs,coursesPerQuarter.getOrDefault(sbs, 0)+1);
		
			
			%>
					<form action="classTaken.jsp" method="get">
						
						<!--  course code string -->
						<td><%= rset.getString(1) %></td> 						
						<td><%= rset.getString(2) %></td> 
						<td><%= rset.getInt(3) %></td> 
						<td><%= rset.getInt(4) %></td> 
						<td><%= quarterHash.get(rset.getInt(5)) %></td> 
						<td><%= rset.getString(6) %></td> 
						<td><%= rset.getDouble(7) %></td>
			
					</form>
				</tr>
		<%
		
		
		}
		  for (Map.Entry entry : quarterGpa.entrySet())
		   {
			   double j = (double)entry.getValue();
			   String k = entry.getKey().toString();	    
			   pageContext.setAttribute("quarter", k);
			   int courseTotal = coursesPerQuarter.get(k);
			   double v = j/courseTotal;
			   pageContext.setAttribute("gpa", v);
			   %>
				<br>
				  The grade for quarter ${quarter} has a GPA of ${gpa}
				  <%
		   }
			   
		%>
		
	
		 
		
<br> 
		<% 
 		   /* System.out.println(" count "+ count);
		   System.out.println(" sum "+ gpaCumulative); 
		    */
		   double result = gpaCumulative / count;

		    result = (int)(Math.round(result * 100))/100.0;

		   pageContext.setAttribute("result", result);
		%>
		  Overall, Cumulative GPA is ${result}

		   <%  
			rset.close();
			stmt.close();
	} catch(SQLException e) {
		e.printStackTrace();
	}
	%>
	</table>
		  
	<br>
	<a href="studentGradeReport.jsp">GO BACK</a> 

</body>
</html>