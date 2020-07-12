package cse132b.copy;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class DegreeEntryManager {
	private Connection connection;
	
	public DegreeEntryManager(Connection c) {
		this.connection = c;
	}
    // ====================== Degree Table =======================
    public void insertDegree( String name, int required_units, String type, int department_id ) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the degree attrs INTO the degree table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO degree VALUES (DEFAULT,?,?,?,?)"));
//	    	pstmt.setInt(1, id); 
	    	pstmt.setString(1, name); 
	    	pstmt.setInt(2, required_units); 
	    	pstmt.setString(3, type); 
	    	pstmt.setInt(4, department_id); 	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}

    }
    
    public void updateDegree( int required_units, int departmentid) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//UPDATE the degree attrs INTO the degree table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE degree SET "
	    			+ "  required_units = ? where department_id = ?;"));
	    	
 
	    	pstmt.setInt(1, required_units); 
	    	pstmt.setInt(2, departmentid); 
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
	    
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    }
    
    public void deleteDegree(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM degree WHERE id = ?");
			pstmt.setInt(1,id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
    
    public void insertLower(int degree, int unit, double gpa) {
     	try {
			connection.setAutoCommit(false);
		
	  
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO lower_division VALUES (DEFAULT,?,?,?)"));
	    	pstmt.setInt(1, degree); 
	    	pstmt.setInt(2, unit); 
	    	pstmt.setDouble(3, gpa);   	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 		
 		}
    	
    }
    
    public void deleteLower(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM lower_division WHERE degree = ?");
			pstmt.setInt(1,id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
    
    public void insertUpper(int degree, int unit, double gpa) {
     	try {
			connection.setAutoCommit(false);
		
	  
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO upper_division VALUES (DEFAULT,?,?,?)"));
	    	pstmt.setInt(1, degree); 
	    	pstmt.setInt(2, unit); 
	    	pstmt.setDouble(3, gpa);   	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 		
 		}
    	
    }
    
    public void deleteUpper(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM upper_division WHERE degree = ?");
			pstmt.setInt(1,id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
    
    public void insertConcentration(int id, String name, double gpa, int degree, int unit) {
     	try {
			connection.setAutoCommit(false);
		
	  
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO concentration VALUES (?,?,?,?,?)"));
	    	pstmt.setInt(1, id); 
	    	pstmt.setString(2,name);
	    	pstmt.setDouble(3, gpa);   	
	    	pstmt.setInt(4, degree);
	    	pstmt.setInt(5, unit);
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 		
 		}
    	
    }
    
    public void deleteConcentration(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM concentration WHERE id = ?");
			pstmt.setInt(1,id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
    
    public void insertConcentrationCourse(int idconcentration, int idcourse) {
     	try {
			connection.setAutoCommit(false);
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO concentration_course VALUES (DEFAULT,?,?)"));
	    	pstmt.setInt(1, idconcentration); 
	    	pstmt.setInt(2, idcourse); 
	    	 	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 		
 		}
    	
    }
    
    public void updateConcentrationCourse( int conID, int courseID) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//UPDATE the degree attrs INTO the degree table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE concentration_course SET "
	    			+ " idcourse = ? where idconcentration = ?;"));
	    	
	     	pstmt.setInt(1, courseID); 
	    	pstmt.setInt(2, conID); 
	    
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
	    
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    }
    
    
    public void deleteConcentrationCourse(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM concentration_course WHERE idcourse = ?");
			pstmt.setInt(1,id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
    
}
