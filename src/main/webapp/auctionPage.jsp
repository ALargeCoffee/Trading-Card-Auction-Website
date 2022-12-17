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
			Integer enteredID = Integer.parseInt(request.getParameter("q"));
			// select all other attributes of item based on its ID
			// no bid list for now
			String query = "SELECT i.start_time, i.end_time, i.description, i.min_price, i.initial_price, i.category, i.card_name FROM item i WHERE i.auction_id =" + enteredID +";";
			try {
				ResultSet thisCard = check.executeQuery(query);
				thisCard.next();
				out.println("<p> Description: " + thisCard.getString("description") + "</p>"
							+ "<p> Auction started: " + thisCard.getString("start_time") + "</p>"
							+ "<p> Auction will end: " + thisCard.getString("end_time") + "</p>"
							+ "<p> Initial price: " + thisCard.getString("initial_price") + "</p>"
							+ "<p> Minimum price: " + thisCard.getString("min_price") + "</p>"
							+ "<p> Card name: " + thisCard.getString("card_name") + "</p>"
							+ "<p> Category: " + thisCard.getString("category") + "</p>");
			} catch (Exception e) {
				dbsesh.closeConnection(current);
				out.println(e);
			} 
			
			
		%>
</body>
</html>