<%@ page import="project.pkg.*, java.sql.*" %>

<%
	// Fetch login request
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	// Connect to database using DBConnect
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	// Check database to see what type of user is logging in and if login credentials are valid
	ResultSet adminQuery = check.executeQuery("SELECT * FROM admin_staff_member a WHERE a.admin_display_name='" + username + "' AND a.admin_password='" + password + "';");
	if (adminQuery.next()) {
		session.setAttribute("user", username);
		session.setAttribute("userType", "admin");
		response.sendRedirect("homePage.jsp");
	} else {
		ResultSet cusRepQuery = check.executeQuery("SELECT * FROM customer_representative c WHERE c.cr_display_name='" + username + "' AND c.cr_password='" + password + "';");
		if (cusRepQuery.next()) {
			session.setAttribute("user", username);
			session.setAttribute("userType", "customerRep");
			response.sendRedirect("homePage.jsp");
		} else {
			ResultSet userQuery = check.executeQuery("SELECT * FROM user u WHERE u.user_display_name='" + username + "' AND u.user_password='" + password + "';");
			// Check if query returns a valid user, log them in or throw error
			if (userQuery.next()) {
				session.setAttribute("user", username);
				session.setAttribute("userType", "user");
				response.sendRedirect("homePage.jsp");
			} else {
				session.setAttribute("invalidLogin", "true");
				response.sendRedirect("loginPage.jsp");
			}
		}
	}
	dbsesh.closeConnection(current);
%>