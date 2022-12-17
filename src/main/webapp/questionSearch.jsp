<%@ page import="project.pkg.*, java.sql.*, java.util.*" %>

<%
	project.pkg.DBConnect dbsesh = new project.pkg.DBConnect();
	Connection current = dbsesh.getConnection();
	Statement check = current.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	String query = "SELECT q.question, q.question_id FROM questionsAsksResponds q;";
	ResultSet questions = check.executeQuery(query);
	String search = request.getParameter("search");
	String[] words = search.split(" ");
	HashMap<Integer, Integer> frequency = new HashMap<Integer, Integer>();
	for (String curr : words) {
		while (questions.next()) {
			if (questions.getString("question").contains(curr)) {
				if (frequency.containsKey(questions.getInt("question_id"))) {
					frequency.put(questions.getInt("question_id"), frequency.get(questions.getInt("question_id")) + 1);
				} else {
					frequency.put(questions.getInt("question_id"), 1);
				}
			}
		}
		questions.beforeFirst();
	}
	Integer[] questionSort = new Integer[frequency.size()];
	while (questions.next()) {
		if (frequency.containsKey(questions.getInt("question_id"))) {
			int pointer = 0;
			while (questionSort[pointer] != null && pointer < questionSort.length) {
				if (frequency.get(questionSort[pointer]) < frequency.get(questions.getInt("question_id"))) {
					int temp = questionSort[pointer];
					int fixer = pointer + 1;
					while (fixer < questionSort.length && questionSort[fixer] != null) {
						int temp2 = questionSort[fixer];
						questionSort[fixer] = temp;
						temp = temp2;
						fixer++;
					}
					questionSort[pointer] = questions.getInt("question_id");
					questionSort[fixer] = temp;
					break;
				}
				pointer++;
			}
			if (questionSort[pointer] == null) {
				questionSort[pointer] = questions.getInt("question_id");
			}
		}
	}
	session.setAttribute("order", questionSort);
	dbsesh.closeConnection(current);
	response.sendRedirect("qna.jsp");
%>