<%@ page import="project.pkg.*, java.sql.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>

<%
	// Fetch credentials
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String phone = request.getParameter("number");
	String email = request.getParameter("email");
	// Connect to database and insert the new user
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	String userType = new String();
	if (session.getAttribute("cusRepReg") != null) {
		userType = "customerRep";
	} else {
		userType = "normal";
	}
	String insertion = "INSERT INTO user VALUES (" + phone + ",'" + email + "','" + username + "','" + password + "',NULL,'" + userType + "');";
	// Try to insert the value and redirect if on login page
	try {
		ResultSet userExists = check.executeQuery("SELECT * FROM user u WHERE u.user_display_name = '" + username + "';");
		if (userExists.next()) {
			session.setAttribute("invalidRegister", "true");
			if (session.getAttribute("cusRepReg") != null) {
				response.sendRedirect("adminPage.jsp");
			} else {
				response.sendRedirect("loginPage.jsp");
			}
		} else {
			int ignore = check.executeUpdate(insertion);
			if (session.getAttribute("cusRepReg") != null) {
				if (session.getAttribute("invalidRegister") != null) {
					session.removeAttribute("invalidRegister");
				}
				response.sendRedirect("adminPage.jsp");
			} else {
				session.setAttribute("user", username);
				session.setAttribute("userType", "normal");
				response.sendRedirect("homePage.jsp");
			}
		}
		dbsesh.closeConnection(current);
	} catch(Exception e) {
		out.print(e);
	}
%>