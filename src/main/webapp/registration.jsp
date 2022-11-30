<%@ page import="project.pkg.*, java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<%
	// The following code functions for both registering from the login page and for admins registering customer reps
	// Fetch credentials
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String repID = new String();
	String phone = new String();
	String email = new String();
	if (session.getAttribute("cusRepReg") != null) {
		repID = request.getParameter("repID");
	} else {
		phone = request.getParameter("number");
		email = request.getParameter("email");
	}
	// Connect to database and insert the new user
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	String insertion = new String();
	if (session.getAttribute("cusRepReg") != null) {
		insertion = "INSERT INTO customer_representative VALUES ('" + repID + "','" + password + "','" + username + "');";
	} else {
		insertion = "INSERT INTO user(user_display_name, user_password, phone_number, email) VALUES ('" + username + "','" + password + "'," + phone + ",'" + email + "');";
	}
	// Try to insert the value and redirect if on login page
	try {
		if (session.getAttribute("cusRepReg") == null) {
			ResultSet userExists = check.executeQuery("SELECT * FROM user u WHERE u.user_display_name = '" + username + "';");
			if (userExists.next()) {
				session.setAttribute("invalidRegister", "true");
				response.sendRedirect("loginPage.jsp");
			} else {
				session.setAttribute("user", username);
				session.setAttribute("userType", "user");
				int ignore = check.executeUpdate(insertion);
				response.sendRedirect("homePage.jsp");
			}
		} else {
			ResultSet repExists = check.executeQuery("SELECT * FROM customer_representative c WHERE c.cr_display_name = '" + username + "';");
			if (repExists.next()) {
				session.setAttribute("invalidRegister", "true");
			} else {
				int ignore = check.executeUpdate(insertion);
			}
			response.sendRedirect("homePage.jsp");
		}
		dbsesh.closeConnection(current);
	} catch(Exception e) {
		out.print(e);
	}
%>