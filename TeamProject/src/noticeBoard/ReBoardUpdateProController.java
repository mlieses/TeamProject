package noticeBoard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ReBoardUpdateProController.do")
public class ReBoardUpdateProController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("pro");
		request.setCharacterEncoding("UTF-8");
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
		String subject = request.getParameter("notice_subject");
		String content = request.getParameter("notice_content");
		
		ReBoardDAO rdao = new ReBoardDAO();
		ReBoardDTO notice = rdao.updateNotice(notice_no, subject, content);
		request.setAttribute("notice", notice);
		
		RequestDispatcher dis = request.getRequestDispatcher("./ReBoardReadController.do");
		dis.forward(request, response);
	}

}
