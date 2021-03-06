package noticeBoard;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.HostDTO;

@WebServlet("/ReBoardListController.do")
public class ReBoardListController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}
	
	protected void doPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			//  게시판 전체 글의 개수 
			// 디비 객체 생성 ReBoardDAO bdao
			ReBoardDAO bdao = new ReBoardDAO();			
			// int count =  메서드호출  getBoardCount()   count(*)
			int count=bdao.getBoardCount();
			System.out.println("count : "+count);
			// 게시판 가져오기  2페이지 10개 => 시작행 끝행
			// 한페이지에 5개 글을 가져오도록 설정
			int pageSize=10;
			// 페이지 가져오기
			// 하단의 페이지 번호를 눌렀을 때 넘어오는 값
			String pageNum=request.getParameter("pageNum");
			if(pageNum==null){
				pageNum="1";
			}
			// 시작행번호 구하기  10  1페이지  1번행   2페이지  11번행   3  21번행
			int currentPage=Integer.parseInt(pageNum);
			int startRow=(currentPage-1)*pageSize+1;
			// 끝행번호
			int endRow=currentPage*pageSize;
			
			//현재 세션의 호스트 id 값을 받아오기
			HttpSession session = request.getSession();
			HostDTO hdto  = (HostDTO)session.getAttribute("hdto");
			String host_id = null;
			if(hdto!=null){
				host_id = hdto.getHost_id(); //hdto.getHost_id();
			}
			List<ReBoardDTO> boardList=null;
			//  시작행번호  몇개(10) 가져오기
			// boardList=메서드호출  getBoardList(시작행startRow,몇개pageSize)
			if(count!=0){
				boardList=bdao.getBoardList(startRow, pageSize);
			}
			//전체 페이지 수 구하기  50개 글  10개씩 보여주기 => 5+0
					//                 55개 글 10개씩 보여주기 => 5+1
			int pageCount =count/pageSize+(count%pageSize==0?0:1);
			//한화면에 보여줄 페이지수 설정
			int pageBlock=5;
			// 한화면에 보여줄 시작페이지 구하기  1~10  => 1  /  11~20 => 11
			int startPage=((currentPage-1)/pageBlock)*pageBlock+1;
			// 한화면에 보여줄 끝페이지 구하기
			int endPage=startPage+pageBlock-1;
			if(endPage > pageCount){
				endPage = pageCount;
			}
			// request  count boardList pageNum 
							// pageCount pageBlock startPage endPage저장
			request.setAttribute("count", count); //모든속성저장 Integer -> Object형저장
			request.setAttribute("boardList", boardList); // List -> Object 저장
			request.setAttribute("pageNum", pageNum); //String -> Object 저장
			request.setAttribute("pageCount", pageCount);
			request.setAttribute("pageBlock", pageBlock);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			// 이동  reBoard.jsp
			RequestDispatcher dis = request.getRequestDispatcher("noticeBoard/reBoard.jsp");
			System.out.println("디스패쳐");
			dis.forward(request, response);
			
			/*forward.setRedirect(false);
			forward.setPath("./CarMain.jsp?center=board/list.jsp");
			return forward;*/

	
	}


}
