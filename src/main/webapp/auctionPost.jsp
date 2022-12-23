<%@ page import="project.pkg.*, java.sql.*, java.util.*, java.time.LocalDate" %>

<%
	String cardName = request.getParameter("cardName");
	String description = request.getParameter("description");
	int startPrice = Integer.parseInt(request.getParameter("startPrice"));
	int increment = Integer.parseInt(request.getParameter("increment"));
	int minPrice = Integer.parseInt(request.getParameter("minPrice"));
	String endDate = request.getParameter("endDate");
	String category = request.getParameter("category");
	int auctionID = -1;
	Random rd = new Random();
	while (auctionID <= 0) {
		auctionID = rd.nextInt();
	}
	LocalDate curr = LocalDate.now();
	String startDate = curr.toString();
	if (curr.isBefore(LocalDate.parse(endDate))) {
		project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
		Connection current = dbsesh.getConnection();
		Statement check = current.createStatement();
		check.executeUpdate("INSERT INTO item VALUES ('"+ startDate + "','" + endDate + "','" + description + "'," + minPrice + "," + startPrice + "," + increment + "," + auctionID + ",'" + category + "','" + cardName + "');");
		check.executeUpdate("INSERT INTO selling VALUES ('" + session.getAttribute("user") + "', " + auctionID + ", false);");
		dbsesh.closeConnection(current);
		response.sendRedirect("homePage.jsp");
	} else {
		session.setAttribute("invalidEndTime", true);
		response.sendRedirect("auctionForm.jsp");
	}
%>
