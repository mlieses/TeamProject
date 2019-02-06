package booking;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.UserDTO;
@WebServlet("/bookingInsertController.do")
public class bookingInsertController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}
	
	protected void doPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 먼저 현재 접속한 회원에 포인트를 차감 한뒤 남은 데이터를 넣는다.
		// 2. BookinDTO에 담은 데이터들을 Booking 테이블에 insert 한다.
		// 3. selectTime에 저장된 시간을 BookingTimeDTO에 담는다.
		// 4. BookingTimeDTO에 저장된 값을 booking_time테이블에 저장한다
		request.setCharacterEncoding("UTF-8");
		BookingDAO boodao = new BookingDAO();

		String room_no = request.getParameter("roomNumber"); // 룸넘버
		String selectDate = request.getParameter("selectDate"); // 선택 날짜
		String selectTime = request.getParameter("selectTime"); // 선택 시간
		String book_phone = request.getParameter("book_phone"); // 예약자 전화 번호
		String totalPay = request.getParameter("totalPay"); // 총 가격
		String email = request.getParameter("email"); // 예약자 email
		
		System.out.println("roomNumber : "+room_no +" selectDate : "+selectDate
				+ " selectTime : "+selectTime +" totalPay :"+totalPay  +" book_phone :"+book_phone);
		
		
		

		//------------------------------------포인트 결제 차감
		// 현재 세션의 보유 포인트 가져오기
		int point = Integer.parseInt(request.getParameter("point"));
		
		// 보유포인트 보다 결제금액이 적을 경우
		if(Integer.parseInt(totalPay) > point){
						
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();		
			out.println("<script>");
			out.println("alert('보유포인트가 부족합니다. 충전해주세요');");
			out.println("history.back()");
			out.println("</script>");
			out.close();			
			return;
		}else{
			// 포인트를 차감 하고 새 포인트를 넣는다.
			int setPoint = point - Integer.parseInt(totalPay); 
			// DB에 보유 포인트 업데이트 하기
			boodao.setUserPointUpdate(email, setPoint);		
			// 포인트를 차감한 뒤 세션에 포인트도 다시 변경 적용
			HttpSession session = request.getSession();
			
			if(session.getAttribute("hdto") != null){
				// 호스트 로그인이면
				session.setAttribute("point", setPoint);
			}else{
				// 일반 유저 로그인이면
				UserDTO udto = (UserDTO)session.getAttribute("udto");
				udto.setPoint(setPoint);
				session.setAttribute("udto", udto);
			}			
			
		}
		
		//---------------------------------------------- 유료 옵션 값
		int parking = 0;
		int projector = 0;
		int laptop = 0;
		int wifi = 0;
		int cabinet = 0;
		
		if( request.getParameter("parking")!=null)  
			parking = Integer.parseInt(request.getParameter("parking")); // parking 가격
		if( request.getParameter("projector")!=null)  
			projector = Integer.parseInt(request.getParameter("projector")); // projector 가격
		if( request.getParameter("laptop")!=null)  
			laptop = Integer.parseInt(request.getParameter("laptop"));// laptop 가격
		if( request.getParameter("wifi")!=null)  
			wifi = Integer.parseInt(request.getParameter("wifi"));// wifi 가격
		if( request.getParameter("cabinet")!=null)  
			cabinet = Integer.parseInt(request.getParameter("cabinet"));// cabinet 가격		
		
		System.out.println("유료 옵션 : parking :"+parking +" projector : "+projector +" laptop : "+laptop
				 +" wifi : "+wifi 	 +" cabinet : "+cabinet);
		
		//------------------------------- 남은 컬럼들		
		String startTime = request.getParameter("startTime"); // 시작시간
		String usingTime = request.getParameter("usingTime"); // 이용시간
		
		System.out.println("email : "+email+" startTime : "+startTime+" usingTime :"+usingTime );
		
		// request 영역에서 꺼내온 데이터들을 BookinDTO에 담는다.
		BookingDTO boodto = new BookingDTO();
		
		boodto.setRoom_no(Integer.parseInt(room_no));
		boodto.setEmail(email);
		boodto.setBook_phone(book_phone);
		// Timestamp로 날짜 포멧 변경
		Timestamp ts_date = null;
		Date sel_date = null;
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		try {
			sel_date = sd.parse(selectDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ts_date = new Timestamp(sel_date.getTime());
		boodto.setBook_date(ts_date);
		boodto.setBook_time(Integer.parseInt(startTime));
		boodto.setBook_hour(Integer.parseInt(usingTime));
		boodto.setParking(parking);
		boodto.setWifi(wifi);
		boodto.setProjector(projector);
		boodto.setLaptop(laptop);
		boodto.setCabinet(cabinet);
		boodto.setTotal_price(Integer.parseInt(totalPay));
		
		
		// 예약정보를 DB에 저장한다.
		int book_flag = boodao.setBookingInsert(boodto);
		if(book_flag ==1){
			System.out.println("booking insert 정상 작동");
		}		
		
		//---------------------------------booking 테이블
		
		//---------------------------------booking_time 테이블
		
		StringTokenizer st = new StringTokenizer(selectTime, ",");
		
		System.out.println("selectTime : "+selectTime );
		System.out.println("countTokens : "+st.countTokens() );
				
		BookingTimeDTO btdto = new BookingTimeDTO();
		
		// 에약이 먼저 insert 되고 난 후 시간을 insert 하므로 가장 높은 예약 번호를 가져와서 
		// 그 번호를 BookingTime Book_no로 사용
		int maxNo = boodao.maxBookNo();
		System.out.println("maxNo :"+maxNo);
		btdto.setBook_no(maxNo);
		btdto.setBook_date(ts_date);
		// BookingTimeDTO 시간 저장
		while(st.hasMoreTokens()){			
			switch (st.nextToken()) {
			case "1":
				btdto.setT10(1);
				System.out.println("10시 저장");
				break;
			case "2":
				btdto.setT11(1);
				System.out.println("11시 저장");
				break;
			case "3":
				btdto.setT12(1);
				System.out.println("12시 저장");
				break;
			case "4":
				btdto.setT13(1);
				System.out.println("13시 저장");
				break;
			case "5":
				btdto.setT14(1);
				System.out.println("14시 저장");
				break;
			case "6":
				btdto.setT15(1);
				System.out.println("15시 저장");
				break;
			case "7":
				btdto.setT16(1);
				System.out.println("16시 저장");
				break;
			case "8":
				btdto.setT17(1);
				System.out.println("17시 저장");
				break;
			case "9":
				btdto.setT18(1);
				System.out.println("18시 저장");
				break;
			case "10":
				btdto.setT19(1);
				System.out.println("19시 저장");
				break;
			case "11":
				btdto.setT20(1);
				System.out.println("20시 저장");
				break;
			case "12":
				btdto.setT21(1);
				System.out.println("21시 저장");
				break;
			} // switch 끝
			
		}// while 끝
		
		
		// booking_time 테이블에서 예약시간 정보 저장하기
		int bookTime_flag = 0;
		
		book_flag = boodao.setBooking_TimeInsert(btdto);
		
		if(bookTime_flag == 1){
			System.out.println("booking_time insert 정상작동");
		}
		
		
		RequestDispatcher dis = request.getRequestDispatcher("booking/booking_next.jsp");		
		dis.forward(request, response);
		
	}// doPro 끝
	

}
