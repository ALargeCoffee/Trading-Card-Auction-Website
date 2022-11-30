<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title> Home </title>
	</head>
	<body>
		<h1> Welcome 
		<%
			if (session.getAttribute("userType").equals("admin")) {
				out.println(session.getAttribute("user") + " (Administrator)");
			} else if (session.getAttribute("userType").equals("customerRep")) {
				out.println(session.getAttribute("user") + " (Customer Representative)");
			} else {
				out.println(session.getAttribute("user"));
			}
		%> </h1>
		
		<!-- The following section only executes for admins and customer reps -->
		<% if (session.getAttribute("userType").equals("admin")) { %>
			<h2> Admin Commands </h2>
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
		<% } session.setAttribute("cusRepReg", "true"); %>
		
		<br> <br>
		<a href="logout.jsp">Log Out</a>
	</body>
</html>
	