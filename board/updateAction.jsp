<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bss.BssDAO" %>
<%@ page import="bss.Bss" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 </title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} 
		int bssID = 0;
		if (request.getParameter("bssID") != null) {
			bssID = Integer.parseInt(request.getParameter("bssID"));
		}
		if (bssID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bss.jsp'");
			script.println("</script>");
		}
		Bss bss = new BssDAO().getBss(bssID);
		if (!userID.equals(bss.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bss.jsp'");
			script.println("</script>");
		}else {
			if (request.getParameter("bssTitle") == null || request.getParameter("bssContent") == null
					|| request.getParameter("bssTitle").equals("") || request.getParameter("bssContent").equals("")) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
			} else {
				BssDAO bssDAO = new BssDAO();
				int result = bssDAO.update(bssID, request.getParameter("bssTitle"), request.getParameter("bssContent"));
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bss.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>