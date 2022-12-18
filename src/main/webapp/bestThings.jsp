<%@ page import="project.pkg.*, java.sql.*, java.lang.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title> Best Items/Buyers </title>
	</head>
	<body>
		<a href="adminPage.jsp">Return</a> <br> <br>
		<%
		String bestType = request.getParameter("type");
		project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
		Connection current = dbsesh.getConnection();
		Statement check = current.createStatement();
		try {
			if (bestType.equals("items")) {
				String itemQuery = "SELECT t1.card_name, count(*) AS sells FROM (SELECT i.card_name FROM item i INNER JOIN selling s ON i.auction_id = s.auction_id WHERE s.is_Sold = true) AS t1 GROUP BY t1.card_name ORDER BY sells DESC";
				ResultSet cards = check.executeQuery(itemQuery);
				out.print("Best selling items: <br> <br>");
				while (cards.next()) {
					out.print(cards.getString("card_name") + ": " + cards.getInt("sells") + " sold <br> <br>");
				}
			} else {
				ResultSet buyers = check.executeQuery("SELECT t2.user_display_name, count(*) AS buys FROM (SELECT t1.auction_id, t1.user_display_name, max(t1.bid_price) AS price FROM (SELECT b.auction_id, b.user_display_name, b.bid_price, s.is_Sold FROM buying b INNER JOIN selling s ON b.auction_id = s.auction_id WHERE s.is_Sold = true) AS t1 GROUP BY t1.auction_id) AS t2 GROUP BY t2.user_display_name");
				out.println("Best buyers: <br> <br>");
				while (buyers.next()) {
					out.print(buyers.getString("user_display_name") + ": " + buyers.getInt("buys") + " buys");
				}
			}
			dbsesh.closeConnection(current);
		} catch (Exception e) {
			dbsesh.closeConnection(current);
			out.println(e);
		}
		%>
	</body>
</html>