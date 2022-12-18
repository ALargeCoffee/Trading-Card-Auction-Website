<%@ page import="project.pkg.*, java.sql.*" %>

<%
	// Fetch entered bid
	Integer bidVal = Integer.parseInt(request.getParameter("b1"));
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	Integer enteredID = Integer.parseInt(request.getParameter("item_id"));
	try {
		ResultSet userQuery = check.executeQuery("SELECT MAX(bid_price) FROM buying b WHERE b.auction_id = entered_id GROUP BY b.auction_id");
		userQuery.next();
		
		
		response.sendRedirect("auctionPage.jsp");
		dbsesh.closeConnection(current);
	}
	catch (Exception e) {
		out.print(e);
	}
%>