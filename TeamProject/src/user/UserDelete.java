package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UserDelete.do")
public class UserDelete extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원 탈퇴	
		String email = request.getParameter("email");
		// 호스트 유무 - 호스트등록이 되어 있으면 1 없으면 0
		String host_check = request.getParameter("host_check");
		System.out.println("UserDelete 서블릿 : "+email);
		
		UserDAO udao = new UserDAO();
		// DB에서 회원 삭제
		int result = udao.userDelete(email, host_check);
		
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
