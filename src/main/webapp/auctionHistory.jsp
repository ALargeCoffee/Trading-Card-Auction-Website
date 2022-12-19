<%@ page import="project.pkg.*, java.sql.*, java.time.LocalDate" %>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="utf-8">
		<title> Auction History </title>
	</head>
	<body>
		<!-- Links -->
		<a href="homePage.jsp">Home</a> &nbsp;
		<a href="qna.jsp"> Q&amp;A </a> &nbsp;
		<a href="logout.jsp">Logout</a>
		
		<!-- Body -->
		<h1>Closed Auctions:</h1>
		<%
			project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
			Connection current = dbsesh.getConnection();
			Statement check = current.createStatement();
			try {
				ResultSet prevCard = check.executeQuery("SELECT i.card_name, i.end_time, i.description, i.auction_id FROM item i;");
				while (prevCard.next()) {
					LocalDate currentDate = LocalDate.now();
					if (currentDate.isAfter(prevCard.getDate("end_time").toLocalDate())) {
						Statement check2 = current.createStatement();
						ResultSet metMin = check2.executeQuery("SELECT i.min_price FROM item i WHERE i.auction_id = " + prevCard.getInt("auction_id") + ";");
						metMin.next();
						int minPrice = metMin.getInt("min_price");
						String query2 = "SELECT t1.user_display_name, max(t1.bid_price) AS price FROM (SELECT b.user_display_name, b.bid_price, b.auction_id FROM buying b WHERE b.auction_id = " + prevCard.getInt("auction_id") + ") AS t1;";
						ResultSet currPrice = check2.executeQuery(query2);
						currPrice.next();
						int yo = currPrice.getInt("price");
						String user = new String();
						if (currPrice.getInt("price") >= minPrice) {
							user = currPrice.getString("user_display_name");
						} else {
							user = "Nobody (min price not met)";
						}
						ResultSet seller = check2.executeQuery("SELECT s.user_display_name FROM selling s WHERE s.auction_id = " + prevCard.getInt("auction_id") + ";");
						seller.next();
						out.println("<p> Card name: " + prevCard.getString("card_name") + " </p>"
								+ "<p> Description: " + prevCard.getString("description") + "</p>"
								+ "<p> Ending bid: $" + yo + ".00 </p>"
								+ "<p> Sold by: " + seller.getString("user_display_name") + " </p>"
								+ "<p> Sold to: " + user + "</p> <br> <br>");
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