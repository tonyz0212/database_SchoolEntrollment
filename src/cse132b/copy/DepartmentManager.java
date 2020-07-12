package cse132b.copy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DepartmentManager {
	private Connection connection;
	
	public DepartmentManager(Connection c) {
		this.connection = c;
	}
    
    public int insertDepartment(int id, String name) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO department VALUES (?, ?)"));
	    	pstmt.setInt(1, id); 
	    	pstmt.setString(2, name); 
	    	
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
    
    public void updateDepartment(int id, String name) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE department SET name = ? WHERE id = ?;"));
	    	pstmt.setInt(2, id); 
	    	pstmt.setString(1, name); 
 	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
	    
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    }
    
    public void deleteDepartment(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM department WHERE id = ?");
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
}
    