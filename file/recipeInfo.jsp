<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="file.FileDAO" %>
<%@ page import="file.FileDTO" %>



<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="view" value="${fileDAO.getDB(param.foodNum)}" />
<c:set var="readcnt" value="${fileDAO.ReadCnt(param.foodNum)}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1,maximum-scale=1,user-scalable=no">
    <meta charset="UTF-8">
    <script src="js/jquery.min.js"></script>
    <script src="js/toggle.min.js"></script>
    <script src="http://code.jquery-1.7.js" type="text/javascript"></script>
    <script src="js/send.js"></script>
<link rel="stylesheet" href="../css/recipe_l.css">
<link rel="stylesheet" href="../css/base.css">
<title>나혼자요리 - 레시피</title>

<script type="text/javascript">

	
	
	function editcheck() {
		document.form1.action.value="edit";
		document.form1.submit();
	}

	function deletecheck() {
		result = confirm("정말로 삭제하시겠습니까 ?");
		if(result == true){
			document.form1.action.value="delete";
			document.form1.submit();
		}
		else
			return;
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
		
		int foodNum = 0;
		if (request.getParameter("foodNum") != null) {
			foodNum = Integer.parseInt(request.getParameter("foodNum"));
		}
		if (foodNum == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'recipe.jsp'");
			script.println("</script>");
		}
		FileDTO fileDTO = new FileDAO().getDB(foodNum);
		System.out.println(fileDTO.getReadcnt());
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
                	<a href="recipe.jsp" class="active">레시피</a>
                </li>
                <li>
                	<a href="../board/bss.jsp">게시판</a>
                </li>
            </ul>
        </nav>
        <span class="toggle_btn">전체메뉴 토글버튼</span>
        </div>		

<div class="row">
	<form name="form1" method="post" action="/JOY/file/FileController">
	
		<input type="hidden" name="action" value=${action}>
		<input type="hidden" name="foodNum" value=${fileDTO.foodNum}>
		
		
	<div class="con_1">
		<div class="con_1_title">
			<h1>레시피 > 정보</h1>
			<a href="recipe.jsp"><span class="back_btn">뒤로가기</span></a>
		</div>
		<%
			if("root".equals(userID)){
		%>
		<div class="button" align="rigth">
			<input type="button" id="edit" class="btn btn-primary" value="수정" onClick="editcheck()">
			<input type="button" id="delete" class="btn btn-primary" value="삭제" onClick="deletecheck()">
		</div>	
		<%
			}
		%>
			<div class="view">
				<div class="cook_img">
					${fileDTO.fileImg}
			</div>
			<div class="writer">
				<img src="../img/logos.png">				
				<h2>${fileDTO.fileName}</h2>
			</div>
			</div>
	</div>
		<div class="con_2">
			<div class="jaelyo">
				<h2>재료</h2>
				<hr>
				<p>${fileDTO.fileDesc}</p>
		</div>	
<div class="con_3">
	<div class="jori">
	<h2>조리순서</h2>
	</div>
		<hr>
		
	<div align="center">
		<div class="jori_img">
			${fileDTO.fileProcessImg1}
		</div>
			<div class="jori_txt">
				<p>${fileDTO.fileProcess1}</p>
			</div>
	</div>
	<div align="center">
		<div class="jori_img">
			${fileDTO.fileProcessImg2}
		</div>
			<div class="jori_txt">
				${fileDTO.fileProcess2}
			</div>
	</div>
	<div align="center">
		<div class="jori_img">
			${fileDTO.fileProcessImg3}
		</div>
			<div class="jori_txt">
				${fileDTO.fileProcess3}
			</div>
	</div>
	<div align="center">
		<div class="jori_img">
			${fileDTO.fileProcessImg4}
		</div>
			<div class="jori_txt">
				${fileDTO.fileProcess4}
			</div>
	</div>
	<div align="center">
		<div class="jori_img">
			${fileDTO.fileProcessImg5}
		</div>
			<div class="jori_txt">
				${fileDTO.fileProcess5}
			</div>
	</div>
	<div align="center">
		<div class="jori_img">
			${fileDTO.fileProcessImg6}
		</div>
			<div class="jori_txt">
				${fileDTO.fileProcess6}
			</div>
	</div>
	<div align="center">
		<div class="jori_img">
			${fileDTO.fileProcessImg7}
		</div>
			<div class="jori_txt">
				${fileDTO.fileProcess7}
			</div>
	</div>
	<div align="center">
		<div class="jori_img">
			${fileDTO.fileProcessImg8}
		</div>
			<div class="jori_txt">
				${fileDTO.fileProcess8}
			</div>
	</div>
	<div align="center">
		<div class="jori_img">
			${fileDTO.fileProcessImg9}
		</div>
			<div class="jori_txt">
				${fileDTO.fileProcess9}
			</div>
	</div>
	<div align="center">
		<div class="jori_img">
			${fileDTO.fileProcessImg10}
		</div>
			<div class="jori_txt">
				${fileDTO.fileProcess10}
			</div>
	</div>


</div>	
</form>
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