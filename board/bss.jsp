<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bss.BssDAO" %>
<%@ page import="bss.Bss" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1,maximum-scale=1,user-scalable=no">
<script src="../js/jquery.min.js"></script>
<script src="../js/toggle.min.js"></script>
<script src="http://code.jquery-1.7.js" type="text/javascript"></script>
<script src="../js/send.js"></script>
<link rel="stylesheet" href="../css/board.css">
<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/base.css">
<title>나 혼자 요리! - 자유게시판</title>
<script type="text/javascript">
function logout(){
	alert('로그아웃이 완료되었습니다.')
}
</script>
</head>
<body>
<% 

		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
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
                		<a href="bss.jsp">
                    		<img src="../img/add.png" alt="레시피작성">
                		</a>
            		</li>
            		<li>
						<a href="../user/login.jsp">
							<img src="../img/user_pc.png" alt="로그인">
						</a>
					</li>
					<li>
                		<a href="bss.jsp">
                    		<img src="../img/add_pc.png" alt="레시피작성">
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
                	<a href="bss.jsp" class="active_1">게시판</a>
                </li>
            </ul>
        </nav>
        <span class="toggle_btn">전체메뉴 토글버튼</span>

        </div>
        
	<div class="sec-space">
		<h1>게시판</h1>
		<p>사용자 여러분들을 위한 게시판입니다.</p>
		<section class="sec">
		<div class="brd-list hover-color">
			<table class="tbl-list">
				<thead>
					<tr>
						<th scope="col">제목</th>
                        <th scope="col" style="width:16%;">등록일</th>
                        <th scope="col" style="width:9%;">작성자</th>
                        <th scope="col" style="width:9%;">조회수</th>
					</tr>
				</thead>
				<tbody id="tableBody">
					<%
						BssDAO bssDAO = new BssDAO();
						ArrayList<Bss> list = bssDAO.getList(pageNumber);
						for(int i= 0; i < list.size(); i++) {
					%>
					<tr>
						
						<td class="align-left"><a href="view.jsp?bssID=<%= list.get(i).getBssID() %>"><%= list.get(i).getBssTitle() %></a></td>
						<td class="device-portrait"><%= list.get(i).getBssDate().substring(0, 11) + list.get(i).getBssDate().substring(11, 13) + "시" + list.get(i).getBssDate().substring(14, 16) + "분" %></td>
						<td class="wid-auto"><%= list.get(i).getUserID() %></td>
						<td class="device-portrait"><%= list.get(i).getReadcnt() %></td>						
					</tr>
					<%
					System.out.println(list.get(i).getReadcnt());
						}
					%>
				</tbody>
			</table>
			</div>
			<div class="pagenate btn-set">
                    <ul class="pagination page-gray" id="paginDiv">
                        <li>
                            <a class="navi first" style="color: #e9e9e9;">ㅇ</a>
                        </li>
                    </ul>
			<%
				if(pageNumber != 1) {
			%>
				<a href="bss.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} if(bssDAO.nextPage(pageNumber +1)){
			%>
				<a href="bss.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
			<div class="right space-upper">
			<a href="write.jsp" class="button"><span class="inner">글쓰기</span></a>
		</div>
	</div>
</section>
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