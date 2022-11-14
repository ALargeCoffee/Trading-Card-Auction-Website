<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title> Login Form </title>
	</head>
	<body>
		<h1> BuyMe Trading Card Auctions </h1>
		
		<!-- This section is for logging in -->
		<p> Please login below to continue to the website: </p>
		<form method="post" action="loginReader.jsp">
			Username: <input type="text" name="username">
			<br><br>
			Password: <input type="text" name="password">
			<input type="submit" value="Login">
		</form>
		<%
		if (session.getAttribute("invalidLogin") != null) {
			out.println("Invalid login credentials. Please try again or register below.");
			session.removeAttribute("invalidLogin");
		}
		%>
		<br><br><br><br>
		
		<!-- This section is for registering -->
		<p> If you do not have an account yet, register below: </p>
		<form method="post" action="registration.jsp">
			Username: <input type="text" name="username">
			<br><br>
			Password: <input type="text" name="password">
			<input type="submit" value="Register">
		</form>
	</body>
</html>