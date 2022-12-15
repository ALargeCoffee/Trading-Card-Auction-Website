<%@ page import="project.pkg.*, java.sql.*" %>

<%
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	try {
		ResultSet earnings = check.executeQuery("SELECT bid_list, end_time FROM item i;");
		double totalSum = 0;
		while (earnings.next()) {
			if (earnings.getDate("end_time") != null) {
				// increment total sum
			}
		}
		session.setAttribute("totEarn", totalSum);
		dbsesh.closeConnection(current);
		response.sendRedirect("adminPage.jsp");
	} catch (Exception e) {
		dbsesh.closeConnection(current);
		out.print(e);
	}
%>