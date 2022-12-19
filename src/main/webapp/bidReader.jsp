<%@ page import="project.pkg.*, java.sql.*, java.time.LocalDateTime" %>

<%
	// Fetch entered bid
	Integer bidVal = Integer.parseInt(request.getParameter("b1"));
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	Integer enteredID = (Integer) session.getAttribute("selectedID");
	try {
		LocalDateTime now = LocalDateTime.now();
		String temp = now.toString();
		String[] params = temp.split("T");
		ResultSet currPrice = check.executeQuery("SELECT max(t1.bid_price) AS price FROM (SELECT b.bid_price, b.auction_id FROM buying b WHERE b.auction_id = " + enteredID + ") AS t1;");
		currPrice.next();
		int base = currPrice.getInt("price");
		ResultSet incr = check.executeQuery("SELECT i.increments FROM item i WHERE i.auction_id = " + enteredID + ";");
		incr.next();
		int increment = incr.getInt("increments");
		int compare, compare2;
		if (request.getParameter("b2") == null) {
			compare = bidVal;
			compare2 = bidVal - base;
		} else {
			compare = base + bidVal;
			compare2 = bidVal;
		}
		if (compare >= base && compare2 >= increment) {
			if (request.getParameter("b2") == null) {
				int newPrice = bidVal;
				check.executeUpdate("INSERT INTO buying VALUES (" + newPrice + ",'" + params[0] + " " + params[1] + "', NULL, NULL, '" + session.getAttribute("user") + "', " + enteredID + ");");
			} else {
				int newPrice = bidVal + base;
				check.executeUpdate("INSERT INTO buying VALUES (" + newPrice + ",'" + params[0] + " " + params[1] + "'," + Integer.parseInt(request.getParameter("b2"))+ "," + bidVal + ", '" + session.getAttribute("user") + "', " + enteredID + ");");
				ResultSet upPrice = check.executeQuery("SELECT max(t1.bid_price) AS price FROM (SELECT b.bid_price, b.auction_id FROM buying b WHERE b.auction_id = " + enteredID + ") AS t1;");
				upPrice.next();
				int work = upPrice.getInt("price");
				ResultSet autoBidders = check.executeQuery("SELECT b.user_display_name, b.bid_price, b.autobid_upper_limit, b.autobid_increment FROM buying b WHERE b.autobid_upper_limit IS NOT NULL AND b.auction_id = " + enteredID + " ORDER BY autobid_upper_limit DESC;");
				autoBidders.next();
				int topAuto = autoBidders.getInt("autobid_upper_limit");
				String newTop = autoBidders.getString("user_display_name");
				int increase = autoBidders.getInt("autobid_increment");
				if (autoBidders.next()) {
					int nextAuto = autoBidders.getInt("autobid_upper_limit");
					while (work < nextAuto) {
						int change = work + increase;
						check.executeUpdate("INSERT INTO buying VALUES (" + change + ",'" + params[0] + " " + params[1] + "'," + topAuto + "," + increment + ", '" + newTop + "', " + enteredID + ");");
						work = change;
					}
				}
			}
		} else {
			session.setAttribute("invalidBid", true);
		}
		response.sendRedirect("auctionPage.jsp");
		dbsesh.closeConnection(current);
	}
	catch (Exception e) {
		dbsesh.closeConnection(current);
		out.print(e);
	}
%>