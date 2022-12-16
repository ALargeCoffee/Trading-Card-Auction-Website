<%@ page import="project.pkg.*, java.sql.*" %>

<%
	String reportType = request.getParameter("command");
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection curr = dbsesh.getConnection();
	Statement check = curr.createStatement();
	try {
		if (reportType.equals("cards")) {
			String cardQuery = "SELECT i.card_name, i.bid_list, i.end_time FROM item i;";
			ResultSet cards = check.executeQuery(cardQuery);
			while (cards.next()) {
				out.print(cards.getString("card_name") + ": ");
				if (cards.getDate("end_time") != null) {
					// use bid_list to get last bid price and print
				} else {
					out.println("UNSOLD");
				}
			}
		} else if (reportType.equals("cardTypes")) {
			String cardTypeQuery = "SELECT i.categories, i.bid_list, i.end_time FROM item i GROUP BY categories;";
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
				// use bid_list to increment currSum
			}
			out.println(currSum);
		} else {
			String userQuery = "SELECT u.user_display_name, u.auction_history FROM user u;";
			ResultSet users = check.executeQuery(userQuery);
			while (users.next()) {
				out.print(users.getString("user_display_name"));
				double currSum = 0;
				// use auction_history to increment currSum
				out.println(currSum);
			}
		}
		dbsesh.closeConnection(curr);
	} catch (Exception e) {
		dbsesh.closeConnection(curr);
		out.println(e);
	}
%>