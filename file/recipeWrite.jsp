<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1,maximum-scale=1,user-scalable=no">
<script src="../js/jquery.min.js"></script>
<script src="../js/toggle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>

<link rel="stylesheet" href="../css/index.css">
<link rel="stylesheet" href="../css/base.css">

<title>레시피 작성</title>
<script type="text/javascript">

	
		function insertcheck() {
			// post방식
			document.form1.action.value="insert";
			document.form1.fileNamePC.value = document.form2.file.value;
			document.form1.fileNamePC1.value = document.form2.file1.value;
			document.form1.fileNamePC2.value = document.form2.file2.value;
			document.form1.fileNamePC3.value = document.form2.file3.value;
			document.form1.fileNamePC4.value = document.form2.file4.value;
			document.form1.fileNamePC5.value = document.form2.file5.value;
			document.form1.fileNamePC6.value = document.form2.file6.value;
			document.form1.fileNamePC7.value = document.form2.file7.value;
			document.form1.fileNamePC8.value = document.form2.file8.value;
			document.form1.fileNamePC9.value = document.form2.file9.value;
			document.form1.fileNamePC10.value = document.form2.file10.value;
			document.form1.submit();
			
		}
		
		
		
	
	</script>
	<style type="text/css">
	
</style>
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
                	<a href="recipe.jsp" class="active">레시피</a>
                </li>
                <li>
                	<a href="../board/bss.jsp">게시판</a>
                </li>
            </ul>
        </nav>
        <span class="toggle_btn">전체메뉴 토글버튼</span>
        </div>
        
	<div class="contets">
		<div class="con_1">
			<div class="con_title">
				<h1>레시피 등록</h1>
			</div>
			<form name="form1" method="post" action="/JOY/file/FileController">
			
				<input type="hidden" name="action" value=${action}>
				<input type="hidden" name="fileNamePC" value="">
				<input type="hidden" name="fileNamePC1" value="">
				<input type="hidden" name="fileNamePC2" value="">
				<input type="hidden" name="fileNamePC3" value="">
				<input type="hidden" name="fileNamePC4" value="">
				<input type="hidden" name="fileNamePC5" value="">
				<input type="hidden" name="fileNamePC6" value="">
				<input type="hidden" name="fileNamePC7" value="">
				<input type="hidden" name="fileNamePC8" value="">
				<input type="hidden" name="fileNamePC9" value="">
				<input type="hidden" name="fileNamePC10" value="">
				
				
			<div class="con_1_box">
			<button type="button" class="btn" onclick="location.href='recipe.jsp'">목록조회</button>
				
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<tr>
					<td>
						<input type="button" class="btn" id="insert" value="등록" onClick="insertcheck()" >
					</td>
				</tr>
				
				<tbody>
					<tr>
						<th></th>
						<td><input type=text placeholder="음식이름을 입력합시오." size=20 align="left" name=fileName value=${fileDTO.fileName}></td>
					</tr>
					<tr>
						<th></th>
						<td><textarea class="form-control" placeholder="재료를 입력하십시오." name=fileDesc maxlength="1000" style="height: 100px;" value=${fileDTO.fileDesc}></textarea></td>
					</tr>
					<tr>
						<th>레시피1</th>
						<td><input type=text size=100 name=fileProcess1 value=${fileDTO.fileProcess1}></td>
					</tr>
					<tr>
						<th>레시피2</th>
						<td><input type=text size=100 name=fileProcess2 value=${fileDTO.fileProcess2}></td>
					</tr>
					<tr>
						<th>레시피3</th>
						<td><input type=text size=100 name=fileProcess3 value=${fileDTO.fileProcess3}></td>
					</tr>
					<tr>
						<th>레시피4</th>
						<td><input type=text size=100 name=fileProcess4 value=${fileDTO.fileProcess4}></td>
					</tr>
					<tr>
						<th>레시피5</th>
						<td><input type=text size=100 name=fileProcess5 value=${fileDTO.fileProcess5}></td>
					</tr>
					<tr>
						<th>레시피6</th>
						<td><input type=text size=100 name=fileProcess6 value=${fileDTO.fileProcess6}></td>
					</tr>
					<tr>
						<th>레시피7</th>
						<td><input type=text size=100 name=fileProcess7 value=${fileDTO.fileProcess7}></td>
					</tr>
					<tr>
						<th>레시피8</th>
						<td><input type=text size=100 name=fileProcess8 value=${fileDTO.fileProcess8}></td>
					</tr>
					<tr>
						<th>레시피9</th>
						<td><input type=text size=100 name=fileProcess9 value=${fileDTO.fileProcess9}></td>
					</tr>
					<tr>
						<th>레시피10</th>
						<td><input type=text size=100 name=fileProcess10 value=${fileDTO.fileProcess10}></td>
					</tr>	
					</tbody>
				</table>
				<br>
			</form>
					
					<table>
					<tr>
						<th>이미지</th>
				<td>
					<!-- WEB-INF/lib 디렉토리에 cos.jar 복사 필요, PC의 업로드할 파일 선택 가능  -->
					<form name=form2 action="fileupload_control.jsp" method="post" enctype="multipart/form-data">
						메인이미지 :<input type="file" align=left name="file" value=${fileDTO.fileImg}><BR>
						레시피1 :<input type="file" align=left name="file1" value=${fileDTO.fileProcessImg1}><BR>
						레시피2 :<input type="file" align=left name="file2" value=${fileDTO.fileProcessImg2}><BR>
						레시피3 :<input type="file" align=left name="file3" value=${fileDTO.fileProcessImg3}><BR>
						레시피4 :<input type="file" align=left name="file4" value=${fileDTO.fileProcessImg4}><BR>
						레시피5 :<input type="file" align=left name="file5" value=${fileDTO.fileProcessImg5}><BR>
						레시피6 :<input type="file" align=left name="file6" value=${fileDTO.fileProcessImg6}><BR>
						레시피7 :<input type="file" align=left name="file7" value=${fileDTO.fileProcessImg7}><BR>
						레시피8 :<input type="file" align=left name="file8" value=${fileDTO.fileProcessImg8}><BR>
						레시피9 :<input type="file" align=left name="file9" value=${fileDTO.fileProcessImg9}><BR>
						레시피10 :<input type="file" align=left name="file10" value=${fileDTO.fileProcessImg10}><BR>
						<input type="submit" align=left value="File Upload">
					</form>
				</td>
					</tr>
					</table>
					
					</div>
					</div>
					
					<br><br><br>
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