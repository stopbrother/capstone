<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Vector" %>
<%@ page import="recipe.RecipeDAO" %>
<%@ page import="recipe.Recipe" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width"; initial-scale="1">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">
<title>나 혼자 요리</title>
</head>
<body>
	<% 
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		RecipeDAO rdao = new RecipeDAO();
		Vector<Recipe> v = rdao.getSelectFood();
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="../JOY/main.jsp">나혼자요리</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="../JOY/main.jsp">메인</a></li>
				<li><a href="../file/recipe.jsp">레시피</a></li>
				<li><a href="bss.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>사이트 소개</h1>
				<p>요리레시피</p>
				<p><a class="btn btn-primary btn-pull" href="#" role="button">더 보기</a></p>
			</div>
		</div>
	</div>
			
			
			<section class="container">
				<form method="get" action="./main.jsp" class="form-inline mt-3">
					<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요">
					<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
				</form>
				
				<table width="1000">
				<tr height="240">
				<% 
					for(int i=0; i< v.size(); i++){
						Recipe bean = v.get(i);
				%>
				<td width="333" align="center">
				<a href="recipe.jsp?center=recipeInfo.jsp?foodNum=<%=bean.getFoodNum() %>">
				<img alt="" src="images/<%=bean.getFoodImg() %>" width="300" height="220">
				</a>
				<p>음식명 : <%=bean.getFoodName() %></p>
				</td>
				<%
					}
				%>
			</table>
			</section>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>