import java.sql.Connection;
import java.sql.DriverManager;

//Most of this will follow template project on Canvas
public class DBConnect {
	
	// Database connection object
	public DBConnect() {}
	
	// Connects to database
	public Connection getConnection() {
		// Get database connection URL
		String connectionUrl = "jdbc:mysql://localhost:3306/tradingCardAuctionWebsite";
		Connection con = null;
		// Load JDBC Driver
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
		// Use connection object to connect to DB
		try {
			con = DriverManager.getConnection(connectionUrl, "root", "g6%PXrw77$_");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
	
	// Closes connection to database
	public void closeConnection(Connection con) {
		try {
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// Ignore
	public static void main(String[] args) {
		DBConnect current = new DBConnect();
		Connection con = current.getConnection();
		System.out.println(con);
		current.closeConnection(con);
	}
}