package file;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;






@WebServlet(description = "File Controller 서블릿", urlPatterns = { "/file/FileController" })
public class FileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private static final javax.servlet.jsp.JspFactory _jspxFactory = javax.servlet.jsp.JspFactory.getDefaultFactory();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PageContext pageContext = null;
		
		HttpSession session = null;
		
		try {
			// pageContext 참조변수 객체 생성
			pageContext = _jspxFactory.getPageContext(this, request, response, null, true, 8192, true);
					
			// Session 사용 시 추가
			session = pageContext.getSession();

			// 한글 인코딩
			request.setCharacterEncoding("UTF-8");
						
			// 클라이언트 응답시 전달될 컨텐트에 대한 타잎 설정과 캐릿터셋 지정
			response.setContentType("text/html; charset=UTF-8");
				
			//클라이언트 응답을 위한 출력 스트림 확보(alert 메세지용)
			PrintWriter out = response.getWriter();
						
			// action구분 등 파라메터
			String action = request.getParameter("action");
				System.out.println("Controller action = " + action);
			
				// useBean productDTO에 해당하는 java 코드
				FileDTO fileDTO = (FileDTO)request.getAttribute("fileDTO");
				if(fileDTO == null) {
					fileDTO = new FileDTO();
					request.setAttribute("fileDTO", fileDTO);
				} 
				
				

				/* action에 따라 동작            */			
				if((action.equals("insert")) || (action.equals("update"))) {
				
					// setProperty productDTO에 해당하는 java 코드
					
					fileDTO.setFileName(request.getParameter("fileName"));
					fileDTO.setFileImg(request.getParameter("fileImg"));
					fileDTO.setFileDesc(request.getParameter("fileDesc"));
					fileDTO.setFileProcessImg1(request.getParameter("fileProcessImg1"));
					fileDTO.setFileProcessImg2(request.getParameter("fileProcessImg2"));
					fileDTO.setFileProcessImg3(request.getParameter("fileProcessImg3"));
					fileDTO.setFileProcessImg4(request.getParameter("fileProcessImg4"));
					fileDTO.setFileProcessImg5(request.getParameter("fileProcessImg5"));
					fileDTO.setFileProcessImg6(request.getParameter("fileProcessImg6"));
					fileDTO.setFileProcessImg7(request.getParameter("fileProcessImg7"));
					fileDTO.setFileProcessImg8(request.getParameter("fileProcessImg8"));
					fileDTO.setFileProcessImg9(request.getParameter("fileProcessImg9"));
					fileDTO.setFileProcessImg10(request.getParameter("fileProcessImg10"));
					fileDTO.setFileProcess1(request.getParameter("fileProcess1"));
					fileDTO.setFileProcess2(request.getParameter("fileProcess2"));
					fileDTO.setFileProcess3(request.getParameter("fileProcess3"));
					fileDTO.setFileProcess4(request.getParameter("fileProcess4"));
					fileDTO.setFileProcess5(request.getParameter("fileProcess5"));
					fileDTO.setFileProcess6(request.getParameter("fileProcess6"));
					fileDTO.setFileProcess7(request.getParameter("fileProcess7"));
					fileDTO.setFileProcess8(request.getParameter("fileProcess8"));
					fileDTO.setFileProcess9(request.getParameter("fileProcess9"));
					fileDTO.setFileProcess10(request.getParameter("fileProcess10"));
					
				}
				
				
				

				

				
				// productDAO 클래스 변수
				FileDAO fileDAO = new FileDAO();

				
				
				
			   	// action구분 등 파라메터
				String fileNamePC = request.getParameter("fileNamePC");
				String fileNamePC1 = request.getParameter("fileNamePC1");
				String fileNamePC2 = request.getParameter("fileNamePC2");
				String fileNamePC3 = request.getParameter("fileNamePC3");
				String fileNamePC4 = request.getParameter("fileNamePC4");
				String fileNamePC5 = request.getParameter("fileNamePC5");
				String fileNamePC6 = request.getParameter("fileNamePC6");
				String fileNamePC7 = request.getParameter("fileNamePC7");
				String fileNamePC8 = request.getParameter("fileNamePC8");
				String fileNamePC9 = request.getParameter("fileNamePC9");
				String fileNamePC10 = request.getParameter("fileNamePC10");
				String foodNum = request.getParameter("foodNum");
				String keyWord = request.getParameter("keyWord");
				


				if(action.equals("add")) {
				
					// 상품 입력화면 오픈
					pageContext.forward("recipeWrite.jsp?action=add");
				
				} else if(action.equals("insert")) {

					// 파일명만 추출
					File file = new File(fileNamePC);
					File file1 = new File(fileNamePC1);
					File file2 = new File(fileNamePC2);
					File file3 = new File(fileNamePC3);
					File file4 = new File(fileNamePC4);
					File file5 = new File(fileNamePC5);
					File file6 = new File(fileNamePC6);
					File file7 = new File(fileNamePC7);
					File file8 = new File(fileNamePC8);
					File file9 = new File(fileNamePC9);
					File file10 = new File(fileNamePC10);
					String fName = file.getName();
					String fName1 = file1.getName();
					String fName2 = file2.getName();
					String fName3 = file3.getName();
					String fName4 = file4.getName();
					String fName5 = file5.getName();
					String fName6 = file6.getName();
					String fName7 = file7.getName();
					String fName8 = file8.getName();
					String fName9 = file9.getName();
					String fName10 = file10.getName();
					// out.println("fileName : " + fileName); 
					
					// 이미지 파일 Full Path
					String filePath = "\\" + "JOY" + "\\" + "upload" + "\\" + fName ;
					String filePath1 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName1 ;
					String filePath2 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName2 ;
					String filePath3 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName3 ;
					String filePath4 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName4 ;
					String filePath5 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName5 ;
					String filePath6 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName6 ;
					String filePath7 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName7 ;
					String filePath8 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName8 ;
					String filePath9 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName9 ;
					String filePath10 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName10 ;
					// out.println("filePath : " + filePath);
					
					fileDTO.setFileImg(filePath) ;
					fileDTO.setFileProcessImg1(filePath1) ;
					fileDTO.setFileProcessImg2(filePath2) ;
					fileDTO.setFileProcessImg3(filePath3) ;
					fileDTO.setFileProcessImg4(filePath4) ;
					fileDTO.setFileProcessImg5(filePath5) ;
					fileDTO.setFileProcessImg6(filePath6) ;
					fileDTO.setFileProcessImg7(filePath7) ;
					fileDTO.setFileProcessImg8(filePath8) ;
					fileDTO.setFileProcessImg9(filePath9) ;
					fileDTO.setFileProcessImg10(filePath10) ;
					
					// 상품 입력
					if(fileDAO.insertDB(fileDTO)) {
						ArrayList<FileDTO> recipeList = fileDAO.getDBList();
						// 조회를 위하여 controll 호출
						request.setAttribute("recipeList", recipeList);
						pageContext.forward("recipe.jsp");
					} else {
						throw new Exception("DB 입력오류");
					}
					
				}  else if(action.equals("detail")) {
					
					// 상품 상세 조회결과		
					fileDTO = fileDAO.getDB(Integer.parseInt((String)request.getParameter("foodNum")));
					
					// edit를 setAttribute
					request.setAttribute("fileDTO", fileDTO);
					pageContext.forward("recipeInfo.jsp");

				} else if(action.equals("edit")) {
					
					fileDTO = fileDAO.getDB(Integer.parseInt((String)request.getParameter("foodNum")));
					
					request.setAttribute("action", action);
					
					request.setAttribute("fileDTO", fileDTO);
					pageContext.forward("recipeUpdate.jsp?action=edit");
					
				} else if(action.equals("update")) {
					
					// 파일명만 추출
					File file = new File(fileNamePC);
					File file1 = new File(fileNamePC1);
					File file2 = new File(fileNamePC2);
					File file3 = new File(fileNamePC3);
					File file4 = new File(fileNamePC4);
					File file5 = new File(fileNamePC5);
					File file6 = new File(fileNamePC6);
					File file7 = new File(fileNamePC7);
					File file8 = new File(fileNamePC8);
					File file9 = new File(fileNamePC9);
					File file10 = new File(fileNamePC10);
					String fName = file.getName();
					String fName1 = file1.getName();
					String fName2 = file2.getName();
					String fName3 = file3.getName();
					String fName4 = file4.getName();
					String fName5 = file5.getName();
					String fName6 = file6.getName();
					String fName7 = file7.getName();
					String fName8 = file8.getName();
					String fName9 = file9.getName();
					String fName10 = file10.getName();
					// out.println("fileName : " + fileName); 
					
					// 이미지 파일 Full Path
					String filePath = "\\" + "JOY" + "\\" + "upload" + "\\" + fName ;
					String filePath1 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName1 ;
					String filePath2 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName2 ;
					String filePath3 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName3 ;
					String filePath4 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName4 ;
					String filePath5 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName5 ;
					String filePath6 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName6 ;
					String filePath7 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName7 ;
					String filePath8 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName8 ;
					String filePath9 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName9 ;
					String filePath10 = "\\" + "JOY" + "\\" + "upload" + "\\" + fName10 ;
					// out.println("filePath : " + filePath);
					
					fileDTO.setFileImg(filePath) ;
					fileDTO.setFileProcessImg1(filePath1) ;
					fileDTO.setFileProcessImg2(filePath2) ;
					fileDTO.setFileProcessImg3(filePath3) ;
					fileDTO.setFileProcessImg4(filePath4) ;
					fileDTO.setFileProcessImg5(filePath5) ;
					fileDTO.setFileProcessImg6(filePath6) ;
					fileDTO.setFileProcessImg7(filePath7) ;
					fileDTO.setFileProcessImg8(filePath8) ;
					fileDTO.setFileProcessImg9(filePath9) ;
					fileDTO.setFileProcessImg10(filePath10) ;
					
					if(fileDAO.updateDB(Integer.parseInt((String)request.getParameter("foodNum")), fileDTO)) {
						ArrayList<FileDTO> recipeList = fileDAO.getDBList();
						
						request.setAttribute("recipeList", recipeList);
						pageContext.forward("recipe.jsp");
					} else {
						throw new Exception("DB 수정오류");
					}
				
				} else if(action.equals("delete")) {
					if(fileDAO.deleteDB(Integer.parseInt((String)request.getParameter("foodNum")))) {
						
						ArrayList<FileDTO> recipeList = fileDAO.getDBList();
						
						request.setAttribute("recipeList", recipeList);
						pageContext.forward("recipe.jsp");
					} else {
						throw new Exception("DB 삭제오류");
					}
					
				}
				else {
					
					out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
				}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
