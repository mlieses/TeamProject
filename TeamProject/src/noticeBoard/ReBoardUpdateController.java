package noticeBoard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ReBoardUpdateController.do")
public class ReBoardUpdateController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
		ReBoardDAO rdao = new ReBoardDAO();
		ReBoardDTO notice = rdao.getRead(notice_no);
		request.setAttribute("notice", notice);
		
		RequestDispatcher dis = request.getRequestDispatcher("noticeBoard/reBoardUpdate.jsp");
		dis.forward(request, response);
	}


}
