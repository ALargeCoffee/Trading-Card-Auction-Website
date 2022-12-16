<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title> Admin Tools </title>
	</head>
	<body>
		<!-- Links at the top of the page and vital code -->
		<%
			session.setAttribute("cusRepReg", "true");
		%>
		<a href="homePage.jsp">Home</a>
		
		<!-- Main body -->
		<h1> Admin Tools </h1>
		
		<!-- Customer rep account creation -->
		<h2> Create a customer representative account: </h2>
		<form method="post" action="registration.jsp">
		Username: <input type="text" name="username">
		<br><br>
		Password: <input type="text" name="password">
		<br><br>
		Phone Number: <input type="text" name="number">
		<br><br>
		Email: <input type="text" name="email">
		<br><br>
		<input type="submit" value="Create">
		</form>
		<br>
		<%
		if (session.getAttribute("invalidRegister") != null) {
			out.println("A user with this username already exists. Please pick a different username.");
			session.removeAttribute("invalidRegister");
		}
		%>
		<br>
		
		<!-- Sales reports -->
		<h2> Generate sales reports: </h2>
		<form method = "get" action="totalEarnings.jsp">
			Total Site Earnings: <input type="submit" value="Display">
		</form>
		<%
			if (session.getAttribute("totEarn") != null) {
				out.println(session.getAttribute("totEarn"));
				session.removeAttribute("totEarn");
			}
		%>
		<br>
		Calculate sales reports for:
		<br> <br>
		<form method = "get" action="earningsReport.jsp">
			<input type="radio" name="type" value="cards"> Each card
			<br> <br>
			<input type="radio" name="type" value="cardTypes"> Each card type
			<br> <br>
			<input type="radio" name="type" value="users"> Each user
			<br> <br>
			<input type="submit" value="Submit">
		</form>
		<br> <br>
		
		<!-- Best selling items/best buyers -->
		<h2> Identify best-selling items and best buyers </h2>
		<form method="get" action="bestThings.jsp">
			<input type="radio" name="type" value="items"> Best-selling items
			<br> <br>
			<input type="radio" name="type" value="buyers"> Best buyers
			<br> <br>
			<input type="submit" value="Submit">
		</form>
	</body>
</html>