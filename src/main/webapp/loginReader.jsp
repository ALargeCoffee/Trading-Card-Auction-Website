<%@ page import="project.pkg.*, java.sql.*" %>

<%
	// Fetch login request
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	// Connect to database using DBConnect
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	ResultSet result = check.executeQuery("SELECT * FROM user u WHERE u.user_display_name='" + username + "' AND u.user_password='" + password + "';");
	// Check if query returns a valid user, log them in or throw error
	if (result.next()) {
		session.setAttribute("user", username);
		response.sendRedirect("homePage.jsp");
	} else {
		session.setAttribute("invalidLogin", "true");
		response.sendRedirect("loginPage.jsp");
	}
	dbsesh.closeConnection(current);
%>