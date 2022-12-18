<%@ page import="project.pkg.*, java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title> Post An Auction </title>
	</head>
	<body>
		<!-- Links -->
		<a href="homePage.jsp">Return</a>
		
		<!-- Main body -->
		<h1>Auction Post Form</h1>
		<p>To post an auction, properly fill out the form below and click submit: </p>
		<form method="post" action="auctionPost.jsp">
			Card name (enter person/character name): <input type="text" name="cardName"> <br> <br>
			Description: <input type="text" name="description"> <br> <br>
			Starting price: <input type="text" name="startPrice"> <br> <br>
			Minimum bid increment: <input type="text" name="increment"> <br> <br>
			Minimum sell price you are willing to accept: <input type="text" name="minPrice"> <br> <br>
			End date (please follow "YYYY-MM-DD" format): <input type="text" name="endDate"> <br> <br>
			Category: <br> <br>
			<input type="radio" name="category" value="game"> Game card <br> <br>
			<input type="radio" name="category" value="movie"> Movie card <br> <br>
			<input type="radio" name="category" value="sport"> Sport card <br> <br>
			<input type="submit" value="Post">
		</form>
	</body>
</html>