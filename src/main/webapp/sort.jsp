<%@ page import="project.pkg.*, java.sql.*" %>

<%
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	try {
		ResultSet order;
		if (request.getParameter("command").equals("category")) {
			order = check.executeQuery("SELECT i.card_name, i.end_time, i.initial_price, i.description, i.auction_id, i.category FROM item i ORDER BY i.category;");
		} else if (request.getParameter("command").equals("plh")) {
			order = check.executeQuery("SELECT i.card_name, i.end_time, i.initial_price, i.description, i.auction_id, i.category, max(t1.bid_price) AS price FROM (SELECT b.bid_price, b.auction_id FROM buying b) AS t1 INNER JOIN item i ON t1.auction_id = i.auction_id GROUP BY i.auction_id ORDER BY price ASC;");
		} else {
			order = check.executeQuery("SELECT i.card_name, i.end_time, i.initial_price, i.description, i.auction_id, i.category, max(t1.bid_price) AS price FROM (SELECT b.bid_price, b.auction_id FROM buying b) AS t1 INNER JOIN item i ON t1.auction_id = i.auction_id GROUP BY i.auction_id ORDER BY price DESC;");
		}
		session.setAttribute("order", order);
		response.sendRedirect("homePage.jsp");
	} catch (Exception e) {
		dbsesh.closeConnection(current);
		out.println(e);
	}
%>