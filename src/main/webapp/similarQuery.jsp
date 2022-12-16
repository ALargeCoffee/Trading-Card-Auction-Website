<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="project.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
			Connection current = dbsesh.getConnection();	
			
			//Create a SQL statement
			Statement stmt = current.createStatement();
			//Get the combobox from the index.jsp
			String entity = request.getParameter("description");
			//Make a SELECT query from the item table with a similar description  to the chosen entity
			String str = "SELECT * FROM sells WHERE description like " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("auction_id");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("min_price");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("description");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out auction_id:
				out.print(result.getString("auction_id"));
				out.print("</td>");
				out.print("<td>");
				//Print out current minimum price:
				out.print(result.getString("min_price"));
				out.print("</td>");
				out.print("<td>");
				//Print out description
				out.print(result.getString("description"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			current.close();

		} catch (Exception e) {
		}
	%>

</body>
</html>