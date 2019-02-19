package alertUser;

import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import booking.BookingDTO;

public class AlertDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	// 커넥션 풀을 담을 변수 선언
	DataSource ds = null;
	// 생성자
	public AlertDAO() {
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
		}if(con != null){
			try {
				con.close();
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		
	}

	public JSONArray getTodayBook(String email) {
		JSONArray jarray = new JSONArray();
		JSONObject jdto;
		Date date = Date.valueOf(LocalDate.now());
		int hour = LocalDateTime.now().getHour();
		try{
			con = ds.getConnection();
			String sql = "select b.book_no, b.room_no, b.book_time, "
						+"		 b.book_hour, b.total_price, h.subject, h.room_type "
						+"from booking b " 
						+"join hosting h "
						+"on b.room_no = h.room_no "
						+"where book_date=? and book_time>? and email=?" ;
			pstmt = con.prepareStatement(sql);
			pstmt.setDate(1, date);
			pstmt.setInt(2, hour);
			pstmt.setString(3, email);
			rs = pstmt.executeQuery();
			while(rs.next()){
				jdto = new JSONObject();
				jdto.put("book_no", rs.getInt("book_no"));
				jdto.put("room_no", rs.getInt("room_no"));
				jdto.put("book_time", rs.getInt("book_time"));
				jdto.put("book_hour", rs.getInt("book_hour"));
				jdto.put("total_price", rs.getInt("total_price"));
				jdto.put("subject", rs.getString("subject"));
				jdto.put("room_type", rs.getString("room_type"));
				
				jarray.add(jdto);
			}
			
			System.out.println(jarray.size());
		}catch(Exception e){
			System.out.println("getTodayBook에서 에러"+e);
		}finally{
			freeResource();
		}
		
		return jarray;
	}

	public int getNextDayBook(String email) {
	
		Date date = Date.valueOf(LocalDate.now().plusDays(1));
		System.out.println(date);
		try{
			con = ds.getConnection();
			String sql = "select count(*) from booking "
						+"where email=? and book_date =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setDate(2, date);
			rs = pstmt.executeQuery();
		
			if(rs.next()){
				return rs.getInt(1);
			}
		}catch(Exception e){
			System.out.println("getNextDayBook에서 오류"+e);
		}finally{
			freeResource();
		}
			return 0;
	}

	public JSONArray getTodayRoomBook(String host_id) {
		JSONArray todayBook = new JSONArray();
		Date date = Date.valueOf(LocalDate.now());
		int hour = LocalDateTime.now().getHour();
		JSONObject jdto;
		try{
			con = ds.getConnection();
			String sql = "select b.book_no, b.room_no, b.book_time, b.book_hour, b.total_price, h.subject "
						+"from booking b "
						+"join hosting h "
						+"on b.room_no = h.room_no "
						+"where book_date=? and book_time>? and host_id=? "
						+"order by book_time ";
			pstmt = con.prepareStatement(sql);
			pstmt.setDate(1, date);
			pstmt.setInt(2, hour);
			pstmt.setString(3, host_id);
			rs = pstmt.executeQuery();
			while(rs.next()){
				jdto = new JSONObject();
				jdto.put("book_no", rs.getInt("book_no"));
				jdto.put("room_no", rs.getInt("room_no"));
				jdto.put("book_time", rs.getInt("book_time"));
				jdto.put("book_hour", rs.getInt("book_hour"));
				jdto.put("total_price", rs.getInt("total_price"));
				jdto.put("subject", rs.getString("subject"));
				
				todayBook.add(jdto);
			}

		}catch(Exception e){
			System.out.println("getNextDayBook에서 오류"+e);
		}finally{
			freeResource();
		}



		return todayBook;
	}

	public int getNextRoomBook(String host_id) {
//		String date = String.valueOf(LocalDate.now().plusDays(1));
		Date date = Date.valueOf(LocalDate.now().plusDays(1));
//		date=date.replaceAll("-", "");
		System.out.println(date);
		try{
			
			con = ds.getConnection();

			String sql = "select count(*) from booking b"
						+"join hosting h "
						+"on b.room_no = h.room_no "
						+"where h.host_id=? and b.book_date =? ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, host_id);
			pstmt.setDate(2, date);
			rs = pstmt.executeQuery();
		
			if(rs.next()){
				System.out.println("호스트 다음날 개수"+rs.getInt(1));
				return rs.getInt(1);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("getNextRoomBook에서 오류"+e);
		}finally{
			freeResource();
		}
			return 0;
	}
		
}
