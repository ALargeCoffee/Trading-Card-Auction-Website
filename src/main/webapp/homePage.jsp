<%@ page import="project.pkg.*, java.sql.*" %>
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
			String query = "SELECT i.end_time, i.initial_price, i.description, i.auction_id FROM item i;";
			try {
				ResultSet prevCard = check.executeQuery(query);
				while (prevCard.next()) {
					out.println("<p> Item: " + prevCard.getString("description") + 
							" | Starting price: $" +  prevCard.getString("initial_price") + ".00" + " | Bid ends: " 
							+ prevCard.getString("end_time")+ " | ID: " + prevCard.getString("auction_id") + "</p>");
				}
				dbsesh.closeConnection(current);
			} catch (Exception e) {
				dbsesh.closeConnection(current);
				out.println(e);
			}
		%>
		
		<!-- Choose bid item -->
		<form id="form"> 
		  <input type="search" id="query" name="q" placeholder="Enter ID of item to bid on...">
		  <input type="button" onclick="location.href='auctionPage.jsp';" value="Go to Auction Page" />
		</form>
		
		
		
	</body>
</html>
	