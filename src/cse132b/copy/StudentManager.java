package cse132b.copy;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;


public class StudentManager {
	private Connection connection;
	
	
	public StudentManager(Connection c) {
	
		this.connection = c;
	}
    // ====================== Student Table =======================
    public int insertStudent(int zid, String fn, String mn, String ln, int ssn, int res, boolean enroll, int level, int degree, String start, String end) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO Student VALUES (?, ?, ?, ?, ?,?,?,?,?,?,?)"));
	    	
	    	Date startD = Date.valueOf(start);
	    	Date endD = Date.valueOf(end);
	    	
	    	pstmt.setInt(1, zid); 
	    	pstmt.setInt(2, ssn); 
	    	pstmt.setString(3, fn); 
	    	pstmt.setString(4, mn); 
	    	pstmt.setString(5, ln); 
	    	pstmt.setInt(6, res); 
	    	pstmt.setBoolean(7, enroll); 
	    	pstmt.setInt(8, level); 
	    	pstmt.setInt(9, degree); 
	    	pstmt.setDate(10, startD); 
	    	pstmt.setDate(11, endD); 
	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	return 1;
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 			return 0;
 		}

    }
    
    public int updateStudent(int zid, String fn, String mn, String ln, int res, boolean enroll, int level, int degree, String start, String end) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE student SET "
	    			+ "firstname = ?, middlename = ?, lastname = ?, residency = ?, enrollment = ?, level = ?, degree = ?, start_date = ?, end_date = ? WHERE id = ?;"));
	    	Date startD = Date.valueOf(start);
	    	Date endD = Date.valueOf(end);
	    	
	    	pstmt.setInt(10, zid); 
	    	pstmt.setString(1, fn); 
	    	pstmt.setString(2, mn); 
	    	pstmt.setString(3, ln); 
	    	pstmt.setInt(4, res); 
	    	pstmt.setBoolean(5, enroll); 
	    	pstmt.setInt(6, level); 
	    	pstmt.setInt(7, degree); 
	    	pstmt.setDate(8, startD); 
	    	pstmt.setDate(9, endD); 
	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	return 1;
	    
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 			return 0;
 		}
    }
    
    public int deleteStudent(int zid) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM Student WHERE id = ?");
			pstmt.setInt(1, zid);
			pstmt.executeUpdate();
			return 1;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		
    }
    
 // ====================== Probation Table =======================
    
    public void insertProbation(int student, String reason, String start, String end) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO probation VALUES (DEFAULT, ?, ?, ?, ?)"));
	    		    	
	    	Date startD = Date.valueOf(start);
	    	Date endD = Date.valueOf(end);
	    	
	    	
	    	pstmt.setInt(1, student); 

	    	pstmt.setString(2, reason);
	    	pstmt.setDate(3, startD); 
	    	pstmt.setDate(4, endD); 

	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		} 

    }
    
    public void updateProbation(int id, int student, String reason, String start, String end) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE probation SET "
	    			+ "student = ?, reason = ?, startDate = ?, endDate = ? WHERE id = ?;"));
	    	Date startD = Date.valueOf(start);
	    	Date endD = Date.valueOf(end);
	    	
	    	pstmt.setInt(1, student); 
	    	pstmt.setString(2, reason);
	    	pstmt.setDate(3, startD); 
	    	pstmt.setDate(4, endD); 
	    	pstmt.setInt(5, id);
 	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
	    
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    }
    
    public void deleteProbation(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM probation WHERE id = ?");
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
    
 // ====================== Undergraduate Table =======================
    public void insertUnder(int studentid, String college, String major, String minor) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO undergraduate VALUES (DEFAULT, ?, ?, ?, ?)"));
	    		    	
	    	
	    	
	    	pstmt.setInt(1, studentid); 

	    	pstmt.setString(2, college);
	    	pstmt.setString(3, major); 
	    	pstmt.setString(4, minor); 

	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		} 
    	
    }
    
    public void updateUnder(int underid, String college, String major, String minor) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE undergraduate SET "
	    			+ "college = ?, major = ?, minor = ? WHERE underid = ?;"));


	    	pstmt.setString(1, college);
	    	pstmt.setString(2, major); 
	    	pstmt.setString(3, minor); 
	    	
	    	pstmt.setInt(4, underid);
 	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
	    	System.out.println("UPDATE");
	    	
	    
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
    	}
    }
    
    public void deleteUnder(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM undergraduate WHERE underid = ?");
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			System.out.println("DELETE");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
    }
    
    
 // ====================== Graduate Table ======================= 
    public void insertGrad(int studentid, int department, int classification, String advisor) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO graduate VALUES (DEFAULT, ?, ?, ?, ?)"));
	    		    	
	    	
	    	
	    	pstmt.setInt(1, studentid); 

	    	pstmt.setInt(2, department);
	    	pstmt.setInt(3, classification); 
	    	pstmt.setString(4, advisor); 

	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		} 
    	
    }
    
    public void updateGrad(int gradid, int department, int classification, String advisor) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE graduate SET "
	    			+ "department = ?, classification = ?, advisor = ? WHERE gradid = ?;"));


	    	pstmt.setInt(1, department); 

	    	pstmt.setInt(2, classification);
	    	pstmt.setString(3, advisor); 
	    	pstmt.setInt(5,gradid); 
 	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
	    	System.out.println("UPDATE");
	    	
	    
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
    	}
    }
    
    public void deleteGrad(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM graduate WHERE graduateid = ?");
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			System.out.println("DELETE");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }    
}
