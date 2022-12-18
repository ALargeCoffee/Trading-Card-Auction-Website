<%@ page import="project.pkg.*, java.sql.*, java.time.LocalDate, java.time.ZoneId" %>
<!DOCTYPE html>
 <html>
 <head> 
	<meta charset="utf-8">
	<title> Admin Tools </title>
 </head>
	<body>
		<!-- Links at the top of the page -->
		<a href="logout.jsp" class="nav-link">Logout</a>
		<a href="qna.jsp" class="nav-link">Q&amp;A</a>
		<% if (session.getAttribute("userType").equals("admin")) { %>
		<a href="adminPage.jsp" class="nav-link">Admin Tools</a>
		<% } %>
		<% if (session.getAttribute("userType").equals("customerRep")) { %>
		<a href="customerRepPage.jsp" class="nav-link">Customer Rep Tools</a>
		<% } %>
		
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
		%>! </h1>
		
		<!-- Search bar -->
		<form id="form"> 
		  <input type="search" id="query" name="q" placeholder="Search for cards...">
		  <button>Search</button>
		</form>
		
		<!-- Show items -->
		<h2> Items available for bidding </h2>
		<%  project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
			Connection current = dbsesh.getConnection();
			Statement check = current.createStatement();
			String query = "SELECT i.card_name, i.end_time, i.initial_price, i.description, i.auction_id FROM item i;";
			try {
				ResultSet prevCard = check.executeQuery(query);
				while (prevCard.next()) {
					LocalDate currentDate = LocalDate.now();
					if (currentDate.isBefore(prevCard.getDate("end_time").toLocalDate())) {
						Statement check2 = current.createStatement();
						String query2 = "SELECT max(t1.bid_price) AS price FROM (SELECT b.bid_price, b.auction_id FROM buying b WHERE b.auction_id = " + prevCard.getInt("auction_id") + ") AS t1;";
						ResultSet currPrice = check2.executeQuery(query2);
						currPrice.next();
						out.println("<p> Card name: " + prevCard.getString("card_name") + " </p>"
								+ "<p> Description: " + prevCard.getString("description") + "</p>"
								+ "<p> Current price: $" + currPrice.getInt("price") + ".00 </p>"
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
		
		<!-- Choose bid item -->
		<form id="form" action ="auctionPage.jsp", action ="bidReader.jsp"> 
		  <input type="search" id="query" name="item_id" placeholder="Enter ID of item to bid on...">
		  <input type="submit" onclick="location.href='auctionPage.jsp';" value="Go to Auction Page" />
		</form>
		
		
	</body>
</html>
	