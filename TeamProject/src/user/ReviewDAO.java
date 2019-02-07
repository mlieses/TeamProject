package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReviewDAO {

	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;

	// 커넥션풀을 담을 변수 선언
	private DataSource ds;

	// 생성자
	public ReviewDAO() {
		try {
			// 1.Was서버와 연결된 웹프로젝트의 모든정보를 가지고 있는 컨텍스트객체 생성
			Context init = new InitialContext();

			// 2.연결된 Was서버에서 DataSource(커넥션풀)을 검색해서 얻기
			ds = (DataSource) init.lookup("java:comp/env/jdbc/sharespace");

		} catch (Exception e) {
			System.out.println("커넥션풀 가져오기 실패 : " + e);
			e.printStackTrace();
		}
	}

	// 리소스 반납 (해제)메소드
	public void freeResource() {
		if (con != null) {
			try {
				con.close();
			} catch (Exception err) {
				err.printStackTrace();
			}
		}
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception err) {
				err.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception err) {
				err.printStackTrace();
			}
		}
	}// 생성자 끝
	
	
	public int addReview(String book_no, String room_no, String email, String re_point, String re_content){
		int result = 0;
		Date now = new Date();
		String nowDateS = null;
		SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
		try {
			nowDateS = fm.format(now);
//			System.out.println(nowDateS);

			con = ds.getConnection();	
			System.out.println("연결됨");
			String sql = "insert into review(book_no, room_no, email, re_date, re_point, re_content) "
						+"value(?,?,?,?,?,?)";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(book_no));
			pstmt.setInt(2, Integer.parseInt(room_no));
			pstmt.setString(3, email);
			pstmt.setString(4, nowDateS);
			pstmt.setInt(5, Integer.parseInt(re_point));
			pstmt.setString(6, re_content);
			
			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			System.out.println("addReview() 연결 오류");
			e.printStackTrace();
		} finally {
			freeResource();
		}
		
		
	
		return result;
	
	
	}
	
}
