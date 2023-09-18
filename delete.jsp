<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="guestbook.GuestBookDAO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    Integer no = Integer.parseInt(request.getParameter("no"));
    String Inputpwd = request.getParameter("pwd");
    
    GuestBookDAO dao = new GuestBookDAO();
    String dbPwd = dao.getPwd(no);
    String parseInputPwd = dao.getInputPwd(Inputpwd);
    
    if( dbPwd.equals(parseInputPwd)){
        dao.delete(no);
    }
    response.sendRedirect("/guestbook");
%>
</body>
</html>