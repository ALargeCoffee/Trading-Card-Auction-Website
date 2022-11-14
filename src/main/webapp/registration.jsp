<%@ page import="project.pkg.*, java.sql.*" %>

<%
	// Fetch username, password, phone number, and email
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String phone = request.getParameter("number");
	String email = request.getParameter("email");
	// Connect to database and insert the new user
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	String insertion = new String("INSERT INTO user(user_display_name, user_password, phone_number, email) VALUES ('" + username + "','" + password + "'," + phone + ",'" + email + "');");
	int ignore = check.executeUpdate(insertion);
	dbsesh.closeConnection(current);
	// Send to home page
	session.setAttribute("user", username);
	response.sendRedirect("homePage.jsp");
%>