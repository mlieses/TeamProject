package booking;

import java.io.IOException;


import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BookingController.do")
public class BookingController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}

	protected void doPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String roomNumber = request.getParameter("roomNumber"); // 룸넘버
		String selectDate = request.getParameter("selectDate"); // 선택 날짜
		String selectTime = request.getParameter("selectTime"); // 선택 시간
		String allPrice = request.getParameter("allPrice"); // 가격
		
		System.out.println("roomNumber : "+roomNumber +" selectDate : "+selectDate+ " selectTime : "+selectTime +" allPrice :"+allPrice);
		
		
		StringTokenizer st = new StringTokenizer(selectTime,",");		
		
		System.out.println(st.countTokens());
		
		String startTime = "시간정보가 없습니다.";
		int nextTok = Integer.parseInt(st.nextToken());
		// 시작시간 가져오기
		if(!startTime.equals("")){
			nextTok +=9;
			startTime = String.valueOf(nextTok);
		}		
		
		// 사진 제목 내용 (호스트 쪽)
		BookingDAO boodao = new BookingDAO();	
		
		BookingDTO boodto = boodao.getPreBookingList(roomNumber); 
		
		request.setAttribute("roomNumber", roomNumber);		
		request.setAttribute("selectDate", selectDate);
		request.setAttribute("selectTime", selectTime);
		request.setAttribute("startTime", startTime);
		request.setAttribute("allPrice", allPrice);
		request.setAttribute("boodto", boodto);
		request.setAttribute("time", st.countTokens()+1);
		
		
		RequestDispatcher dis = request.getRequestDispatcher("booking/booking.jsp");
		
		dis.forward(request, response);
		
		
		
	}

}
