<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="guestbook.GuestBookDAO"%>
<%@page import="guestbook.GuestBookDTO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    
    String name = request.getParameter("name");
    String pwd = request.getParameter("pwd");
    String content = request.getParameter("content");
    
    GuestBookDTO dto = new GuestBookDTO();
    
    dto.setName(name);
    dto.setPwd(pwd);
    dto.setContent(content);
    
    GuestBookDAO dao = new GuestBookDAO();
    dao.insert(dto);
    
    
    response.sendRedirect("/guestbook");
%>
</body>
</html>