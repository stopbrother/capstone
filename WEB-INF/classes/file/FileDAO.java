package file;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.*;
import java.util.ArrayList;







public class FileDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	/* MySQL 연결정보 */
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	
	// 컴정과 실습실용
	// String jdbc_url = "jdbc:mysql://127.0.0.1:3306/jspdb";
	
	String jdbc_url = "jdbc:mysql://114.204.203.60:3306/joydb?useSSL=true&verifyServerCertificate=false&characterEncoding=UTF-8&serverTimezone=UTC";

	
	/******************************************************************************************/
	// DB연결 메서드
	/******************************************************************************************/
	void connect() {
		try {
			Class.forName(jdbc_driver);

			conn = DriverManager.getConnection(jdbc_url,"Joy","1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	/******************************************************************************************/
	// DB 연결해제 메소드
	/******************************************************************************************/
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	//입력
	public boolean insertDB(FileDTO fileDTO) {
		
		connect();
		
		String SQL = "insert into file(fileName,fileImg,fileDesc,fileProcessImg1,fileProcessImg2,fileProcessImg3,fileProcessImg4,fileProcessImg5,fileProcessImg6,fileProcessImg7,fileProcessImg8,fileProcessImg9,fileProcessImg10,fileProcess1,fileProcess2,fileProcess3,fileProcess4,fileProcess5,fileProcess6,fileProcess7,fileProcess8,fileProcess9,fileProcess10,readcnt) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fileDTO.getFileName());
			pstmt.setString(2, fileDTO.getFileImg());
			pstmt.setString(3, fileDTO.getFileDesc());
			pstmt.setString(4, fileDTO.getFileProcessImg1());
			pstmt.setString(5, fileDTO.getFileProcessImg2());
			pstmt.setString(6, fileDTO.getFileProcessImg3());
			pstmt.setString(7, fileDTO.getFileProcessImg4());
			pstmt.setString(8, fileDTO.getFileProcessImg5());
			pstmt.setString(9, fileDTO.getFileProcessImg6());
			pstmt.setString(10, fileDTO.getFileProcessImg7());
			pstmt.setString(11, fileDTO.getFileProcessImg8());
			pstmt.setString(12, fileDTO.getFileProcessImg9());
			pstmt.setString(13, fileDTO.getFileProcessImg10());			
			pstmt.setString(14, fileDTO.getFileProcess1());
			pstmt.setString(15, fileDTO.getFileProcess2());
			pstmt.setString(16, fileDTO.getFileProcess3());
			pstmt.setString(17, fileDTO.getFileProcess4());
			pstmt.setString(18, fileDTO.getFileProcess5());
			pstmt.setString(19, fileDTO.getFileProcess6());
			pstmt.setString(20, fileDTO.getFileProcess7());
			pstmt.setString(21, fileDTO.getFileProcess8());
			pstmt.setString(22, fileDTO.getFileProcess9());
			pstmt.setString(23, fileDTO.getFileProcess10());
			pstmt.setInt(24, 0);
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
	
	//목록 조회
			public ArrayList<FileDTO> getDBList() {
				
				connect();
				ArrayList<FileDTO> recipeList = new ArrayList<FileDTO>();
				String SQL = "select foodNum,fileImg,fileName,fileProcessImg1,fileProcessImg2,fileProcessImg3,fileProcessImg4,fileProcessImg5,fileProcessImg6,fileProcessImg7,fileProcessImg8,fileProcessImg9,fileProcessImg10,readcnt from file";
				try {
					pstmt = conn.prepareStatement(SQL);
					ResultSet rs = pstmt.executeQuery();
					
					String imageTemp = "";
					String imageTemp1 = "";
					String imageTemp2 = "";
					String imageTemp3 = "";
					String imageTemp4 = "";
					String imageTemp5 = "";
					String imageTemp6 = "";
					String imageTemp7 = "";
					String imageTemp8 = "";
					String imageTemp9 = "";
					String imageTemp10 = "";
					
					
				
					while (rs.next()) {
						FileDTO fileDTO = new FileDTO();
						fileDTO.setFoodNum(rs.getInt("foodNum"));
						imageTemp = rs.getString("fileImg");
						fileDTO.setFileImg("<img src = '" + imageTemp + "' />");
						fileDTO.setFileName(rs.getString("fileName"));
						fileDTO.setFileProcessImg1("<img src = '" + imageTemp1 + "' onerror=this.style.display='none'; />");
						fileDTO.setFileProcessImg2("<img src = '" + imageTemp2 + "' onerror=this.style.display='none'; />");
						fileDTO.setFileProcessImg3("<img src = '" + imageTemp3 + "' onerror=this.style.display='none'; />");
						fileDTO.setFileProcessImg4("<img src = '" + imageTemp4 + "' onerror=this.style.display='none'; />");
						fileDTO.setFileProcessImg5("<img src = '" + imageTemp5 + "' onerror=this.style.display='none'; />");
						fileDTO.setFileProcessImg6("<img src = '" + imageTemp6 + "' onerror=this.style.display='none'; />");
						fileDTO.setFileProcessImg7("<img src = '" + imageTemp7 + "' onerror=this.style.display='none'; />");
						fileDTO.setFileProcessImg8("<img src = '" + imageTemp8 + "' onerror=this.style.display='none'; />");
						fileDTO.setFileProcessImg9("<img src = '" + imageTemp9 + "' onerror=this.style.display='none'; />");
						fileDTO.setFileProcessImg10("<img src = '" + imageTemp10 + "' onerror=this.style.display='none'; />");
						fileDTO.setReadcnt(rs.getInt("readcnt"));
						recipeList.add(fileDTO);
					}
					rs.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
				finally {
					disconnect();
				}
				return recipeList;
			}
	
	//검색 목록 조회 
		public ArrayList<FileDTO> getDBList(String keyWord) {
			
			connect();
			
			ArrayList<FileDTO> recipeList = new ArrayList<FileDTO>();
			
			try {
				String SQL = "select foodNum,fileImg,fileName,fileProcessImg1,fileProcessImg2,fileProcessImg3,fileProcessImg4,fileProcessImg5,fileProcessImg6,fileProcessImg7,fileProcessImg8,fileProcessImg9,fileProcessImg10,readcnt from file ";
				pstmt = conn.prepareStatement(SQL);
				ResultSet rs;
				Statement st;
				
				String imageTemp = "";
				String imageTemp1 = "";
				String imageTemp2 = "";
				String imageTemp3 = "";
				String imageTemp4 = "";
				String imageTemp5 = "";
				String imageTemp6 = "";
				String imageTemp7 = "";
				String imageTemp8 = "";
				String imageTemp9 = "";
				String imageTemp10 = "";
				
				if(keyWord != null && !keyWord.equals("")) {
					SQL +="where fileName like" + " '%" + keyWord.trim()+"%' order by foodNum"; 
				} else {
					SQL +="order by foodNum";
				}
				System.out.println("SQL =" + SQL);
				st = conn.createStatement();
				rs = st.executeQuery(SQL);
			
				while (rs.next()) {
					FileDTO fileDTO = new FileDTO();
					fileDTO.setFoodNum(rs.getInt("foodNum"));
					imageTemp = rs.getString("fileImg");
					fileDTO.setFileImg("<img src = '" + imageTemp + "' />");
					fileDTO.setFileName(rs.getString("fileName"));
					fileDTO.setFileProcessImg1("<img src = '" + imageTemp1 + "' onerror=this.style.display='none'; />");
					fileDTO.setFileProcessImg2("<img src = '" + imageTemp2 + "' onerror=this.style.display='none'; />");
					fileDTO.setFileProcessImg3("<img src = '" + imageTemp3 + "' onerror=this.style.display='none'; />");
					fileDTO.setFileProcessImg4("<img src = '" + imageTemp4 + "' onerror=this.style.display='none'; />");
					fileDTO.setFileProcessImg5("<img src = '" + imageTemp5 + "' onerror=this.style.display='none'; />");
					fileDTO.setFileProcessImg6("<img src = '" + imageTemp6 + "' onerror=this.style.display='none'; />");
					fileDTO.setFileProcessImg7("<img src = '" + imageTemp7 + "' onerror=this.style.display='none'; />");
					fileDTO.setFileProcessImg8("<img src = '" + imageTemp8 + "' onerror=this.style.display='none'; />");
					fileDTO.setFileProcessImg9("<img src = '" + imageTemp9 + "' onerror=this.style.display='none'; />");
					fileDTO.setFileProcessImg10("<img src = '" + imageTemp10 + "' onerror=this.style.display='none'; />");
					fileDTO.setReadcnt(rs.getInt("readcnt"));
					recipeList.add(fileDTO);
				}
				rs.close();
				st.close();
			} catch (Exception e) {
				System.out.println(e+"=> getDBList fail");
			}
			finally {
				
				disconnect();
			}
			return recipeList;
		}
	
	//최신메뉴 조회
	public ArrayList<FileDTO> getSelectFood(){
		connect();
		String SQL = "select foodNum,fileImg,fileName,fileProcessImg1,fileProcessImg2,fileProcessImg3,fileProcessImg4,fileProcessImg5,fileProcessImg6,fileProcessImg7,fileProcessImg8,fileProcessImg9,fileProcessImg10 from file order by foodNum desc";
		ArrayList<FileDTO> recipeList = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery();
			int count=0;
			
			String imageTemp = "";
			String imageTemp1 = "";
			String imageTemp2 = "";
			String imageTemp3 = "";
			String imageTemp4 = "";
			String imageTemp5 = "";
			String imageTemp6 = "";
			String imageTemp7 = "";
			String imageTemp8 = "";
			String imageTemp9 = "";
			String imageTemp10 = "";
			
			
			while(rs.next()) {
				FileDTO fileDTO = new FileDTO();
				fileDTO.setFoodNum(rs.getInt("foodNum"));
				imageTemp = rs.getString("fileImg");
				fileDTO.setFileImg("<img src = '" + imageTemp + "' />");
				fileDTO.setFileName(rs.getString("fileName"));
				fileDTO.setFileProcessImg1("<img src = '" + imageTemp1 + "' onerror=this.style.display='none'; />");
				fileDTO.setFileProcessImg2("<img src = '" + imageTemp2 + "' onerror=this.style.display='none'; />");
				fileDTO.setFileProcessImg3("<img src = '" + imageTemp3 + "' onerror=this.style.display='none'; />");
				fileDTO.setFileProcessImg4("<img src = '" + imageTemp4 + "' onerror=this.style.display='none'; />");
				fileDTO.setFileProcessImg5("<img src = '" + imageTemp5 + "' onerror=this.style.display='none'; />");
				fileDTO.setFileProcessImg6("<img src = '" + imageTemp6 + "' onerror=this.style.display='none'; />");
				fileDTO.setFileProcessImg7("<img src = '" + imageTemp7 + "' onerror=this.style.display='none'; />");
				fileDTO.setFileProcessImg8("<img src = '" + imageTemp8 + "' onerror=this.style.display='none'; />");
				fileDTO.setFileProcessImg9("<img src = '" + imageTemp9 + "' onerror=this.style.display='none'; />");
				fileDTO.setFileProcessImg10("<img src = '" + imageTemp10 + "' onerror=this.style.display='none'; />");
				
				recipeList.add(fileDTO);
				count++;
				if(count > 3) break;
				
			}
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return recipeList;
	}
	
	//상세조회
	public FileDTO getDB(int foodNum) {
		
		connect();
		FileDTO fileDTO = new FileDTO();
		
		String SQL = "select * from file where foodNum = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, foodNum);
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			
			fileDTO.setFoodNum(rs.getInt("foodNum"));
			fileDTO.setFileName(rs.getString("fileName"));
			fileDTO.setFileDesc(rs.getString("fileDesc"));
			fileDTO.setFileProcess1(rs.getString("fileProcess1"));
			fileDTO.setFileProcess2(rs.getString("fileProcess2"));
			fileDTO.setFileProcess3(rs.getString("fileProcess3"));
			fileDTO.setFileProcess4(rs.getString("fileProcess4"));
			fileDTO.setFileProcess5(rs.getString("fileProcess5"));
			fileDTO.setFileProcess6(rs.getString("fileProcess6"));
			fileDTO.setFileProcess7(rs.getString("fileProcess7"));
			fileDTO.setFileProcess8(rs.getString("fileProcess8"));
			fileDTO.setFileProcess9(rs.getString("fileProcess9"));
			fileDTO.setFileProcess10(rs.getString("fileProcess10"));
			fileDTO.setReadcnt(rs.getInt("readcnt"));
			
			String imageTemp = rs.getString("fileImg");
			fileDTO.setFileImg("<img src = '" + imageTemp + "' />");
			
			
			
			String imageTemp1 = rs.getString("fileProcessImg1");
			fileDTO.setFileProcessImg1("<img src = '" + imageTemp1 + "' onerror=this.style.display='none'; />");
			 
			String imageTemp2 = rs.getString("fileProcessImg2");
			fileDTO.setFileProcessImg2("<img src = '" + imageTemp2 + "' onerror=this.style.display='none'; />");
			
			String imageTemp3 = rs.getString("fileProcessImg3");
			fileDTO.setFileProcessImg3("<img src = '" + imageTemp3 + "' onerror=this.style.display='none'; />");
			
			String imageTemp4 = rs.getString("fileProcessImg4");
			fileDTO.setFileProcessImg4("<img src = '" + imageTemp4 + "' onerror=this.style.display='none'; />");
			
			String imageTemp5 = rs.getString("fileProcessImg5");
			fileDTO.setFileProcessImg5("<img src = '" + imageTemp5 + "' onerror=this.style.display='none'; />");
			
			String imageTemp6 = rs.getString("fileProcessImg6");
			fileDTO.setFileProcessImg6("<img src = '" + imageTemp6 + "' onerror=this.style.display='none'; />");
			
			String imageTemp7 = rs.getString("fileProcessImg7");
			fileDTO.setFileProcessImg7("<img src = '" + imageTemp7 + "' onerror=this.style.display='none'; />");
			
			String imageTemp8 = rs.getString("fileProcessImg8");
			fileDTO.setFileProcessImg8("<img src = '" + imageTemp8 + "' onerror=this.style.display='none'; />");
			
			String imageTemp9 = rs.getString("fileProcessImg9");
			fileDTO.setFileProcessImg9("<img src = '" + imageTemp9 + "' onerror=this.style.display='none'; />");
			
			String imageTemp10 = rs.getString("fileProcessImg10");
			fileDTO.setFileProcessImg10("<img src = '" + imageTemp10 + "' onerror=this.style.display='none'; />");
			
			rs.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return fileDTO;
	}
	
	
	
	public int getNext() {
		String SQL = "select foodNum from file order by foodNum desc";
		try {
			pstmt = conn.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public boolean nextPage(int pageNumber) {
		connect();
		ResultSet rs;
		String SQL = "select * from file where foodNum < ? AND fileAvailable = 1";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber -1) * 6);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 검색
	public ArrayList<FileDTO> getList(String fileName, String searchType, String search, int pageNumber) {
		connect();
		if(fileName.equals("전체")) {
			fileName = "";
		}
		
		
		ArrayList<FileDTO> recipeList = null;
		String SQL ="";
		ResultSet rs = null;
		try {
			if(searchType.equals("최신순")) {
				SQL = "select * from file where foodNum like ? and concat(fileName, fileDesc) like" +
						"? order by foodNum desc limit " + pageNumber * 5 + ", " + pageNumber * 5 + 6;
			} 
			
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + fileName + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			recipeList = new ArrayList<FileDTO>();
			while(rs.next()) {
				FileDTO file = new FileDTO(
						
						);
				recipeList.add(file);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) conn.close();} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) conn.close();} catch (Exception e) {e.printStackTrace();}
		}
		return recipeList;
	}

	
	
	//수정
	public boolean updateDB(int foodNum, FileDTO fileDTO) {
		
		connect();
		
		String SQL = "update file set fileName=?, fileImg=?, fileDesc=?, fileProcessImg1=?, fileProcessImg2=?, fileProcessImg3=?, fileProcessImg4=?, fileProcessImg5=?, fileProcessImg6=?, fileProcessImg7=?, fileProcessImg8=?, fileProcessImg9=?, fileProcessImg10=?, fileProcess1=?, fileProcess2=?, fileProcess3=?, fileProcess4=?, fileProcess5=?, fileProcess6=?, fileProcess7=?, fileProcess8=?, fileProcess9=?, fileProcess10=? where foodNum=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setString(1, fileDTO.getFileName());
			pstmt.setString(2, fileDTO.getFileImg());
			pstmt.setString(3, fileDTO.getFileDesc());
			pstmt.setString(4, fileDTO.getFileProcessImg1());
			pstmt.setString(5, fileDTO.getFileProcessImg2());
			pstmt.setString(6, fileDTO.getFileProcessImg3());
			pstmt.setString(7, fileDTO.getFileProcessImg4());
			pstmt.setString(8, fileDTO.getFileProcessImg5());
			pstmt.setString(9, fileDTO.getFileProcessImg6());
			pstmt.setString(10, fileDTO.getFileProcessImg7());
			pstmt.setString(11, fileDTO.getFileProcessImg8());
			pstmt.setString(12, fileDTO.getFileProcessImg9());
			pstmt.setString(13, fileDTO.getFileProcessImg10());			
			pstmt.setString(14, fileDTO.getFileProcess1());
			pstmt.setString(15, fileDTO.getFileProcess2());
			pstmt.setString(16, fileDTO.getFileProcess3());
			pstmt.setString(17, fileDTO.getFileProcess4());
			pstmt.setString(18, fileDTO.getFileProcess5());
			pstmt.setString(19, fileDTO.getFileProcess6());
			pstmt.setString(20, fileDTO.getFileProcess7());
			pstmt.setString(21, fileDTO.getFileProcess8());
			pstmt.setString(22, fileDTO.getFileProcess9());
			pstmt.setString(23, fileDTO.getFileProcess10());
			pstmt.setInt(24, foodNum);
			
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
	
	
	
	//삭제
	public boolean deleteDB(int foodNum) {
		
		connect();
		
		String SQL = "delete from file where foodNum=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, foodNum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		finally {
			
		}
		return true;
	}
	
	//조회수
	public void ReadCnt(int no) {
		String SQL = "update file set readcnt=readcnt+1 where foodNum=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}




}
