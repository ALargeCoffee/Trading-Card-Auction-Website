<%@ page import="project.pkg.*, java.sql.*" %>

<%
	String username = request.getParameter("username");
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	if (request.getParameter("newUsername") != null) {
		String newUser = request.getParameter("newUsername");
		String query = "SELECT * FROM user WHERE user_display_name = '" + newUser + "';";
		ResultSet exists = check.executeQuery(query);
		if (exists.next()) {
			session.setAttribute("invalidUser", true);
		} else {
			String update = "UPDATE user SET user_display_name='" + newUser + "' WHERE user_display_name='" + username + "';";
			check.executeUpdate(update);
			session.setAttribute("user", newUser);
		}
	}
	if (request.getParameter("password") != null) {
		String newPass = request.getParameter("password");
		String update = "UPDATE user SET user_password='" + newPass + "' WHERE user_display_name='" + username + "';";
		check.executeUpdate(update);
	}
	if (request.getParameter("number") != null) {
		String quick = request.getParameter("number");
		int newNumber = Integer.parseInt(quick);
		String update = "UPDATE user SET phone_number='" + newNumber + "' WHERE user_display_name='" + username + "';";
		check.executeUpdate(update);
	}
	if (request.getParameter("email") != null) {
		String newEmail = request.getParameter("email");
		String update = "UPDATE user SET email='" + newEmail + "' WHERE user_display_name='" + username + "';";
		check.executeUpdate(update);
	}
	dbsesh.closeConnection(current);
	response.sendRedirect("customerRepPage.jsp");
%>