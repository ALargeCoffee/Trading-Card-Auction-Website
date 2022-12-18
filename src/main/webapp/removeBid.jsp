<%@ page import="project.pkg.*, java.sql.*" %>

<%
	String temp = request.getParameter("auctionID");
	int auctionID = Integer.parseInt(temp);
	String temp2 = request.getParameter("bidPrice");
	int bidPrice = Integer.parseInt(temp2);
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	String query = "SELECT * FROM buying b WHERE b.auction_id =" + auctionID + " AND b.bid_price=" + bidPrice + " ;";
	ResultSet bids = check.executeQuery(query);
	if (bids.next()) {
		String delete = "DELETE FROM buying b WHERE b.auction_id=" + auctionID + " AND b.bid_price=" + bidPrice + ";";
		check.executeUpdate(delete);
	} else {
		session.setAttribute("invalidBid", true);
	}
	dbsesh.closeConnection(current);
	response.sendRedirect("customerRepPage.jsp");
%>