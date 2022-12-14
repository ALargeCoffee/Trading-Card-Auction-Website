<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title> Home </title>
	</head>
	<body>
		<!-- Links at the top of the page -->
		<% if (session.getAttribute("userType").equals("admin")) { %>
		<a href="adminPage.jsp">Admin Tools</a>
		<% } %>
		<% if (session.getAttribute("userType").equals("customerRep")) { %>
		<a href="customerRepPage.jsp">Customer Rep Tools</a>
		<% } %>
		<a href="logout.jsp">Log Out</a>
		
		<!-- Main body -->
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
	</body>
</html>
	