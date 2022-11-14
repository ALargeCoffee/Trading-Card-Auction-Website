<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title> Home </title>
	</head>
	<body>
		<h1> Welcome <%out.println(session.getAttribute("user"));%> </h1>
		<a href="logout.jsp">Log Out</a>
	</body>
</html>
	