<%@ page language="java" contentType="text/html; charset=UTF-8" import="project.pkg.*, java.sql.*"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Auction Page</title>
</head>
<body>
	<!-- Links at the top of the page -->
	<a href="homePage.jsp" class="nav-link">Return</a>
	<!-- Show information for item selected by user -->
		<h1> Card Information </h1>
		<%  project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
			Connection current = dbsesh.getConnection();
			Statement check = current.createStatement();
			Statement check2 = current.createStatement();
			Integer enteredID = -1;
			if (session.getAttribute("enteredID") != null) {
				enteredID = (Integer) session.getAttribute("enteredID");
			} else {
				enteredID = Integer.parseInt(request.getParameter("item_id"));
				session.setAttribute("enteredID", enteredID);
			}
			// select all other attributes of item based on its ID
			// no bid list for now
			String query = "SELECT i.start_time, i.end_time, i.description, i.min_price, i.initial_price, i.category, i.card_name, i.auction_id, i.increments FROM item i WHERE i.auction_id =" + enteredID +";";
			try {
				ResultSet thisCard = check.executeQuery(query);
				ResultSet currPrice = check2.executeQuery("SELECT max(t1.bid_price) AS price FROM (SELECT b.bid_price, b.auction_id FROM buying b WHERE b.auction_id = " + enteredID + ") AS t1;");
				currPrice.next();
				thisCard.next();
				int price;
				if (currPrice.getInt("price") == 0) {
					price = thisCard.getInt("initial_price");
				} else {
					price = currPrice.getInt("price");
				}
				out.println("<p> Name: " + thisCard.getString("card_name") + " </p>"
						+ "<p> Description: " + thisCard.getString("description") + "</p>"
						+ "<p> Category: " + thisCard.getString("category") + "</p>"
						+ "<p> Auction started: " + thisCard.getString("start_time") + "</p>"
						+ "<p> Auction ends: " + thisCard.getString("end_time")+ "</p> <br>"
						+ "<p> Current price: $" + price + ".00 </p>"
						+ "<p> Minimum bid: $" + thisCard.getInt("increments") + ".00 over current price</p> <br> <h2> Default Bid: </h2>");
			} catch (Exception e) {
				dbsesh.closeConnection(current);
				out.println(e);
			} 
		%>
		<!-- Allow user to enter bid -->
		<form method="post" action="bidReader.jsp"> 
		  <input type="text" name="b1" placeholder="Enter your bid...">
		  <input type="submit" value="Submit Bid" />
		</form> <br> <br>
		<%
			if (session.getAttribute("invalidBid") != null) {
				out.print("Bid price invalid. Make sure it is above current bid and minimum bid increment.");
			}
		%>
		
		<!-- Allow auto bids -->
		<h2>Auto Bid:</h2>
		<form method="post" action="bidReader.jsp">
		  <p> Note: the upper limit is when you want autobids to stop placing. </p>
		  Auto bid amount: <input type="text" name="b1" placeholder="Enter your bid..."> <br> <br>
		  Upper limit: <input type="text" name="b2"> <br> <br>
		  <input type="submit" name = "b2" value="Submit Bid" />
		</form> <br> <br>
		<%
			if (session.getAttribute("invalidBid") != null) {
				out.print("Bid price invalid. Make sure it is above current bid and minimum bid increment.");
				session.removeAttribute("invalidBid");
			}
		%>
		
		<!-- Show bid history -->
		<h2>Bid History:</h2>
		<%
			ResultSet bids = check.executeQuery("SELECT b.user_display_name, b.bid_price FROM buying b WHERE b.auction_id = " + enteredID + " ORDER BY b.bid_price DESC");
			while (bids.next()) {
				out.print("<p>" + bids.getString("user_display_name") + ": $" + bids.getInt("bid_price") + ".00 </p>");
			}
			session.setAttribute("selectedID", enteredID);
			dbsesh.closeConnection(current);
		%>
		
</body>
</html>