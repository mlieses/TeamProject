package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HostIdCheck.do")
public class HostIdCheck extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}
	protected void doPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int result=-1;
		UserDAO udao = new UserDAO();
		if(request.getParameter("host_id")!=null){
			String host_id = request.getParameter("host_id");
			System.out.println("ajax host_id: "+host_id);			
			
			result = udao.hostIdCheck(host_id);
			
			System.out.println(result);
			
		}else{
			String email = request.getParameter("email");
			System.out.println("ajax email: "+email);
			
			result = udao.userIdCheck(email);
			
			System.out.println(result);
			
		}
		
				
		
		
		response.setContentType("text/html; charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		out.println(result);
		
	}

}
