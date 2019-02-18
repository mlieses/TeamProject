package noticeBoard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
public class ReBoardDAO {
	// DB 작업 객체
		private Connection con;
		private PreparedStatement pstmt;
		private ResultSet rs;
		
		
		// 커넥션 풀을 담을 변수 선언
		DataSource ds = null;
		// 생성자
		public ReBoardDAO() {
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
		
		// 전체 게시글 갯수 가져오는 메서드
		public int getBoardCount(){
			System.out.println("전체 게시글 메서드");
			String sql="";
			int count=0;
			try {
				//1,2 디비연결  메서드호출
				con = ds.getConnection();
				//3 sql count(*)
				sql="select count(*) from notice";
				pstmt=con.prepareStatement(sql);
				//4 rs = 실행 저장
				rs=pstmt.executeQuery();
				//5 rs 첫행이동 데이터있으면  count=저장
				if(rs.next()){
					count=rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				freeResource();
			}
			return count;
		}
		// 모든 행의 DTO
		public List<ReBoardDTO> getBoardList(int startRow,int pageSize){
			System.out.println("리스트 메서드");
			String sql="";
			List<ReBoardDTO> boardList=new ArrayList<ReBoardDTO>();
			try{
				//1,2 디비연결
				con= ds.getConnection();
				//3 sql 전체 board 글가져오기  
				sql = "SELECT * FROM notice order by notice_date desc, notice_no desc limit ?,?";
				pstmt=con.prepareStatement(sql);				
				pstmt.setInt(1, startRow-1);
				pstmt.setInt(2, pageSize);
				//4 rs = 실행 저장
				rs=pstmt.executeQuery();
				//5 rs 다음행이동 데이터 있으면  ReBoardDTO rb 객체 생성
				//    bb 멤버변수  <-  rs 열을 저장
				//  배열 boardList 한칸 저장
				while(rs.next()){
					ReBoardDTO rb=new ReBoardDTO();
					rb.setNotice_no(rs.getInt(1));
					rb.setAdmin(rs.getString(2));
					rb.setNotice_subject(rs.getString(3));
					rb.setNotice_content(rs.getString(4));
					rb.setNotice_date(rs.getDate(5));
					rb.setNotice_hit(rs.getInt(6));
					boardList.add(rb);
				}
			}catch(Exception e){
				e.printStackTrace();
			}finally {
				freeResource();
			}
			return boardList;
		}
		
		public void updateHit(int notice_no) {
			try {
				con = ds.getConnection();
				String sql = "update notice set notice_hit=notice_hit+1 where notice_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, notice_no);
				pstmt.executeUpdate();
				
			}catch(SQLException e){
				System.out.println("updateHit에서 오류"+e);
			}finally{
				freeResource();
			}
		}

		public ReBoardDTO getRead(int notice_no) {
			ReBoardDTO rb=new ReBoardDTO();
			try {
				con = ds.getConnection();
				String sql = "select * from notice where notice_no =?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, notice_no);
				rs = pstmt.executeQuery();
				if(rs.next()){
					rb.setNotice_no(rs.getInt(1));
					rb.setAdmin(rs.getString(2));
					rb.setNotice_subject(rs.getString(3));
					rb.setNotice_content(rs.getString(4));
					rb.setNotice_date(rs.getDate(5));
					rb.setNotice_hit(rs.getInt(6));
				}
			} catch (SQLException e) {
				System.out.println("getRead에서 오류"+e);
			}finally{
				freeResource();
			}
			return rb;
		}

		public void insertNotice(String subject, String content) {
			try{
				con = ds.getConnection();
				String sql = "insert into notice values(0, 'admin', ?, ?, now(), 0) ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, subject);
				pstmt.setString(2, content);
				pstmt.executeUpdate();
				
			}catch(Exception e){
				System.out.println("insertNotice에서 오류"+e);
			}finally{
				freeResource();
			}
			
		}

		public ReBoardDTO updateNotice(int notice_no, String subject, String content) {
			ReBoardDTO rb = new ReBoardDTO();
			try{
				con = ds.getConnection();
				String sql = "update notice set notice_subject=?, notice_content=? where notice_no=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, subject);
				pstmt.setString(2, content);
				pstmt.setInt(3, notice_no);
				pstmt.executeUpdate();
				
				freeResource();
				
				con = ds.getConnection();
				sql = "select * from notice where notice_no=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, notice_no);
				rs = pstmt.executeQuery();
				if(rs.next()){
					rb.setNotice_no(rs.getInt(1));
					rb.setAdmin(rs.getString(2));
					rb.setNotice_subject(rs.getString(3));
					rb.setNotice_content(rs.getString(4));
					rb.setNotice_date(rs.getDate(5));
					rb.setNotice_hit(rs.getInt(6));
				}
				
				
			}catch(Exception e){
				System.out.println("insertNotice에서 오류"+e);
			}finally{
				freeResource();
			}
		return rb;	
		}

		public void deleteNotice(int notice_no) {
			try{
				con = ds.getConnection();
				String sql = "delete from notice where notice_no=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, notice_no);
				pstmt.executeUpdate();
				
			}catch(Exception e){
				System.out.println("deleteNotice에서 오류"+e);
			}finally{
				freeResource();
			}
		}
}
