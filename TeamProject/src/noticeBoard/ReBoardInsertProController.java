package noticeBoard;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ReBoardInsertProController.do")
public class ReBoardInsertProController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}
	
	protected void doPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("insertPro 컨트롤러에 들어옴");
		request.setCharacterEncoding("UTF-8");
		String subject = request.getParameter("notice_subject");
		String content = request.getParameter("notice_content");
		
		ReBoardDAO rdao = new ReBoardDAO();
		rdao.insertNotice(subject, content);
		
		response.sendRedirect("ReBoardListController.do");
	}

}
