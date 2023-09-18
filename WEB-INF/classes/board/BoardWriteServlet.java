package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 한글 인코딩
		request.setCharacterEncoding("UTF-8");
		// 클라이언트 응답시 전달될 컨텐트에 대한 타잎 설정과 캐릿터셋 지정
		response.setContentType("text/html; charset=UTF-8");
		
		String boardTitle = multi.getParameter("boardTitle");
		String boardContent = multi.getParameter("boardContent");
		if(boardTitle == null || boardTitle.equals("") || boardContent == null || boardContent.equals("")) {
			session.setAttribute("messageType", "오류 메시지");
			session.setAttribute("messageContent", "내용을 모두 채워주세요.");
			response.sendRedirect("boardWrite.jsp");
			return;
		}
		BoardDAO boardDAO = new BoardDAO();
		boardDAO.write(userID, boardTitle, boardContent);
		session.setAttribute("messageType", "성공 메시지");
		session.setAttribute("messageContent", "게시물이 작성되었습니다.");
		response.sendRedirect("index.jsp");
		return;
		}
		
		
		
       
}
