package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class HostingReviewDAO {

	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;

	// 커넥션풀을 담을 변수 선언
	private DataSource ds;

	// 생성자
	public HostingReviewDAO() {
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
	
	
	/**호스트 별 공간 정보_ 기본 정보 + 평점 */
	public ArrayList<HostingReviewInfoDTO> SpaceList(String host_id){
		ArrayList<HostingReviewInfoDTO> SList = new ArrayList<HostingReviewInfoDTO>();
		
		try {
			con = ds.getConnection();	
			
			String sql = "select * from hosting h join hosting_pic p " 
						+"on h.room_no = p.room_no "
						+"where host_id = ? "
						+"order by h.room_no asc "; 
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, host_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				HostingReviewInfoDTO dto = new HostingReviewInfoDTO();
				
				
				dto.setRoom_no(rs.getInt("room_no"));
				dto.setHost_id(host_id);
				dto.setSubject(rs.getString("subject"));
				dto.setRoom_type(rs.getString("room_type"));
				dto.setPic1(rs.getString("pic1"));
				
			
				SList.add(dto);
	

			}
			
		
		} catch (SQLException e) {
			System.out.println("SpaceList"+e);
			e.printStackTrace();
		} finally {
			freeResource();
		}
		
		return null;
	}
	
	public ArrayList<HostingReviewDTO> SpaceList(String host_id, String room_no){
		return null;
	}
	
	
	
}
