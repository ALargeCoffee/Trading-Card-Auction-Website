<%@ page import="project.pkg.*, java.sql.*" %>

<%
	String temp = request.getParameter("auctionID");
	int auctionID = Integer.parseInt(temp);
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	String query = "SELECT * FROM item WHERE auction_id=" + auctionID + ";";
	ResultSet auctions = check.executeQuery(query);
	if (auctions.next()) {
		String delete = "DELETE FROM item WHERE auction_id=" + auctionID + ";";
		check.executeUpdate(delete);
	} else {
		session.setAttribute("invalidAuction", true);
	}
	dbsesh.closeConnection(current);
	response.sendRedirect("customerRepPage.jsp");
%>