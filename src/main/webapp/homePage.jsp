<!DOCTYPE html>
 <html>
 <head> 
	<meta charset="utf-8">
	<title> Admin Tools </title>
 </head>
	<body>
		<!-- Links at the top of the page -->
		<a href="logout.jsp" class="nav-link">Logout</a>
		<% if (session.getAttribute("userType").equals("admin")) { %>
		<a href="adminPage.jsp" class="nav-link">Admin Tools</a>
		<% } %>
		<% if (session.getAttribute("userType").equals("customerRep")) { %>
		<a href="customerRepPage.jsp" class="nav-link">Customer Rep Tools</a>
		<% } %>
		
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
		%>! </h1>
	</body>
</html>
	