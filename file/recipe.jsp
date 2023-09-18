<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="file.FileDAO" %>
<%@ page import="file.FileDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>


<jsp:useBean id="dao" class="file.FileDAO" />


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1,maximum-scale=1,user-scalable=no">
    <meta charset="UTF-8">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/toggle.min.js"></script>
    <script src="http://code.jquery-1.7.js" type="text/javascript"></script>
    <script src="../js/send.js"></script>
<link rel="stylesheet" href="../css/recipe.css">
<link rel="stylesheet" href="../css/base.css">
<title>나 혼자 요리-레시피</title>
<style>
	.box h4 {
		font-weight: bold;
		
	}
</style>
<script type="text/javascript">
	function detailcheck(foodNum) {
	
		// 상세조회 페이지 이동
		document.form1.action.value="detail";
		document.form1.foodNum.value=foodNum;
		document.form1.submit();
	}

		
		function searchCheck(){
			if(search.keyWord.value == ""){
				alert("검색 단어를 입력하세요.");
				search.keyWord.focus();
				return;
			}
			search.submit();
		}
		function logout(){
			alert('로그아웃이 완료되었습니다.')
		}
</script>
</head>
<body>
<% 
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
}
%>
	<div id="wrap">
		<div class="gnb">
			<div class="gnb_top">
					<h1>
						<a href="../JOY/main.jsp">
							<img src="../img/logo_1.png" alt="로고">
						</a>
					</h1>
				<%
					if(userID == null) {
				%>
				<ul class="gnb_right">
					<li>
						<a href="../user/login.jsp">
							<img src="../img/user.png" alt="로그인">
						</a>
					</li>
					<li>
                		<a href="../board/bss.jsp">
                    		<img src="../img/add.png" alt="게시글작성">
                		</a>
            		</li>
            		<li>
						<a href="../user/login.jsp">
							<img src="../img/user_pc.png" alt="로그인">
						</a>
					</li>
					<li>
                		<a href="../board/bss.jsp">
                    		<img src="../img/add_pc.png" alt="게시글작성">
                		</a>
            		</li>
        		</ul>
				<%
					} else {
				%>
				<ul class="gnb_right">
					<li>
						<a href="../user/logoutAction.jsp" onclick="javascript:logout()">
							<img src="../img/user_M.png" alt="로그아웃">
						</a>
					</li>
					 <li>
                		<a href="../board/bss.jsp">
                    		<img src="../img/add.png" alt="게시글작성">
                		</a>
            		</li>
					<p>${userID}님 환영합니다.</p>
            		<li>
						<a href="../user/logoutAction.jsp" onclick="javascript:logout()">
							<img src="../img/userin_pc.png" alt="로그아웃">
						</a>
					</li>
					 <li>
              			<a href="../board/bss.jsp">
                    		<img src="../img/add_pc.png" alt="게시글작성">
               		 	</a>
            		</li>
        		</ul>
        		</div>
			<div class="dd">
        		<h2>${userID}님 환영합니다.</h2>
        		<%
					}
        		%>
        		</div>

        <nav> 
            <ul class="gnb_nav_bar">
                <li>
                	<a href="../JOY/main.jsp">홈</a>
                </li>
                 <li>
                	<a href="../JOY/introduce.jsp">소개</a>
                </li>
                <li>
                	<a href="recipe.jsp" class="active_1">레시피</a>
                </li>
                <li>
                	<a href="../board/bss.jsp">게시판</a>
                </li>
            </ul>
        </nav>
        <span class="toggle_btn">전체메뉴 토글버튼</span>
        </div>
        
<% 
	request.setCharacterEncoding("UTF-8");
	String keyWord = request.getParameter("keyWord");
	ArrayList<FileDTO> recipeList = dao.getDBList(keyWord);
%>
	
		<div class="contets">
		
			<div class="con_1">
				<div class="con_title">
				
					<h1>레시피</h1>
		<%
			if("root".equals(userID)){
		%>
		<div class="con_title_admin">
			<button type="button" onclick="location.href='FileController?action=add'">레시피등록</button>
		</div>
		<%
			}
		%>
		
			<div class="search">
				<form method="post" name="search">
				<input type="text" class="search_bar" name="keyWord" placeholder="내용을 입력하세요">
				<input type="button" class="search_btn" align=right value="검색" onClick="searchCheck()">
			</form>
			</div>
				</div>
	<div class="con_1_box">
	<form name="form1" method="post" action="/JOY/file/FileController">
		<input type="hidden" name="action" value="list">
		<input type="hidden" name="foodNum" value=0>
	<div class="con">
	<%
	for(int i=0; i <recipeList.size(); i++){
		FileDTO dto = recipeList.get(i);
	%>
	
	
	<div class="box">
	
		
		<a href="javascript:detailcheck(<%=dto.getFoodNum() %>)">
		<div class="box_img">
		<%=dto.getFileImg() %>
		</div>
		</a>
		<h4>
		<%=dto.getFileName() %>
		</h4>
		</div>
		
			
	<%
		}
	%>	
	
	</div>
	

	</form>
	</div>
		</div>
	</div>			
	
	<footer>
       <div class="footer_logo">
           <img src="../img/login/logo_logo.png">
       </div>
        <div class="foot_m">
            <a href="https://www.instagram.com"><img src="../img/instagram.png"></a>
            <a href="http://www.youtube.com"><img src="../img/youtube.png"></a>
            <a href="http://www.facebook.com"><img src="../img/facebook.png"></a>
        </div>
         <div class="foot_l">
            <p>
             대표 : 정지형 / E : stopbro0323@naver.com / T : 010-3744-9840</p>
            <p>
            인천 동구 송림동 122-1 인천재능대학교 IT관 3층
            </p>
            <p>
            문의전화 이용시간 : (평일 10:00 ~ 18:00)
            </p>
            <p>
            서비스 이용문의 : 010-8021-3211    
            </p><br>
            <p>&copy;Coppyright 2019. J.O.Y All Rigit Reserved.</p>
        </div>
          <div class="foot2">
        <img src="../img/footlogo.png">
    </div>
    </footer>
		</div>
</body>
</html>