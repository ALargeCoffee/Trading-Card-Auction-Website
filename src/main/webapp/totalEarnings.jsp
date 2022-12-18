<%@ page import="project.pkg.*, java.sql.*" %>

<%
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	try {
		int totalSum = 0;
		ResultSet earnings = check.executeQuery("SELECT max(b.bid_price) AS price, s.is_Sold, b.auction_id FROM buying b INNER JOIN selling s ON b.auction_id = s.auction_id GROUP BY b.auction_id;");
		while (earnings.next()) {
			if (earnings.getBoolean("is_Sold")) {
				totalSum += earnings.getInt("price");
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