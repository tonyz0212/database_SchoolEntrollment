package cse132b.copy;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class ThesisManager {
	private Connection connection;
	
	
	public ThesisManager(Connection c) {
		this.connection = c;
	}
	
	
    // ====================== Thesis Table =======================
    public void insertThesis(int id, int student_id) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the degree attrs INTO the degree table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO thesis VALUES (?,?)"));
	    	pstmt.setInt(1, id); 
	    	pstmt.setInt(2, student_id); 
	    	
	    	pstmt.executeUpdate();
	    //	ps2.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
    	} 
    catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}

    }
    
    public void updateThesis(int id, int stdid) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//UPDATE the degree attrs INTO the degree table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE thesis SET "
	    			+ " studentid = ? where id = ? ;"));
	    	
	     	pstmt.setInt(1, stdid); 
	    	pstmt.setInt(2, id);  
	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    }
    
    public void deleteThesis(int id) {
 		try {
 			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM thesis WHERE id = ?");

 			pstmt.setInt(1,id);
 			pstmt.executeUpdate();

 		} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
 		
     }
    
    public void deleteThesisInstructor(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM thesis_instructor WHERE id = ?");

			pstmt.setInt(1,id);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
    
    public void updateThesisInstructor(int id, String  faculty) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//UPDATE the degree attrs INTO the degree table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE thesis_instructor SET "
	    			+ " faculty_name = ? where thesisId = ? ;"));
	    	
	     	pstmt.setString(1, faculty); 
	     	pstmt.setInt(2, id); 
	     	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    }
    
    public void insertThesisInstructor(int id, int department, String faculty ) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the degree attrs INTO the degree table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO thesis_instructor VALUES (DEFAULT,?,?,?)"));
	    	pstmt.setInt(1, id); 
	    	pstmt.setInt(2, department); 
	    	pstmt.setString(3, faculty); 
	    	
	    	pstmt.executeUpdate();
	   
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
    	} 
    catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}

    }
    
    public void insertTechnical( int courseid ) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the degree attrs INTO the degree table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO technical_elective VALUES (DEFAULT,?)"));
	    	pstmt.setInt(1, courseid); 
	    
	    	
	    	pstmt.executeUpdate();
	   
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
    	} 
    catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}

    }
    
    public void deleteTechnical(int id) {
 		try {
 			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM technical_elective WHERE techid = ?");

 			pstmt.setInt(1,id);
 			pstmt.executeUpdate();

 		} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
 		
     }
    
    
}
