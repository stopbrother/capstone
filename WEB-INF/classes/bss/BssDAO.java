package bss;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BssDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public BssDAO() {
		try {
			String dbURL = "jdbc:mysql://114.204.203.60:3306/joydb?useSSL=true&verifyServerCertificate=false&characterEncoding=UTF-8&serverTimezone=UTC";
			String dbID = "Joy";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String SQL = "select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getNext() {
		String SQL = "select bssID from bss order by bssID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int write(String bssTitle, String userID, String bssContent) {
		String SQL = "insert into bss values (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bssTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bssContent);
			pstmt.setInt(6, 1);
			pstmt.setInt(7, 0);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<Bss> getList(int pageNumber) {
		String SQL = "select * from bss where bssID < ? AND bssAvailable = 1 order by bssID desc limit 10";
		ArrayList<Bss> list = new ArrayList<Bss>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Bss bss = new Bss();
				bss.setBssID(rs.getInt(1));
				bss.setBssTitle(rs.getString(2));
				bss.setUserID(rs.getString(3));
				bss.setBssDate(rs.getString(4));
				bss.setBssContent(rs.getString(5));
				bss.setBssAvailable(rs.getInt(6));
				bss.setReadcnt(rs.getInt(7));
				list.add(bss);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "select * from bss where bssID < ? AND bssAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Bss getBss(int bssID) {
		String SQL = "select * from bss where bssID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bssID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bss bss = new Bss();
				bss.setBssID(rs.getInt(1));
				bss.setBssTitle(rs.getString(2));
				bss.setUserID(rs.getString(3));
				bss.setBssDate(rs.getString(4));
				bss.setBssContent(rs.getString(5));
				bss.setBssAvailable(rs.getInt(6));
				bss.setReadcnt(rs.getInt(7));
				return bss;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bssID, String bssTitle, String bssContent) {
		String SQL = "update bss SET bssTitle = ?, bssContent = ? where bssID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bssTitle);
			pstmt.setString(2, bssContent);
			pstmt.setInt(3, bssID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int delete(int bssID) {
		String SQL = "update bss set bssAvailable = 0 where bssID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bssID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public void ReadCnt(int no) {
		String SQL = "update bss set readcnt=readcnt+1 where bssID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//메인 최신게시판 조회
	public ArrayList<Bss> getSelectBss() {
		String SQL = "select bssID, bssTitle, userID, bssDate, bssContent, readcnt from bss order by bssID desc";
		ArrayList<Bss> list = new ArrayList<>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			int count=0;
			
			while (rs.next()) {
				Bss bss = new Bss();
				bss.setBssID(rs.getInt(1));
				bss.setBssTitle(rs.getString(2));
				bss.setUserID(rs.getString(3));
				bss.setBssDate(rs.getString(4));
				bss.setBssContent(rs.getString(5));
				bss.setReadcnt(rs.getInt(6));
				list.add(bss);
				count++;
				if(count > 2) break;
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
