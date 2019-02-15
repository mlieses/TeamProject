package booking;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import user.HostDTO;
import user.UserDTO;

@WebServlet("/BookingCancelController.do")
public class BookingCancelController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}
	
	protected void doPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("예약 취소 들어옴");
		// 예약 취소시 booking 테이블의 book_check(취소유무 컬럼)에 값을 1로 세팅 하고
		// 해당 아이디의 포인트를 다시 돌려 주는 루틴
		// 필요 파라미터 해당 로그인된 회원의 이메일, 예약번호 필요
		String email = request.getParameter("email");
		String book_no = request.getParameter("book_no");
		int total_price = Integer.parseInt(request.getParameter("total_price"));
		BookingDAO bdao = new BookingDAO();
		
		System.out.println("email="+email+" book_no="+book_no+" total_price="+total_price);
		
		int result = bdao.setBookingCancel(email, book_no,total_price);
		
		HttpSession session = request.getSession();
		
		int point = total_price;
		
		UserDTO udto = (UserDTO)session.getAttribute("udto");
		if(udto == null){
			point = (int)session.getAttribute("point")+point;
			session.setAttribute("point", point);
		}else{
			udto.setPoint(point+udto.getPoint());
		}		
		
		if(result != 0){
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();	
			out.println("<script>");
			out.println("alert('취소가 완료 되었습니다.')");		
			out.println("location.href='ReservationController.do?userId="+email+"'");
			out.println("</script>");
			out.close();			
		}else{
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();				
			out.println("<script>");
			out.println("alert('취소에 실패 하였습니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();			

		}
		
	}

}
