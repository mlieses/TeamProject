package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sun.print.PrinterJobWrapper;

/**
 * Servlet implementation class AddLevelController
 */
@WebServlet("/AddLevelController.do")
public class AddLevelController extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String email = request.getParameter("email");
		System.out.println("AddLevelController : "+email);
		
		UserDAO udao = new UserDAO();
		int check = udao.upadateLevel(email);		
		
		HttpSession session = request.getSession();
		
		if(check == 1){
			HostDTO hdto = (HostDTO)session.getAttribute("hdto");
			
			hdto.setHost_level(3);
			
			session.setAttribute("hdto", hdto);
			
			int point = (int)session.getAttribute("point");
			
			point -= 30000;
			
			session.setAttribute("point", point);
			
		}
		
		response.setContentType("text/html; charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		out.println(check);
		
		
	}

}
