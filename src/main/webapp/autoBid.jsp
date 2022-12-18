<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="project.pkg.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 1. get entered bid  -->
<!-- 2. compare it to max bid_price in buying table  -->
<!-- 3. increase entered bid by increment value until it is larger than max bid  -->
<%  project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement(); 
	Integer bidVal = Integer.parseInt(request.getParameter("b1"));
	try {
		ResultSet userQuery = check.executeQuery("SELECT MAX(bid_price), i.increments FROM buying b JOIN item ON b.auction_id = i.auction_id WHERE b.auction_id = entered_id GROUP BY b.auction_id");
		userQuery.next();
		if (bidVal < Integer.parseInt(userQuery.getString("MAX(bid_price)"))) {
			// increment user's bid
			while(bidVal < Integer.parseInt(userQuery.getString("MAX(bid_price)")))
			{
				bidVal += Integer.parseInt(userQuery.getString("increments"));
			}
		}
		else {
			// the user's bid is sufficiently large in this case. do nothing
			return;
		}
		response.sendRedirect("auctionPage.jsp");
		dbsesh.closeConnection(current);
	}
	catch (Exception e) {
		out.print(e);
	}
%>

</body>
</html>