<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%
	// 루트(컨텍스트) 밑의 upload 디렉토리
	// 개발환경과 운영환경 차이로 인하여 실제 Upload되는 위치는 JSP의 클래스 파일이 위치하는 곳
	String path = request.getRealPath("/upload/");

	int size = 1024 * 1024 * 10; //10M
	
	try{
		MultipartRequest multi = new MultipartRequest(request, path, size);
		
		
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
%>

<script language="javascript">
	history.go(-1);
</script>

