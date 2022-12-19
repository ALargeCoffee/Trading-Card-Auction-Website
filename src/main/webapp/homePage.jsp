<%@ page import="project.pkg.*, java.sql.*, java.time.LocalDate" %>
<!DOCTYPE html>
 <html>
 <head> 
	<meta charset="utf-8">
	<title> Home </title>
 </head>
	<body>
		<!-- Links at the top of the page -->
		<% if (session.getAttribute("userType").equals("admin")) { %>
		<a href="adminPage.jsp" class="nav-link"> Admin Tools </a> &nbsp;
		<% } %>
		<% if (session.getAttribute("userType").equals("customerRep")) { %>
		<a href="customerRepPage.jsp" class="nav-link"> Customer Rep Tools </a> &nbsp;
		<% } %>
		<a href="auctionForm.jsp"> Post Auction </a> &nbsp;
		<a href="auctionHistory.jsp"> Auction History </a> &nbsp;
		<a href="qna.jsp" class="nav-link"> Q&amp;A </a> &nbsp;
		<a href="logout.jsp" class="nav-link"> Logout </a>
		
		<!-- Main body -->
		<h1> Welcome 
		<%
			if (session.getAttribute("userType").equals("admin")) {
				out.println(session.getAttribute("user") + " (Administrator)");
			} else if (session.getAttribute("userType").equals("customerRep")) {
				out.println(session.getAttribute("user") + " (Customer Representative)");
			} else {
				out.println(session.getAttribute("user"));
			}
			if (session.getAttribute("enteredID") != null) {
				session.removeAttribute("enteredID");
			}
		%>! </h1>
		
		<!-- Show items -->
		<h2> Items Available for Bidding </h2>
		<!-- Choose bid item -->
		<p>To view an item, please insert its listed auction ID into the following form and click submit:</p>
		<form id="form" action ="auctionPage.jsp", action ="bidReader.jsp"> 
		  <input type="search" id="query" name="item_id" placeholder="Enter ID of item to bid on...">
		  <input type="submit" onclick="location.href='auctionPage.jsp';" value="Go to Auction Page" />
		</form> <br> <br>
		
		<!-- Sort -->
		Sort by:
		<form method="get" action="sort.jsp">
			<input type="radio" name = "command" value="category"> Category <input type="radio" name = "command" value="plh"> Price (low to high)  <input type="radio" name = "command" value="phl"> Price (high to low) &nbsp; <input type="submit" value="Sort"> 
		</form> <br>
		
		<!-- Show items -->
		<%  project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
			Connection current = dbsesh.getConnection();
			Statement check = current.createStatement();
			String query = "SELECT i.card_name, i.end_time, i.initial_price, i.description, i.auction_id, i.category, i.initial_price FROM item i;";
			try {
				ResultSet prevCard;
				if (session.getAttribute("order") != null) {
					prevCard = (ResultSet) session.getAttribute("order");
					session.removeAttribute("order");
				} else {
					prevCard = check.executeQuery(query);
				}
				while (prevCard.next()) {
					LocalDate currentDate = LocalDate.now();
					if (currentDate.isBefore(prevCard.getDate("end_time").toLocalDate())) {
						Statement check2 = current.createStatement();
						String query2 = "SELECT max(t1.bid_price) AS price FROM (SELECT b.bid_price, b.auction_id FROM buying b WHERE b.auction_id = " + prevCard.getInt("auction_id") + ") AS t1;";
						ResultSet currPrice = check2.executeQuery(query2);
						currPrice.next();
						int price = -1;
						if (currPrice.getInt("price") != 0) {
							price = currPrice.getInt("price");
						} else {
							price = prevCard.getInt("initial_price");
						}
						currPrice.next();
						String cat = prevCard.getString("category");
						String category = cat.substring(0,1).toUpperCase() + cat.substring(1);
						out.println("<p> Card name: " + prevCard.getString("card_name") + " </p>"
								+ "<p> Description: " + prevCard.getString("description") + "</p>"
								+ "<p> Category: " + category + "</p>"
								+ "<p> Current price: $" + price + ".00 </p>"
								+ "<p> Auction ends: " + prevCard.getString("end_time")+ "</p>"
								+ "<p> Auction ID: " + prevCard.getString("auction_id") + "</p> <br> <br>");
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
	