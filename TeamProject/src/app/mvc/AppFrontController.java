package app.mvc;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//클라이언트의 요청 진입점
public class AppFrontController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			doService(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException {
			doService(req, resp);
	}
	
	protected void doService (HttpServletRequest req, HttpServletResponse resp)	throws ServletException, IOException{
		
		/* 어떤 페이지에서 요청이 들어왔는지, 사용자 요청 주소 알아내기 작업 */
		//사용자가 요청한 전체 주소 알아오기 
		String reqUri = req.getRequestURI(); //->/MVCBoard/board.app 
		
		//사용자의 요청 주소 중에서 /MVCBoard 가져오기
		String ctPath = req.getContextPath();
		
		// /MVCBoard/board.app 경로중에 /board.app 가져오기
		String cmd = reqUri.substring(ctPath.length());
		//cmd : 사용자의 요청에 대한 이동할 서블릿 컨트롤러 주소가 저장된다.
		
		//이동할 페이지주소를 담을 변수
		String nextPage = null;;
		
		if(cmd.equals("/board.app")) {//게시판 요청이면
			nextPage = "/list.board"; //게시판 컨트롤러(BoardController) 요청 가상주소를 저장
			
			
		}else if(cmd.equals("/file.app")) {//파일 자료실 요청이면
			nextPage = "/list.file"; //파일 자료실 컨트롤러 요청 
		}else if(cmd.equals("/login.app")){//로그인 요청 이면
			nextPage = "/login.jsp"; //이동할 로그인 페이지 주소 저장
		}else if(cmd.equals("/shop.app")){//쇼핑몰 요청 이면
			nextPage = "/list.shop"; //쇼핑몰 컨트롤러 요청 가상주소를 저장
		}//기타 등등..
		
		//실제 이동
		RequestDispatcher view = req.getRequestDispatcher(nextPage);
		view.forward(req, resp);
	}	
	
}
