package booking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BookingDAO {

	
	// DB 작업 객체
		private Connection con;
		private PreparedStatement pstmt;
		private ResultSet rs;
		
		
		// 커넥션 풀을 담을 변수 선언
		DataSource ds = null;
		// 생성자
		public BookingDAO() {
			// TODO Auto-generated constructor stub
			try {
				// 1. Was서버와 연결된 웹프로젝트의 모든정보를 가지고 있는 컨텍스트 객체 생성
				Context init = new InitialContext();
				// 2. 연결된 Was서버에서 DataSource(커넥션 풀)을 검색해서 얻기
				ds = (DataSource)init.lookup("java:comp/env/jdbc/sharespace");
				
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println("커넥션풀 가져오기 실패 : "+e);
			}
		}// 생성자 끝
		
		// 리소스 반납(해제) 메서드
		public void freeResource(){
			if(con != null){
				try {
					con.close();
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
			}
			if(rs != null){
				try {
					rs.close();
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
			}if(pstmt != null){
				try {
					pstmt.close();
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
			}
		}

		public BookingDTO getPreBookingList(String roomNumber) {
			// TODO Auto-generated method stub
			
				BookingDTO boodto = new BookingDTO();
			
			try {
				System.out.println("다오왔다");
				
				con = ds.getConnection();
				
				String sql = "SELECT h.subject, h.people, h.content, hp.pic1,"
						+ " ho.parking, ho.wifi, ho.projector, "
						+ "ho.laptop, ho.cabinet "
						+ "FROM hosting h join hosting_pic hp on h.room_no = hp.room_no "
						+ "join hosting_option ho on h.room_no = ho.room_no "
						+ "WHERE h.room_no=?";				
				
				pstmt = con.prepareStatement(sql);
				
				if(roomNumber.equals("")){
					roomNumber = "1";
				}
				
				pstmt.setString(1, roomNumber);
				
				System.out.println(pstmt.toString());
				
				rs = pstmt.executeQuery();
				
				rs.next();			
				
				boodto.setRoom_no(Integer.parseInt(roomNumber));				
				boodto.setPeople(rs.getString("people"));
				boodto.setSubject(rs.getString("subject"));
				boodto.setContent(rs.getString("content"));
				boodto.setPic1(rs.getString("pic1"));
				boodto.setParking(rs.getInt("parking"));
				boodto.setWifi(rs.getInt("wifi"));
				boodto.setProjector(rs.getInt("projector"));
				boodto.setLaptop(rs.getInt("laptop"));
				boodto.setCabinet(rs.getInt("cabinet"));
				
				return boodto;
				
			} catch (Exception e) {
				System.out.println("getPreBookingList() 메서드에서 "+e);
			} finally{
				freeResource();
			}	
			
			return null;
		}
		// 제일 마지막 Booking 번호 가져오기
		public int maxBookNo() {
			// TODO Auto-generated method stub
			
			try {
				
				con = ds.getConnection();
				
				String sql = "SELECT max(book_no) FROM booking";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				rs.next();
				
				int maxNo = rs.getInt(1);
				
				return maxNo;
			} catch (Exception e) {
				System.out.println("maxBookNo()"+e);
			} finally{
				freeResource();
			}			
			
			return 0;
		}
		// booking 테이블에 예약정보를 저장한다.
		public int setBookingInsert(BookingDTO boodto) {
			
			int book_flag=0;
			
			try {
				
				con = ds.getConnection();
				
				String sql = "INSERT INTO booking(book_no, room_no, email, book_phone, book_date, book_time,"
						+ " book_hour, book_parking, book_wifi, book_projector, book_laptop,book_cabinet, total_price,"
						+ " book_check) VALUES(0,?,?,?,?,?,?,?,?,?,?,?,?,0)";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, boodto.getRoom_no());
				pstmt.setString(2, boodto.getEmail());
				pstmt.setString(3, boodto.getBook_phone());
				pstmt.setTimestamp(4, boodto.getBook_date());
				pstmt.setInt(5, boodto.getBook_time());
				pstmt.setInt(6, boodto.getBook_hour());
				pstmt.setInt(7, boodto.getParking());
				pstmt.setInt(8, boodto.getWifi());
				pstmt.setInt(9, boodto.getProjector());
				pstmt.setInt(10, boodto.getLaptop());
				pstmt.setInt(11, boodto.getCabinet());
				pstmt.setInt(12, boodto.getTotal_price());
				System.out.println(pstmt.toString());
				
				book_flag = pstmt.executeUpdate();
				
				return book_flag;
				
				
			} catch (Exception e) {
				System.out.println("setBookingInsert()메서드에서  "+e );
			} finally{
				freeResource();
			}		
			
			return 0;
		}// setBookingInsert() 끝
		
		
		// Booking_Time 테이블에 예약시간 저장하기
		public int setBooking_TimeInsert(BookingTimeDTO btdto) {
			// TODO Auto-generated method stub
			int bookTime_flag=0;
			
			try {
				
				con = ds.getConnection();
				
				String sql = "INSERT INTO booking_time(book_no, book_date, t10, t11, t12, "
						+ "t13, t14, t15, t16, t17, t18, t19, t20, t21) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, btdto.getBook_no());
				pstmt.setTimestamp(2, btdto.getBook_date());
				pstmt.setInt(3, btdto.getT10());
				pstmt.setInt(4, btdto.getT11());
				pstmt.setInt(5, btdto.getT12());
				pstmt.setInt(6, btdto.getT13());
				pstmt.setInt(7, btdto.getT14());
				pstmt.setInt(8, btdto.getT15());
				pstmt.setInt(9, btdto.getT16());
				pstmt.setInt(10, btdto.getT17());
				pstmt.setInt(11, btdto.getT18());
				pstmt.setInt(12, btdto.getT19());
				pstmt.setInt(13, btdto.getT20());
				pstmt.setInt(14, btdto.getT21());
				
				System.out.println(pstmt.toString());
				
				bookTime_flag = pstmt.executeUpdate();
				
				return bookTime_flag;
				
			} catch (Exception e) {
				System.out.println("setBooking_TimeInsert() 메서드에서"+e);
			} finally{
				freeResource();
			}
			
			return 0;
		}// setBooking_TimeInsert() 메서드 끝

		public void setUserPointUpdate(String email, int setPoint) {
			// TODO Auto-generated method stub
			
			try {
				
				con = ds.getConnection();
				
				String sql = "UPDATE user SET point = ? WHERE email = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, setPoint);
				pstmt.setString(2, email);
				
				System.out.println(pstmt.toString());
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				System.out.println("setUserPointUpdate() 메서드에서"+ e);
			} finally {
				freeResource();
			}
			
			
		}// setUserPointUpdate() 메서드 끝

		// 예약 취소 메서드
		public int setBookingCancel(String email, String book_no, int total_price) {
			
			int result = 0;
			
			try {
				con = ds.getConnection();
				
				// Booking테이블의 book_no에 해당하는 book_check 컬럼을 1로 변경
				String sql = "UPDATE booking SET book_check = 1 WHERE book_no = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, book_no);
				result = pstmt.executeUpdate();
				
				// 포인트 회수 
				sql = "UPDATE user SET point = point + ? WHERE email = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, total_price);
				pstmt.setString(2, email);
				pstmt.executeUpdate();
				
				return result;
			} catch (Exception e) {
				System.out.println("setBookingCancel() 메서드에서 "+e);
			} finally {
				freeResource();
			}
			
			return 0;
		}// setBookingCancel() 메서드 끝
		
		
		
		
		
	
}
