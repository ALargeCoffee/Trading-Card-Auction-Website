<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title> Login Form </title>
	</head>
	<body>
		<h1> BuyMe Trading Card Auctions </h1>
		
		<!-- This section is for logging in -->
		<p> Please login below or register an account to continue to the website: </p>
		<form method="post" action="loginReader.jsp">
			Username: <input type="text" name="username">
			Password: <input type="text" name="password">
			<input type="submit" value="Login">
		</form>
		<%
		if (session.getAttribute("invalidLogin").equals("true")) {
			out.println("Invalid login credentials. Please try again or register below.");
			session.removeAttribute("invalidLogin");
		}
		%>
		
		<!-- This section is for registering -->
		
	</body>
</html>