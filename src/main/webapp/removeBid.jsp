<%@ page import="project.pkg.*, java.sql.*" %>

<%
	String temp = request.getParameter("auctionID");
	int auctionID = Integer.parseInt(temp);
	String temp2 = request.getParameter("bidID");
	int bidID = Integer.parseInt(temp2);
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	String query = "SELECT i.bid_list FROM item i WHERE i.auction_id=" + auctionID + ";";
	ResultSet item = check.executeQuery(query);
	String bidlist = item.getString("bid_list");
	String username = new String();
	String bidAmount = new String();
	int bidInt = 0;
	for (int i = 0; i < bidlist.length(); i++) {
		int dollarCount = 0;
		if (bidlist.charAt(i) == '$') {
			dollarCount++;
		}
		if (dollarCount == bidID) {
			i++;
			while (bidlist.charAt(i) != ':') {
				bidAmount += bidlist.charAt(i);
			}
			while (i < bidlist.length() && bidlist.charAt(i) != '$') {
				username += bidlist.charAt(i);
			}
		}
	}
	if (username == null) {
		session.setAttribute("invalidBid", "true");
	} else {
		
	}
	dbsesh.closeConnection(current);
	response.sendRedirect("customerRepPage.jsp");
%>