package cse132b.copy;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SystemManager {
	private Connection connection;

	public SystemManager() {
		connectServer();
	}
	
	public StudentManager getSM() {
		return new StudentManager(connection);
	}
	
	public DepartmentManager getDM() {
		return new DepartmentManager(connection);
	}	
	
	public ThesisManager getThesis() {
		return new ThesisManager(connection);
	}
	
	public DegreeEntryManager getDegreeM() {
		return new DegreeEntryManager(connection);
	}
	
	public FacultyManager getFM() {
		return new FacultyManager(connection);
	}
	
	public CourseManager getCM() {
		return new CourseManager(connection);
	}
	public Connection getConnection() {
		return this.connection;
	}
	public void connectServer() {
        try{
            String url="jdbc:postgresql://localhost:5433/postgres";
            String user="postgres";
            String password = "1234";
            Class.forName("org.postgresql.Driver");
            this.connection = DriverManager.getConnection(url, user, password);
            System.out.println("成功连接pg数据库 " + connection);
        }catch(Exception e){
            throw new RuntimeException(e);
        }
	}
	
	public void closeConnection() {
        try{
            connection.close();
        }
        catch(SQLException e){
            e.printStackTrace();
            throw new RuntimeException(e);
        }
	}
}

