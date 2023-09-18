<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bss.Bss" %>
<%@ page import="bss.BssDAO" %>

<jsp:useBean id="dto" class="bss.Bss"/>
<jsp:useBean id="bssDAO" class="bss.BssDAO"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="view" value="${bssDAO.getBss(param.bssID)}"/>
<c:set var="readcnt" value="${bssDAO.ReadCnt(param.bssID)}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1,maximum-scale=1,user-scalable=no">
<script src="../js/jquery.min.js"></script>
<script src="../js/toggle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<link rel="stylesheet" href="../css/boardview.css">
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/base.css">
<title>나 혼자 요리! - 게시물 보기</title>
<script type="text/javascript">
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
		System.out.println(bss.getReadcnt());
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
						<a href="../user/login.jsp">
							<img src="../img/user_pc.png" alt="로그인">
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
                	<a href="../file/recipe.jsp">레시피</a>
                </li>
                <li>
                	<a href="bss.jsp" class="active">게시판</a>
                </li>
            </ul>
        </nav>
        <span class="toggle_btn">전체메뉴 토글버튼</span>
        </div>
    
	<div class="sec-space">
		<h1>게시판</h1>
		<p>사용자 여러분들을 위한 게시판입니다.</p>
		<div class="sec-space">
			<section calss="sec add-bor">
				<div class="brd-view extend-space">
					<div class="head">
						<h1>
							<span class="break-ta-only"></span>
							<%= bss.getBssTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
						</h1>
						<span>
							<em>
								<%= bss.getUserID() %>
							</em>
							<span id="regDatetime">
								<%= bss.getBssDate().substring(0, 11) + bss.getBssDate().substring(11, 13) + "시" + bss.getBssDate().substring(14, 16) + "분" %>
							</span>
						</span>
					</div>
					<div class="body">
						<div class="body-sec inc-line" style="white-space: pre-line;">
							<%= bss.getBssContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
						</div>
					</div>
					<div class="btn-set union-new">
					<%
						if(userID != null && userID.equals(bss.getUserID())) {
					%>
                           <div class="left">
                               <span>
                                   <a href="update.jsp?bssID=<%= bssID %>" class="button light">
                                       <span class="inner">수정</span>
                                   </a>
                               </span>
                               <span>                        
                                   <a href="deleteAction.jsp?bssID=<%= bssID %>" class="button light" onclick="return confirm('정말로 삭제하시겠습니까?')">
                                       <span class="inner">삭제</span>
                                   </a>
                               </span>
                           </div>
                    <%
						}
                    %>
                           <div class="right">
                               <a href="write.jsp" class="button">
                                   <span class="inner">글쓰기</span>
                               </a>
                           </div>
                           <div class="cr">
                               <a href="bss.jsp" class="button icon">
                                   <span class="inner">
                                     	  목록보기
                                   </span>
                               </a>
                           </div>
						</div>
					</div>
				</section>
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
             대표 : 정지형 / E : sssssssw@naver.com / T : 010-3744-9840</p>
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