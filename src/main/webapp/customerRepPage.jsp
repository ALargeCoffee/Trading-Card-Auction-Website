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
		
		<!-- Remove bids -->
		<h2> Remove bids: </h2>
		<form method="post" action="removeBid.jsp">
			<p> To remove a specific bid, input the auction ID as well as the bid number displayed on the item page and click submit: </p>
			Auction ID: <input type="text" name="auctionID"> <br> <br>
			Bid Number: <input type="text" name="bidID"> <br> <br>
			<input type="submit" value="Submit"> <br> <br>
		</form>
		
		<!-- Remove auctions -->
		<h2> Remove auctions: </h2>
		<form method="post" action="removeAuction.jsp">
			<p> Please enter the auction ID and click submit to remove it: </p>
			<input type="text" name="auctionID"> <br> <br>
			<input type="submit" value="Submit">
		</form>
	</body>
</html>