<%@ page import="project.pkg.*, java.sql.*" %>

<%
	String reportType = request.getParameter("command");
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection curr = dbsesh.getConnection();
	Statement check = curr.createStatement();
	try {
		if (reportType.equals("cards")) {
			String cardQuery = "SELECT card_name, bid_list, end_time FROM item i;";
			ResultSet cards = check.executeQuery(cardQuery);
			while (cards.next()) {
				out.print(cards.getString("card_name") + ": ");
				if (cards.getDate("end_time") != null) {
					// get last bid price and print
				} else {
					out.println("UNSOLD");
				}
			}
		} else if (reportType.equals("cardTypes")) {
			String cardTypeQuery = "SELECT categories, bid_list FROM item i GROUP BY categories;";
			ResultSet cardTypeNums = check.executeQuery(cardTypeQuery);
			String currType = new String();
			double currSum = 0;
			while (cardTypeNums.next()) {
				if (currType == null) {
					currType = cardTypeNums.getString("categories");
					out.print(currType + ": ");
				} else if (!cardTypeNums.getString("categories").equals(currType)) {
					currType = cardTypeNums.getString("categories");
					out.println(currSum);
					out.print(currType + ": ");
					currSum = 0;
				}
				// increment currSum
			}
			out.println(currSum);
		} else {
			String userQuery = "SELECT user_display_name, auction_history FROM user u;";
			ResultSet users = check.executeQuery(userQuery);
			while (users.next()) {
				
			}
		}
		dbsesh.closeConnection(curr);
	} catch (Exception e) {
		dbsesh.closeConnection(curr);
		out.println(e);
	}
%>