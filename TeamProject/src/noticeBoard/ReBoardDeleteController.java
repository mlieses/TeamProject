package noticeBoard;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ReBoardDeleteController.do")
public class ReBoardDeleteController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int notice_no = Integer.parseInt(request.getParameter("notice_no"));
				
		ReBoardDAO rdao = new ReBoardDAO();
		rdao.deleteNotice(notice_no);
		
		response.sendRedirect("./ReBoardListController.do");
	}

	
	

}
