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
		<h2> Admin Tools </h2>
		<p> Create a customer representative account: </p>
		<form method="post" action="registration.jsp">
		Username: <input type="text" name="username">
		<br><br>
		Password: <input type="text" name="password">
		<br><br>
		Representative ID: <input type="text" name="repID">
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
		<br> <br> 
		<p> Generate a sales report: </p>
	</body>
</html>