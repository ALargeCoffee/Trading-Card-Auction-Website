<%@ page import="java.sql.*" %>

<%
	// Fetch login request
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	// Connect to database using DBConnect
	DBConnect dbsesh = new DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	ResultSet result = check.executeQuery("");
	dbsesh.closeConnection(current);
	// Check if query returns a valid user, log them in or throw error
	if (result.next()) {
		session.setAttribute("user", username);
		response.sendRedirect("homePage.jsp");
	} else {
		session.setAttribute("invalidLogin", "true");
		response.sendRedirect("loginPage.jsp");
	}
%>