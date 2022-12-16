<%@ page import="project.pkg.*, java.sql.*, java.util.*" %>

<%
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	try {
		if (response.getParameter("question") != null) {
			int quesID = 0;
			while (quesID == 0) {
				Random rd = new Random();
				quesID = rd.nextInt();
				String query = "SELECT q.question FROM questionsAsksResponds q WHERE q.question_id = " + quesID + ";";
				ResultSet yo = check.executeQuery(query);
				if (yo.next()) {
					quesID = 0;
				}
			}
			String insert = "INSERT INTO questionAsksResponds VALUES ('" + response.getParameter("question") + "',NULL,'" + session.getAttribute("user") + "',NULL," + quesID + ");";
			check.executeUpdate(insert);
		} else {
			
		}
		response.sendRedirect("qna.jsp");
	} catch (Exception e) {
		dbsesh.closeConnection(current);
		out.println(e);
	}
%>