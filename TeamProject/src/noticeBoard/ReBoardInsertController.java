package noticeBoard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ReBoardInsertController.do")
public class ReBoardInsertController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("insert 컨트롤러에 들어옴");
		
		RequestDispatcher dis = request.getRequestDispatcher("noticeBoard/reBoardInsert.jsp");
		dis.forward(request, response);
	}

}
