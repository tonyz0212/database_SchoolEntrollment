package cse132b.copy;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalTime;

public class CourseManager {
	private Connection connection;
	
	public CourseManager(Connection c) {
		this.connection = c;
	}
    
    public void insertCourse(String code, int grade_option, int ctype, boolean consent, int min_unit, int max_unit, int department,boolean lab) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO course VALUES (DEFAULT, ?, ?, ?, ?, ?,?,?,?)"));
	    	pstmt.setString(1, code); 
	    	pstmt.setInt(2, grade_option); 
	    	pstmt.setInt(3, ctype); 
	    	pstmt.setBoolean(4, consent); 
	    	pstmt.setInt(5, min_unit); 
	    	pstmt.setInt(6, max_unit); 
	    	pstmt.setInt(7, department); 
	    	pstmt.setBoolean(8,lab); 
	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}

    }
    
    public void updateCourse(int id, String code, int grade_option, int ctype, boolean consent, int min_unit, int max_unit, int department,boolean lab) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE course SET "
	    			+ "code = ?, grade_option = ?, ctype = ?, consent = ?, minunit = ?, maxunit = ?, department = ?, lab = ? WHERE id = ?;"));
	    	pstmt.setInt(9, id); 
	    	pstmt.setString(1, code); 
	    	pstmt.setInt(2, grade_option); 
	    	pstmt.setInt(3, ctype); 
	    	pstmt.setBoolean(4, consent); 
	    	pstmt.setInt(5, min_unit); 
	    	pstmt.setInt(6, max_unit); 
	    	pstmt.setInt(7, department); 
	    	pstmt.setBoolean(8,lab); 
 	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
	    
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    }
    
    public void deleteCourse(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM course WHERE id = ?");
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
    
    public void insertPrerequest(int courseid, int requestid) {
    	try {
			connection.setAutoCommit(false);
			
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO prerequest VALUES (DEFAULT, ?, ?)"));
	    	pstmt.setInt(1, courseid); 
	    	pstmt.setInt(2, requestid); 
	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
		} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			
	    }
    }
    
    public void deletePrerequest(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM prerequest WHERE id = ?");
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    public void insertClass(int id, String title, int year, int quarter, int course) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO class VALUES (?, ?, ?, ?, ?)"));
	    	pstmt.setInt(1, id); 
	    	pstmt.setString(2, title);
	    	pstmt.setInt(3, year); 
	    	pstmt.setInt(4, quarter); 
	    	pstmt.setInt(5, course); 
	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}

    }
    
    public void updateClass(int id, String title, int year, int quarter, int course) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE class SET "
	    			+ "title = ?, year = ?, quarter = ?, courseid = ? WHERE id = ?;"));
	    	pstmt.setInt(5, id); 
	    	pstmt.setString(1, title);
	    	pstmt.setInt(2, year); 
	    	pstmt.setInt(3, quarter); 
	    	pstmt.setInt(4, course);
 	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
	    
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    }
    
    public void deleteClass(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM class WHERE id = ?");
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
    
    public void insertSession(int sessionid, int classid, int limit, String faculty) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO session VALUES (?, ?, ?, ?)"));
	    	pstmt.setInt(1, sessionid); 
	    	pstmt.setInt(2, classid); 
	    	pstmt.setInt(3, limit); 
	    	pstmt.setString(4, faculty);
	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    	
    }
    
    public void updateSession(int sessionid, int classid, int limit, String faculty) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE session SET "
	    			+ " classid = ?, limit_num = ?, faculty = ? WHERE id = ?;"));
	    	pstmt.setInt(4, sessionid); 
	    	pstmt.setInt(1, classid); 
	    	pstmt.setInt(2, limit); 
	    	pstmt.setString(3, faculty);
 	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
	    
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    }
    
    
    public void deleteSession(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM session WHERE id = ?");
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
    }
    
    public void insertWeeklyMeeting(int sessionid, String start, String end, int day, int type, String location, Boolean mandatory) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO weekly_meeting VALUES (DEFAULT, ?, ?, ?, ?, ?, ?, ?)"));
	    	
	    	System.out.println(start);

	    	
	    	Time startT = Time.valueOf(start);
	    	Time endT = Time.valueOf(end);
	    	
	    	pstmt.setInt(1, sessionid); 
	    	pstmt.setTime(2, startT); 
	    	pstmt.setTime(3,endT); 
	    	pstmt.setInt(4, day); 
	    	pstmt.setInt(5, type); 
	    	pstmt.setString(6, location); 
	    	pstmt.setBoolean(7,mandatory); 
	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}	
    
    }
    public void updateWeeklyMeeting(int meetingid, int sessionid, String start, String end, int day, int type, String location, Boolean mandatory){
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE weekly_meeting SET "
	    			+ " session = ?, start_time = ?, end_time = ?, day = ?, mtype = ?, location = ?, mandatory = ? WHERE id = ?;"));
	    	
	    		    	
	    	Time startT = Time.valueOf(start);
	    	Time endT = Time.valueOf(end);
	    	
	    	pstmt.setInt(1, sessionid); 
	    	pstmt.setTime(2, startT); 
	    	pstmt.setTime(3,endT); 
	    	pstmt.setInt(4, day); 
	    	pstmt.setInt(5, type); 
	    	pstmt.setString(6, location); 
	    	pstmt.setBoolean(7,mandatory); 
	    	
	    	pstmt.setInt(8, meetingid);
 	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
	    	
	    
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    	
    }
    
    public void deleteWeeklyMeeting(int id) {
		try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM weekly_meeting WHERE id = ?");
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}    	
    }
    
    public void insertCourseEnroll(int studentid, int classid, int sessionid, int unit) {
    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO course_enrollment VALUES (DEFAULT,?, ?, ?,?,-1)"));
	    	pstmt.setInt(1, studentid); 
	    	pstmt.setInt(2, classid); 
	    	pstmt.setInt(3, sessionid); 
	    	pstmt.setInt(4, unit);
	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    	
    }
   
    public void updateCourseEnroll(int id, int sessionid,  int unit, int grade) {

    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
//	    	PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO course_enrollment VALUES (DEFAULT,?, ?, ?,?,?)"));
//	    	
	    	PreparedStatement pstmt = connection.prepareStatement( ("UPDATE course_enrollment SET "
	    			+ " session = ?, require_units = ?, grade_option = ? where id = ?;"));

	    	pstmt.setInt(1, sessionid); 
	    	pstmt.setInt(2, unit);
	    	pstmt.setInt(3,  grade);
	    	pstmt.setInt(4,  id);
	    	
	    	
	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    	
    }
    
    public void deleteCourseEnroll(int id) {
    	try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM course_enrollment WHERE id = ?");
			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    }    
    
    public void insertPastClass(int studentid, int courseid, int year, int quarter, String grade, int unit) {
        try {
      connection.setAutoCommit(false);
     
         //Create the prepared statement and use it to
         //INSERT the student attrs INTO the Student table.

         PreparedStatement pstmt = connection.prepareStatement( ("INSERT INTO past_class_taken VALUES (DEFAULT,?, ?,?,?,?,?)"));
         pstmt.setInt(1, studentid); 
         pstmt.setInt(2, courseid); 
         pstmt.setInt(3, year); 
         pstmt.setInt(4, quarter); 
         pstmt.setString(5, grade);
         pstmt.setInt(6, unit);
         
         pstmt.executeUpdate();
         connection.commit(); 
         connection.setAutoCommit(true);
        } catch (SQLException e) {
       // TODO Auto-generated catch block
       e.printStackTrace();
      }
        
       }
    
    public void updatePastClass(int pastclass_id, int studentid,int  classid ,int year,int quarter, String grade, int unit) {

    	try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
			PreparedStatement pstmt = connection.prepareStatement( ("UPDATE past_class_taken SET " 
	    			+ "studentid = ?, courseid = ?, year =?, quarter =?, grade =?, unit =?  where pastclass_id = ?;"));

	    	pstmt.setInt(1, studentid); 
	    	pstmt.setInt(2,classid);
	    	pstmt.setInt(3, year);
	    	pstmt.setInt(4, quarter);
	    	pstmt.setString(5,grade);
	    	pstmt.setInt(6,unit);
	    	pstmt.setInt(7, pastclass_id);

	    	pstmt.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
    	
    }
    
    public void deletePastClass(int id) {
    	try {
			PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM past_class_taken WHERE pastclass_id = ?");

			pstmt.setInt(1, id);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    }   
    
	public void insertReviewSession( int sessionID, String location, String start_time, String end_time, String date) {
		try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	PreparedStatement ps2 = connection.prepareStatement( ("INSERT INTO review_session VALUES (DEFAULT, ?, ?, ?, ?,?)"));
	    	
	     
	    	Time startD = Time.valueOf(start_time);
	    	Time endD = Time.valueOf(end_time);
	    	Date dateD = Date.valueOf(date);
	    	
	    	ps2.setInt(1, sessionID); 
	    	ps2.setString(2, location);
	    	ps2.setTime(3, startD); 
	    	ps2.setTime(4, endD);
	      	ps2.setDate(5, dateD);
	    	
	    	ps2.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
		
	}
	
	public void updateReviewSession( int id, int sessionID, String location, String start_time, String end_time, String date) {
		try {
			connection.setAutoCommit(false);
		
	    	//Create the prepared statement and use it to
	    	//INSERT the student attrs INTO the Student table.
	    	
	    	PreparedStatement ps2 = connection.prepareStatement( ("UPDATE review_session SET "
	    			+ "session = ? ,location = ?, start_time = ?, end_time = ?, re_date = ? where id = ?;"));
	    
	    	Time startD = Time.valueOf(start_time);
	    	Time endD = Time.valueOf(end_time);
	    	Date dateD = Date.valueOf(date);
	    	
	    	ps2.setInt(1, sessionID);
	    	ps2.setString(2, location);
	    	ps2.setTime(3, startD); 
	    	ps2.setTime(4, endD);
	      	ps2.setDate(5, dateD);
	      	ps2.setInt(6, id);
	     
	    	
	    	
	    	ps2.executeUpdate();
	    	connection.commit(); 
	    	connection.setAutoCommit(true);
    	} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
		
	}
	
	  public void deleteReviewSession(int id) {
			try {
				PreparedStatement pstmt = connection.prepareStatement( "DELETE FROM review_session WHERE session = ?");
				pstmt.setInt(1, id);
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
	    }
    

 
}

