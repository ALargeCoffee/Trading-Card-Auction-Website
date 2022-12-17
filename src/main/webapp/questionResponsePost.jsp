<%@ page import="project.pkg.*, java.sql.*, java.util.*" %>

<%
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement();
	try {
		if (request.getParameter("question") != null) {
			int quesID = 0;
			while (quesID == 0) {
				Random rd = new Random();
				while (quesID == 0) {
					quesID = rd.nextInt();
				}
				String query = "SELECT q.question FROM questionsAsksResponds q WHERE q.question_id = " + quesID + ";";
				ResultSet yo = check.executeQuery(query);
				if (yo.next()) {
					quesID = 0;
				}
			}
			String insert = "INSERT INTO questionsAsksResponds VALUES ('" + request.getParameter("question") + "',NULL,'" + session.getAttribute("user") + "',NULL," + quesID + ");";
			check.executeUpdate(insert);
		} else {
			String query = "SELECT q.response, q.question_id FROM questionsAsksResponds q WHERE q.response IS NULL";
			ResultSet yo = check.executeQuery(query);
			int responseNo = 0;
			while (yo.next()) {
				if (request.getParameter(Integer.toString(responseNo)) != null){
					String answer = request.getParameter(Integer.toString(responseNo));
					int quesID = yo.getInt("question_id");
					String update = "UPDATE questionsAsksResponds SET response ='" + answer + "', responder='" + session.getAttribute("user") + "' WHERE question_id =" + quesID + ";"; 
					check.executeUpdate(update);
					break;
				}
				responseNo++;
 			}
		}
		dbsesh.closeConnection(current);
		response.sendRedirect("qna.jsp");
	} catch (Exception e) {
		dbsesh.closeConnection(current);
		out.println(e);
	}
%>