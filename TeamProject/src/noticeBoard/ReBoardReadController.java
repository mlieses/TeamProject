package noticeBoard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ReBoardReadController.do")
public class ReBoardReadController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}
	
	protected void doPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
		ReBoardDAO rdao = new ReBoardDAO();
		rdao.updateHit(notice_no);
		ReBoardDTO rDTO =  rdao.getRead(notice_no);
		
		request.setAttribute("notice", rDTO);
		RequestDispatcher dis = request.getRequestDispatcher("noticeBoard/reBoardRead.jsp");
		dis.forward(request, response);
	}
	
	
}
