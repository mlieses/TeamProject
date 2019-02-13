package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/HostDelete.do")
public class HostDelete extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String host_id = request.getParameter("host_id");
		
		System.out.println("HostDelete : "+host_id);
		
		UserDAO udao = new UserDAO();
		
		int result = udao.hostDelete(host_id);
		
		response.setContentType("text/html; charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		if(result > 0){
			
			HttpSession session = request.getSession();
			session.invalidate();			
			
			out.println("<script>");
			out.println("alert('탈퇴 되었습니다.')");
			out.println("location.href('index.jsp')");
			out.println("</script>");
			
			
		}else{
			out.println("<script>");
			out.println("alert('탈퇴에 실패 하였습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}	
		
		
	}

}
