package cse132b.copy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class FacultyManager {
	private Connection connection;
	
	public FacultyManager(Connection c) {
		this.connection = c;
	}
    
    public void insertFaculty(String name, int title, int department) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO faculty VALUES (?, ?, ?)"));
	    	pstmt.setString(1, name); 
	    	pstmt.setInt(2, title); 
	    	pstmt.setInt(3, department);
	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}

    }
    
    public void updateFaculty(String name, int title, int department) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE faculty SET title = ?, department = ? WHERE name = ?;"));
	    	pstmt.setInt(1, title); 
	    	pstmt.setInt(2, department); 
	    	pstmt.setString(3, name); 
 	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
	    
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    }
    
    public void deleteFaculty(String name) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM faculty WHERE name = ?");
			pstmt.setString(1, name);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
}
    