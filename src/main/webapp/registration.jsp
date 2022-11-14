<%@ page import="java.sql.*" %>

<%
	// Fetch username and password
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	// Connect to database and insert the new user
	DBConnect dbsesh = new DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	String insertion = new String("INSERT INTO USERS VALUES ('" + username + "','" + password + "');");
	int ignore = check.executeUpdate(insertion);
	dbsesh.closeConnection(current);
	// Send to home page
	session.setAttribute("user", username);
	response.sendRedirect("homePage.jsp");
%>