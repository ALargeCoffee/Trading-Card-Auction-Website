<%@ page import="project.pkg.*, java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title> Earnings Report </title>
	</head>
	<body>
		<a href="adminPage.jsp">Return</a> <br> <br>
	<%
		String reportType = request.getParameter("type");
		project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
		Connection curr = dbsesh.getConnection();
		Statement check = curr.createStatement();
		try {
			if (reportType.equals("cards")) {
				String cardQuery = "SELECT i.auction_id, i.card_name, s.is_Sold, max(b.bid_price) AS price FROM item i INNER JOIN buying b ON i.auction_id = b.auction_id INNER JOIN selling s ON i.auction_id = s.auction_id GROUP BY i.auction_id;";
				ResultSet cards = check.executeQuery(cardQuery);
				while (cards.next()) {
					out.print(cards.getString("card_name") + " (" + cards.getInt("auction_id") + "): ");
					if (cards.getBoolean("is_Sold")) {
						out.println("$" + cards.getInt("price") + "<br> <br>");
					} else {
						out.println("UNSOLD" + "<br> <br>");
					}
				}
				ResultSet othercards = check.executeQuery("SELECT i.card_name FROM item i WHERE i.card_name NOT IN (SELECT T1.card_name FROM (SELECT i.card_name, s.is_Sold, max(b.bid_price) AS price FROM item i INNER JOIN buying b ON i.auction_id = b.auction_id INNER JOIN selling s ON i.auction_id = s.auction_id GROUP BY i.card_name) AS T1);");
				while (othercards.next()) {
					out.println(othercards.getString("card_name") + ": UNSOLD <br> <br>");
				}
			} else if (reportType.equals("cardTypes")) {
				String cardTypeQuery = "SELECT i.category, b.auction_id, max(b.bid_price) AS price, s.is_Sold FROM item i INNER JOIN buying b ON b.auction_id = i.auction_id INNER JOIN selling s ON s.auction_id = i.auction_id GROUP BY b.auction_id ORDER BY i.category;";
				ResultSet cardTypeNums = check.executeQuery(cardTypeQuery);
				String currCat = new String();
				int currSum = 0;
				while (cardTypeNums.next()) {
					if (currCat.isEmpty()) {
						currCat = cardTypeNums.getString("category");
						out.print(currCat + ": ");
					} else if (!currCat.equals(cardTypeNums.getString("category"))) {
						out.print("$" + currSum + "<br><br>");
						currSum = 0;
						currCat = cardTypeNums.getString("category");
						out.print(currCat + ": ");
					}
					if (cardTypeNums.getBoolean("is_Sold")) {
						currSum += cardTypeNums.getInt("price");
					}
				}
				out.print("$" + currSum + "<br><br>");
				ResultSet otherCats = check.executeQuery("SELECT DISTINCT i.category FROM item i WHERE i.category NOT IN (SELECT T1.category FROM (SELECT i.category, b.auction_id, max(b.bid_price) AS price, s.is_Sold FROM item i INNER JOIN buying b ON b.auction_id = i.auction_id INNER JOIN selling s ON s.auction_id = i.auction_id GROUP BY b.auction_id ORDER BY i.category) AS T1);");
				while (otherCats.next()) {
					out.println(otherCats.getString("category") + ": $0");
				}
			} else {
				String userQuery = "SELECT s.user_display_name, s.is_Sold, b.auction_id, max(b.bid_price) AS price FROM selling s INNER JOIN buying b ON s.auction_id = b.auction_id GROUP BY b.auction_id ORDER BY s.user_display_name;";
				ResultSet userCards = check.executeQuery(userQuery);
				String currUser = new String();
				int currSum = 0;
				while (userCards.next()){
					if (currUser.isEmpty()) {
						currUser = userCards.getString("user_display_name");
						out.print(currUser + ": ");
					} else if (!currUser.equals(userCards.getString("user_display_name"))) {
						out.print("$" + currSum + "<br><br>");
						currSum = 0;
						currUser = userCards.getString("user_display_name");
						out.print(currUser + ": ");
					}
					if (userCards.getBoolean("is_Sold")) {
						currSum += userCards.getInt("price");
					}
				}
				out.print("$" + currSum + "<br><br>");
				ResultSet otherUsers = check.executeQuery("SELECT u.user_display_name FROM user u WHERE u.user_display_name NOT IN (SELECT T1.user_display_name FROM (SELECT s.user_display_name, s.is_Sold, max(b.bid_price) AS price FROM selling s INNER JOIN buying b ON s.auction_id = b.auction_id GROUP BY s.user_display_name) AS T1 );");
				while (otherUsers.next()) {
					out.println(otherUsers.getString("user_display_name") + ": $0 <br> <br>");
				}
			}
			dbsesh.closeConnection(curr);
		} catch (Exception e) {
			dbsesh.closeConnection(curr);
			out.println(e);
		}
	%>
	</body>
</html>