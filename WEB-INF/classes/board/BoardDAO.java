package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.jdbc.pool.DataSource;

import user.UserDTO;

public class BoardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	DataSource dataSource;
	
	public BoardDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/jspdb");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	
	public BoardDTO getBoard(String boardID) {
		BoardDTO board = new BoardDTO();
		ResultSet rs = null;
		String SQL = "select * from board where boardID = ?";
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, boardID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				board.setUserID(rs.getString("userID"));
				board.setBoardID(rs.getInt("boardID"));
				board.setBoardTitle(rs.getString("boardTitle").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				board.setBoardContent(rs.getString("boardContent").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
				board.setBoardDate(rs.getString("boardDate").substring(0, 11));
				board.setBoardHit(rs.getInt("boardInt"));
				board.setBoardGroup(rs.getInt("boardgroup"));
				board.setBoardSequence(rs.getInt("boardSequence"));
				board.setBoardLevel(rs.getInt("boardLevel"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return board;
	}
	
public boolean insertUserInfo(UserDTO userDTO) {
		
		
		connect();
		
		// 		
		String sql ="insert into board select ?, ifnull((select max(boardID) + 1 from board), 1),?,?,now(),0,?,?,ifnull((select max(boardGroup) + 1 from board),0),0,0";
		
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(sql);

			// SQL문에 변수 입력
			pstmt.setString(1,userDTO.getUserID());
			pstmt.setString(2,userDTO.getBoardTitle());
			pstmt.setString(3,userDTO.getBoardContent());
			;
			
			//SQL문 실행
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}

	/******************************************************************************************/
	// 게시판 입력 메서드
	/******************************************************************************************/
	public boolean insertDB(BoardDTO boardDTO) {
		
		
		connect();
		
		
		// id 는 자동 등록 되므로 입력하지 않는다.				
			String sql ="insert into board(boardTitle, userID,boardDate, boardContent, boardAvailable) values(?,?,?,?,?)";		
		try {
			
			pstmt = conn.prepareStatement(sql);

			// SQL문에 변수 입력
			pstmt.setString(1,boardDTO.getBoardTitle());
			pstmt.setString(2,boardDTO.getUserID());
			pstmt.setString(3,boardDTO.getBoardDate());
			pstmt.setString(4,boardDTO.getBoardContent());
			pstmt.setInt(5,boardDTO.getBoardAvailable());
			
			//SQL문 실행
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	
	
	/******************************************************************************************/
	// 게시판목록 조회 메서드
	/******************************************************************************************/
	public ArrayList<BoardDTO> getDBList() {
		
		connect();
		
		ArrayList<BoardDTO> boardList = new ArrayList<BoardDTO>();
		
		String sql = "select boardID, boardTitle, userID, boardDate, boardContent, boardAvailable from board order by boardAvailable asc, boardID asc";
		
		
		//******************************************************************************************************
		// 게시글과 댓글이 별도 테이블이라면 Union을 활용하여 select
		//*****************************************************************************************************
		//		SELECT 게시글ID, "notice", 게시자성명, 글제목, 글내용, 게시글ID, 작성일시
		//		FROM 게시판
		//		UNION
		//		SELECT 댓글ID, "reply", 댓글자성명, 글제목, 글내용, 게시글ID, 작성일시
		//		FROM 댓글
		//		ORDER BY 게시글ID ASC, 작성일시 ASC
		//*****************************************************************************************************

		try {
			
			pstmt = conn.prepareStatement(sql);
			
			//SQL문 실행
			ResultSet rs = pstmt.executeQuery();

			while(rs.next()) {
				
				// DO 객체 생성
				BoardDTO boardDTO = new BoardDTO();
				
				// DB Select결과를 DO 객체에 저장
				boardDTO.setBoardID(rs.getInt("boardID"));
				boardDTO.setBoardTitle(rs.getString("boardTitle"));
				boardDTO.setUserID(rs.getString("userID"));
				boardDTO.setBoardDate(rs.getString("boardDate"));
				boardDTO.setBoardContent(rs.getString("boardContent"));
				boardDTO.setBoardAvailable(rs.getInt("boardAvailable"));

				boardList.add(boardDTO);
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return boardList;
	}

	/******************************************************************************************/
	// edit용 게시판 1건 조회 메서드
	/******************************************************************************************/
	public BoardDTO getDB(int boardID) {
		
		connect();
		
		BoardDTO boardDTO = new BoardDTO();
		
		String sql = "select * from board where boardID = ?";
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			// SQL문에 조회조건 입력
			pstmt.setInt(1,boardID);

			//SQL문 실행
			ResultSet rs = pstmt.executeQuery();

			// 데이터가 하나만 있으므로 rs.next()를 한번만 실행 한다.
			rs.next();
			
			// DB Select결과를 DO 객체에 저장
			boardDTO.setBoardID(rs.getInt("boardID"));
			boardDTO.setBoardTitle(rs.getString("boardTitle"));
			boardDTO.setUserID(rs.getString("userID"));
			boardDTO.setBoardDate(rs.getString("boardDate"));
			boardDTO.setBoardContent(rs.getString("boardContent"));
			boardDTO.setBoardAvailable(rs.getInt("boardAvailable"));
			
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return boardDTO;
	}


	/******************************************************************************************/
	// 게시판 수정 메서드
	/******************************************************************************************/
	public boolean updateDB(BoardDTO boardDTO) {
		
		
		connect();
		
		// id로 매칭하여 update(게시판일자와 게시판금액만 수정 가능)				
		String sql ="update board set userID=?, boardTitle=?, boardContent=? where boardID=?";

		try {
			
			pstmt = conn.prepareStatement(sql);

			// SQL문에 변수 입력
			pstmt.setString(1,boardDTO.getUserID());
			pstmt.setString(2,boardDTO.getBoardTitle());
			pstmt.setString(3,boardDTO.getBoardContent());
			pstmt.setInt(4,boardDTO.getBoardID());
		
			//SQL문 실행
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	
	
	/******************************************************************************************/
	// 게시판 삭제 메서드
	/******************************************************************************************/
	public boolean deleteDB(int boardID) {
		
		
		connect();
		
		// id로 매칭하여 delete				
			String sql ="delete from board where boardID=?";
		
		try {
			
			pstmt = conn.prepareStatement(sql);

			// SQL문에 변수 입력
			pstmt.setInt(1,boardID);
						
			//SQL문 실행
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
		}
		return true;
	}
	
	
/******************************************************************************************/
// 게시판 그룹ID 채번 메서드
/******************************************************************************************/
public int getNewGroupId() {
	
	connect();
	
	int newGroupId = 0;
	
	String sql = "select distinct groupId from BoardR where groupId = (select MAX(groupId) from BoardR)";
	
	try {
		
		pstmt = conn.prepareStatement(sql);
		
		//SQL문 실행
		ResultSet rs = pstmt.executeQuery();

		
		// 게시판 글이 1건 있는 경우
		if(rs.next()) {
			
			newGroupId = rs.getInt("groupId") + 1;
			
		} else {

			newGroupId = 1;
			
		}
		
		System.out.println("groupId : " + newGroupId);
		
		rs.close();
		
	} catch (SQLException e) {
		e.printStackTrace();
	}
	finally {
		disconnect();
	}
	
	return newGroupId;
}

}
