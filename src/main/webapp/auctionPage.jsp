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
	<a href="logout.jsp" class="nav-link">Logout</a>
	<a href="qna.jsp" class="nav-link">Q&amp;A</a>
	<!-- Show information for item selected by user -->
		<h1> Item information </h1>
		<%  project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
			Connection current = dbsesh.getConnection();
			Statement check = current.createStatement();
			Integer enteredID = Integer.parseInt(request.getParameter("item_id"));
			// select all other attributes of item based on its ID
			// no bid list for now
			String query = "SELECT i.start_time, i.end_time, i.description, i.min_price, i.initial_price, i.category, i.card_name, i.auction_id FROM item i WHERE i.auction_id =" + enteredID +";";
			try {
				ResultSet thisCard = check.executeQuery(query);
				thisCard.next();
				out.println("<p> Card name: " + thisCard.getString("card_name") + " </p>"
						+ "<p> Description: " + thisCard.getString("description") + "</p>"
						+ "<p> Starting price: $" + thisCard.getString("initial_price") + ".00 </p>"
						+ "<p> Minimum price: $" + thisCard.getString("min_price") + ".00 </p>"
						+ "<p> Auction started: " + thisCard.getString("start_time") + "</p>"
						+ "<p> Auction ends: " + thisCard.getString("end_time")+ "</p>"
						+ "<p> Auction ID: " + thisCard.getString("auction_id") + "</p>"
						+ "<p> Category: " + thisCard.getString("category") + "</p> <br> <br>");
			} catch (Exception e) {
				dbsesh.closeConnection(current);
				out.println(e);
			} 
		%>
		<!-- Allow user to enter bid -->
		<form id="form" method="GET"> 
		  <input type="search" id="bid" name="b" placeholder="Enter your bid...">
		  <input type="submit" value="Submit Bid" />
		</form>
		
		<!-- Show the user's current bid -->
		<%
			if (request.getParameter("bid") != null)
			{
				out.println("<p> Current bid: $" + request.getParameter("bid") + ".00 </p>");
			}
		out.println("<p> $0.00 </p>");
		%>
		
</body>
</html>