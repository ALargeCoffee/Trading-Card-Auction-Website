<%@ page import="project.pkg.*, java.sql.*" %>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="utf-8">
		<title> Q&A </title>
	</head>
	<body>
		<!-- Links at top of page -->
		<a href="homePage.jsp">Home</a>
		<a href="logout.jsp">Logout</a>
		
		<!-- Main body -->
		<h1> Questions and Answers </h1>
		<p> Have any questions relating to items, accounts, or the site in general? Post below or scroll through previously asked questions! </p>
		<form method="post" action="questionResponsePost.jsp">
			<input type="text" name = "question" size="100">
			<input type="submit" value="Post">
		</form>
		<br> <br>
		<h2>Previously asked questions:</h2>
		<form method="post" action="questionSearch.jsp">
			<input type="text" name="search" size="100"> <input type="submit" value="Search">
		</form> <br>
		<%
			project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
			Connection current = dbsesh.getConnection();
			Statement check = current.createStatement();
			try {
				String query = new String();
				if (session.getAttribute("order") != null) {
					Integer[] order = (Integer[]) session.getAttribute("order");
					int responseCount = 0;
					for (int i = 0; i < order.length; i++) {
						query = "SELECT * FROM questionsAsksResponds q WHERE q.question_id = '" + order[i] + "';";
						ResultSet currQues = check.executeQuery(query);
						currQues.next();
						out.println("<p> Question asked by " + currQues.getString("asker") + ": " + currQues.getString("question") + "</p>");
						if (currQues.getString("response") != null) {
							out.println("<p> Answered by " + currQues.getString("responder") + ": " + currQues.getString("response") + "</p><br><br>");
						} else {
							if (session.getAttribute("userType").equals("customerRep")) {
								out.println("<form method='post' action='questionResponsePost.jsp'> Post a response: <input type='text' name='" + responseCount + "' size='100'> <input type='submit' value='Post'></form> <br> <br>");
								responseCount++;
							} else {
								out.println("<p>This question is currently unanswered. Check back soon to see a response from one of our customer representatives!</p><br><br>");
							}
						}
					}
					session.removeAttribute("order");
				} else {
					query = "SELECT q.question, q.response, q.asker, q.responder FROM questionsAsksResponds q;";
					ResultSet prevQues = check.executeQuery(query);
					int responseCount = 0;
					while (prevQues.next()) {
						out.println("<p> Question asked by " + prevQues.getString("asker") + ": " + prevQues.getString("question") + "</p>");
						if (prevQues.getString("response") != null) {
							out.println("<p> Answered by " + prevQues.getString("responder") + ": " + prevQues.getString("response") + "</p><br><br>");
						} else {
							if (session.getAttribute("userType").equals("customerRep")) {
								out.println("<form method='post' action='questionResponsePost.jsp'> Post a response: <input type='text' name='" + responseCount + "' size='100'> <input type='submit' value='Post'></form> <br> <br>");
								responseCount++;
							} else {
								out.println("<p>This question is currently unanswered. Check back soon to see a response from one of our customer representatives!</p><br><br>");
							}
						}
					}
				}
				dbsesh.closeConnection(current);
			} catch (Exception e) {
				dbsesh.closeConnection(current);
				out.println(e);
			}
		%>
	</body>
</html>