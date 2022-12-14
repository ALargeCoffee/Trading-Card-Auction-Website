<%@ page import="project.pkg.*, java.sql.*" %>

<%
	// Fetch login request
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	// Connect to database using DBConnect
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	// Check database to see if login credentials are valid
	try {
		ResultSet userQuery = check.executeQuery("SELECT * FROM user u WHERE u.user_display_name='" + username + "' AND u.user_password='" + password + "';");
		if (userQuery.next()) {
			session.setAttribute("user", username);
			session.setAttribute("userType", userQuery.getString("userType"));
			response.sendRedirect("homePage.jsp");
		} else {
			session.setAttribute("invalidLogin", "true");
			response.sendRedirect("loginPage.jsp");
		}
		dbsesh.closeConnection(current);
	} catch (Exception e) {
		out.print(e);
	}
%>