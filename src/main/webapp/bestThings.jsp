<%@ page import="project.pkg.*, java.sql.*, java.lang.*" %>

<%
	String bestType = request.getParameter("type");
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	try {
		if (bestType.equals("items")) {
			String itemQuery = "SELECT i.card_name, i.bid_list FROM item i;";
			ResultSet items = check.executeQuery(itemQuery);
			String currBestSeller = new String();
			int bidNos = 0;
			while (items.next()) {
				int currBidNos = 0;
				// use bid_list to count the number of bids placed
				if (currBidNos > bidNos) {
					currBestSeller = items.getString("card_name");
					bidNos = currBidNos;
				}
			}
			
		} else { 
		}
		dbsesh.closeConnection(current);
		response.sendRedirect("adminPage.jsp");
	} catch (Exception e) {
		dbsesh.closeConnection(current);
		out.println(e);
	}
%>