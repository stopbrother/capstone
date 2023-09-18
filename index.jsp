<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="guestbook.GuestBookDAO"%>
<%@page import="guestbook.GuestBookDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>


<%
    List<GuestBookDTO> list = new ArrayList<GuestBookDTO>();
    GuestBookDAO dao = new GuestBookDAO();

    list = dao.getList();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="/guestbook/add.jsp" method="post">
    <table border="1" width="500">
        <tr>
            <td>이름</td><td><input type="text" name="name"></td>
            <td>비밀번호</td><td><input type="password" name="pwd"></td>
        </tr>
        <tr>
            <td colspan=4><textarea name="content" cols=60 rows=5></textarea></td>
        </tr>
        <tr>
            <td colspan=4 align=right><input type="submit" VALUE=" 확인 "></td>
        </tr>
    </table>
</form>
<br>
    <% if(list != null){
        for(GuestBookDTO dto : list){ %>
        <table width="510" border="1">
            <tr>
                <td><%= dto.getNo() %></td>
                <td><%= dto.getName() %></td>
                <td><%= dto.getRegDate() %></td>
                <td><a href="/guestbook/deleteform.jsp?no=<%= dto.getNo() %>">삭제</a></td>
            </tr>
            <tr>
                <td><%= dto.getContent() %></td>
            </tr>
        </table>
        <br>
        <% } %>
    <% } %>
</body>
</html>