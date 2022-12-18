<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title> Customer Rep Tools </title>
	</head>
	<body>
		<!-- Links at top -->
		<a href="homePage.jsp">Home</a>
		
		<!-- Main body -->
		<h1>Customer Representative Tools</h1>
		
		<!-- Edit account info -->
		<h2> Change account info: </h2>
		<form method="post" action="accountInfo.jsp">
			<p> Please insert the username of the account you'd like to change: </p>
			<input type="text" name="username"> <br> <br>
			
			<p> Insert the updated value into the fields that you wish to change and click submit: </p>
			Username: <input type="text" name="newUsername"> <br> <br>
			Password: <input type="text" name="password"> <br> <br>
			Phone Number: <input type="text" name="number"> <br> <br>
			Email: <input type="text" name="email"> <br> <br>
			<input type="submit" value="Submit"> <br> <br>
		</form>
		<%
			if (session.getAttribute("invalidUser") != null) {
				out.println("The new username matches one in our records. Please pick a different username and try again.");
				session.removeAttribute("invalidUser");
			}
		%>
		
		<!-- Remove bids -->
		<h2> Remove bids: </h2>
		<form method="post" action="removeBid.jsp">
			<p> To remove a specific bid, input the auction ID as well as the price of the bid displayed in the bid history and click submit: </p>
			Auction ID: <input type="text" name="auctionID"> <br> <br>
			Bid Price: <input type="text" name="bidPrice"> <br> <br>
			<input type="submit" value="Submit"> <br> <br>
		</form>
		<%
			if (session.getAttribute("invalidBid") != null) {
				out.println("The fields entered do not match any bids in our records. Please check your numbers and try again.");
				session.removeAttribute("invalidBid");
			}
		%>
		
		<!-- Remove auctions -->
		<h2> Remove auctions: </h2>
		<form method="post" action="removeAuction.jsp">
			<p> Please enter the auction ID and click submit to remove it: </p>
			<input type="text" name="auctionID"> <br> <br>
			<input type="submit" value="Submit"> <br> <br>
		</form>
		<%
			if (session.getAttribute("invalidAuction") != null) {
				out.println("The auction ID entered does not match any auction in our records. Please check your number and try again.");
				session.removeAttribute("invalidAuction");
			}
		%>
	</body>
</html>