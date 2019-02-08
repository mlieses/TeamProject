package app.mvc.board;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.InitialContext;
//�꽑�뼵臾�
import javax.sql.*;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;


//�떎�젣 寃뚯떆�뙋 DB�옉�뾽 �븷 �옄諛붾퉰 �겢�옒�뒪
public class BoardDAO {

	private InitialContext init;
	private java.sql.Statement stmt;
	private DataSource ds;
	private java.sql.Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//db�뿰寃� �깮�꽦�옄
	public BoardDAO(){
		
		try {
			//1. WAS�꽌踰꾩� �뿰寃곕맂 MCVBoard�쎒�봽濡쒖젥�듃�쓽 紐⑤뱺 �젙蹂대�� 媛�吏�怨� �엳�뒗 而⑦뀓�뒪�듃媛앹껜 �깮�꽦
			//META-INF�뤃�뜑�쓽 context�깭洹몄쓽 媛앹껜
			init = new InitialContext();
			
			//2. �뿰寃곕맂 WAS�꽌踰꾩뿉�꽌 DataSource(而ㅻ꽖�뀡��) 寃��깋�빐�꽌 媛��졇�삤湲�
			ds = (DataSource) init.lookup("java:comp/env/jdbc/sharespace");
			
		} catch (Exception err) {
			System.out.println("而ㅻ꽖�뀡�� 寃��깋 �삤瑜� : "+err);
		}
	}//�깮�꽦�옄 �걹

	/* List.jsp�럹�씠吏��뿉�꽌 �븘�슂�븳 硫붿냼�뱶 2媛� 留뚮뱾湲� */
	
	// �쟾泥� 湲� 媛쒖닔 諛섑솚 (�쁽�옱 寃뚯떆�뙋�뿉 ���옣�릺�뼱 �엳�뒗 ) (-->�럹�씠吏� 湲곗닠�뿉 �궗�슜)
	public int getTotalRecord(){
		// �쟾泥� 湲� 媛쒖닔 ���옣 (寃뚯떆�뙋 寃��깋 �썑 ���옣�맂)
		int total = 0;
		//寃뚯떆�뙋 �뀒�씠釉붿쓽 �쟾泥대젅肄붾뱶 �닔 援ы븯湲�
		String sql = "select count(*) from tblBoard2";
		
		try {
			//DB�뿰寃�
			con = ds.getConnection();
			//select瑜� �떎�뻾�븷 Statement媛앹껜 諛섑솚
			stmt = con.createStatement();
			//select寃��깋 �썑 寃��깋�븳 寃곌낵 �쟾泥� �젅肄붾뱶 媛쒖닔瑜� �뀒�씠釉� �삎�떇�쑝濡� ���옣�븳 ResultSet媛앹껜 諛섑솚
			rs = stmt.executeQuery(sql);
			//留뚯빟 寃��깋�븳 �쟾泥� 湲�媛쒖닔媛� �엳�떎硫�
			if (rs.next()) {
				//�쟾泥� 湲�媛쒖닔 ���옣
				total = rs.getInt(1);
				
			}
		} catch (Exception e) {
			System.out.println("getTotalRecord : �뿉�꽌 �삤瑜� "+e);
		}finally {
			try {
				if(rs != null){
					rs.close();
				}
			} catch (SQLException err) {

			}
			try {
				if(stmt != null){
					stmt.close();
				}
			} catch (SQLException err) {

			}
			try {
				if(con != null){
					con.close();
				}
			} catch (Exception err) {

			}
		}//finally �걹
		
		return total; //寃뚯떆�뙋�뿉 ���옣�맂 珥� 湲�媛쒖닔 諛섑솚
		
	}//getTotal �걹
	/* �쁽�옱 寃뚯떆�뙋�뿉 �엳�뒗 紐⑤뱺 湲��뱾�쓣 ArrayList�뿉 �떞�븘 ArrayList�옄泥대�� 由ы꽩 */
	public List BoardList(){
		//b_group瑜� 湲곗��쑝濡� �삤由꾩감�닚 �젙�젹�븯�뿬 寃��깋
		String sql = "select * from tblBoard2 order by b_group asc";
		//select�븳 DTO媛앹껜瑜� ���뿉 �떞湲�
		List list = new ArrayList();
		
	
		try {
			//DB�뿰寃�
			con = ds.getConnection();
			//select瑜� �떎�뻾�븷 Statement媛앹껜 諛섑솚
			stmt = con.createStatement();
			//select寃��깋 �썑 寃��깋�븳 寃곌낵 �쟾泥� �젅肄붾뱶 媛쒖닔瑜� �뀒�씠釉� �삎�떇�쑝濡� ���옣�븳 ResultSet媛앹껜 諛섑솚
			rs = stmt.executeQuery(sql);
			
			while (rs.next()){
				BoardDto dto = new BoardDto();
				dto.setB_idx(rs.getInt("b_idx"));
				dto.setB_id(rs.getString("b_id"));
				dto.setB_pw(rs.getString("b_pw"));
				dto.setB_name(rs.getString("b_name"));
				dto.setB_email(rs.getString("b_email"));
				dto.setB_title(rs.getString("b_title"));
				dto.setB_content(rs.getString("b_content"));
				dto.setB_group(rs.getInt("b_group"));
				dto.setB_level(rs.getInt("b_level"));
				dto.setB_date(rs.getString("b_date"));
				dto.setB_cnt(rs.getInt("b_cnt"));
				
				list.add(dto); //dto瑜� ArrayList�뿉 �떞�뒗�떎
			}
			
		} catch (Exception e) {
			System.out.println("BoardList()�뿉�꽌 �삤瑜� : "+e);
			
		}finally {
			try {
				if(rs != null){
					rs.close();
				}
			} catch (SQLException err) {

			}
			try {
				if(stmt != null){
					stmt.close();
				}
			} catch (SQLException err) {

			}
			try {
				if(con != null){
					con.close();
				}
		}catch(SQLException err){
			
		}
			
			
	}//finally �걹
	
	//�쁽�옱 寃뚯떆�뙋�뿉 �엳�뒗 紐⑤뱺 湲��뱾�쓣 ArrayList�뿉 �떞�븘 ArrayList�옄泥대�� 由ы꽩
	return list;

	}//BoardList()�걹	
	/* �쁽�옱 寃뚯떆�뙋�뿉 �엳�뒗 紐⑤뱺 湲��뱾�쓣 ArrayList�뿉 �떞�븘 ArrayList�옄泥대�� 由ы꽩 */
	public List BoardList(String k, String w){
		//b_group瑜� 湲곗��쑝濡� �삤由꾩감�닚 �젙�젹�븯�뿬 寃��깋
		String sql = "select * from tblBoard2 order by b_group asc";
		//select�븳 DTO媛앹껜瑜� ���뿉 �떞湲�
		List list = new ArrayList();
		
		//寃��깋�뼱瑜� �엯�젰�뻽�떎硫�
		if(!w.equals("")){
			//寃��깋湲곗�媛� = �젣紐�+�궡�슜
			if(k.equals("titleContent")){
				//湲��젣紐� 以묒뿉 寃��깋�뼱媛� �븳�옄�씪怨� �뱾�뼱媛� �엳�뒗 湲��뱾�쓣 寃��깋 --> �떒, 湲�踰덊샇瑜� 湲곗��쑝濡� �궡由쇱감�닚 �젙�젹�븯�뿬 寃��깋
				sql = "select * from tblBoard2 where "
						+ "b_title like '%" + w + "%' or b_content like '%" + w + "%' order by b_group asc";
			}else{ //�옉�꽦�옄�씠硫�, 湲� �옉�꽦�옄 以묒뿉 �젏�깋�뼱媛� �븳�옄�씪�룄 �뱾�뼱媛� �엳�뒗 湲��뱾�쓣 寃��깋
				sql = "select * from tblBoard2 where b_name like '%" + w + "%' order by b_group asc";				
			}
		//寃��깋�뼱瑜� �엯�젰�븯吏� �븡�븯�떎硫�
		}else{
			//紐⑤뱺 湲� 寃��깋
			//sql = "select * from tblBoard2 order by b_idx desc";
			sql = "select * from tblBoard2 order by b_group asc"; //湲�踰덊샇 湲곗� �궡由쇱감�닚
		}
		
		try {
			//DB�뿰寃�
			con = ds.getConnection();
			//select瑜� �떎�뻾�븷 Statement媛앹껜 諛섑솚
			stmt = con.createStatement();
			//select寃��깋 �썑 寃��깋�븳 寃곌낵 �쟾泥� �젅肄붾뱶 媛쒖닔瑜� �뀒�씠釉� �삎�떇�쑝濡� ���옣�븳 ResultSet媛앹껜 諛섑솚
			rs = stmt.executeQuery(sql);
			
			while (rs.next()){
				BoardDto dto = new BoardDto();
				dto.setB_idx(rs.getInt("b_idx"));
				dto.setB_id(rs.getString("b_id"));
				dto.setB_pw(rs.getString("b_pw"));
				dto.setB_name(rs.getString("b_name"));
				dto.setB_email(rs.getString("b_email"));
				dto.setB_title(rs.getString("b_title"));
				dto.setB_content(rs.getString("b_content"));
				dto.setB_group(rs.getInt("b_group"));
				dto.setB_level(rs.getInt("b_level"));
				dto.setB_date(rs.getString("b_date"));
				dto.setB_cnt(rs.getInt("b_cnt"));
				
				((ArrayList) list).add(dto); //dto瑜� ArrayList�뿉 �떞�뒗�떎
			}
			
		} catch (Exception e) {
			System.out.println("BoardList()�뿉�꽌 �삤瑜� : "+e);
			
		}finally {
			try {
				if(rs != null){
					rs.close();
				}
			} catch (SQLException err) {

			}
			try {
				if(stmt != null){
					stmt.close();
				}
			} catch (SQLException err) {

			}
			try {
				if(con != null){
					con.close();
				}
		}catch(SQLException err){
			
		}
	}//finally �걹
	
	//�쁽�옱 寃뚯떆�뙋�뿉 �엳�뒗 紐⑤뱺 湲��뱾�쓣 ArrayList�뿉 �떞�븘 ArrayList�옄泥대�� 由ы꽩
	return list;

	}//BoardList()�걹

	// 湲�異붽� 硫붿냼�뱶 : BoardController�뿉�꽌 留뚮뱺 boardInsert()硫붿냼�뱶.
	public void boardInsert(BoardDto dto) {		
		System.out.println("dao 0");
		//�깉湲� 異붽��븯湲곗쟾 湲곗〈�쓽 湲��뱾�� 臾댁“嫄� group媛믪쓣 +1利앷� �떆�궓�떎
		groupUp();
			
		//寃뚯떆�뙋�뿉 ���옣�맂 媛��옣 理쒓렐�뿉 異붽��븳 媛��옣 �겙 湲�踰덊샇 媛��졇�삤湲�
		String sql ="select max(b_idx) from tblBoard2";
		System.out.println("dao 1");
		String insertSql = "insert into tblBoard2(b_idx, b_id, b_pw, b_name, b_email, b_title,"
				+ " b_content, b_group, b_level, b_date, b_cnt)"
				+ " values(?,?,?,?,?,?,?,?,?,now(),?)";
		int idx = 0; //異붽��븷 湲� 踰덊샇 ���옣
		System.out.println("dao 2");
		try {
			//DB�뿰寃�
			con = ds.getConnection();
			//select荑쇰━瑜� �떞�� pstmt : 寃뚯떆�뙋�뿉 ���옣�맂 媛��옣 理쒓렐�뿉 異붽��븳 媛��옣 �겙 湲�踰덊샇 媛��졇�삤湲�
			pstmt = con.prepareStatement(sql);
			//select寃��깋 �썑 寃��깋�븳 寃곌낵 �쟾泥� �젅肄붾뱶 媛쒖닔瑜� �뀒�씠釉� �삎�떇�쑝濡� ���옣�븳 ResultSet媛앹껜 諛섑솚
			rs = pstmt.executeQuery();
			System.out.println("dao 3");
			//寃뚯떆�뙋�뿉 ���옣�맂 湲��쓽 媛��옣 �겙 湲�踰덊샇媛� �엳�쓣 寃쎌슦
			if (rs.next()) {
				//湲��씠 �엳�쓣寃쎌슦 �깉濡� 異붽��븷 湲� 踰덊샇瑜� ? 媛��옣�겙 湲�踰덊샇 +1 吏��젙
				idx = rs.getInt(1) +1;
			}else{//媛��옣 �겙 湲� 踰덊샇媛� �뾾�쓣寃쎌슦 (寃뚯떆�뙋�뿉 ���옣�맂 湲��쓽)
				//洹몃쭅 �뾾�쓣 寃쎌슦 �깉濡� 異붽��븷 湲� 踰덊샇瑜�? 1濡� 吏��젙
				idx = 1;
				System.out.println("dao 4");
			}
			//insert
			pstmt = con.prepareStatement(insertSql);
			//????�뀑�똿
			pstmt.setInt(1, idx);
			pstmt.setString(2, dto.getB_id());
			pstmt.setString(3, dto.getB_pw());
			pstmt.setString(4, dto.getB_name());
			pstmt.setString(5, dto.getB_email());
			pstmt.setString(6, dto.getB_title());
			pstmt.setString(7, dto.getB_content());
			pstmt.setInt(8, dto.getB_group());
			pstmt.setInt(9, dto.getB_level());
			pstmt.setInt(10, dto.getB_cnt());
			
			pstmt.executeUpdate();
			System.out.println("dao 5");
		}
		catch(Exception e){
			System.out.println("BoardInsert: "+e);
		}
		finally {
			try {rs.close();} catch (SQLException err) {}
			try {pstmt.close();} catch (SQLException err) {}
			try {con.close();} catch (SQLException err) {}
		}			
			
		}//BoardInsert 硫붿냼�뱶

	//�븯�굹�쓽 湲� �긽�꽭蹂닿린 硫붿냼�뱶
	public BoardDto boardRead(String idx) {
		String sql = "select * from tblBoard2 where b_idx = "+ idx;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				BoardDto dto = new BoardDto();
				dto.setB_idx(rs.getInt("b_idx"));
				dto.setB_id(rs.getString("b_id"));
				dto.setB_pw(rs.getString("b_pw"));
				dto.setB_name(rs.getString("b_name"));
				dto.setB_email(rs.getString("b_email"));
				dto.setB_title(rs.getString("b_title"));
				dto.setB_content(rs.getString("b_content"));
				dto.setB_group(rs.getInt("b_group"));
				dto.setB_level(rs.getInt("b_level"));
				dto.setB_date(rs.getString("b_date"));
				dto.setB_cnt(rs.getInt("b_cnt"));
				
				return dto;
			}
		} catch (Exception e) {
			System.out.println("boardRead : " +e);
		}
		finally{
			try {rs.close();} catch (SQLException err) {}
			try {pstmt.close();} catch (SQLException err) {}
			try {con.close();} catch (SQLException err) {}
		}
		return null;		
	}
	//湲� �닔�젙 硫붿냼�뱶
	public void boardModify(BoardDto dto) {
		// �닔�젙�븷 湲� 踰덊샇�뿉 �빐�떦�븯�뒗 湲��쓽 湲��젣紐�, 湲��궡�슜 �닔�젙
		String sql = "update tblBoard2 set b_title=?, b_content=? where b_idx=?";
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql); //?瑜� �젣�쇅�븳 sql臾몄옣�쓣 pstmt�뿉 �떞�븘�넃怨� pstmt�옄泥대�� 諛섑솚 �빐�꽌 ���옣
			//? ? 媛� �꽭�똿
			pstmt.setString(1, dto.getB_title());
			pstmt.setString(2, dto.getB_content());
			pstmt.setInt(3, dto.getB_idx());
			//update�떎�뻾
			pstmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("boardModify硫붿냼�뱶�뿉�꽌 �삤瑜�: " +e);
		}
		finally {
			try{pstmt.close();} catch(SQLException err){}
			try{con.close();} catch(SQLException err){}
		}
	}
	/*	遺�紐④��뿉 ���븳 �떟蹂�湲� �옉�꽦�떆 遺�紐④��쓽 group媛믪뿉 +1
	 	遺�紐④� 蹂대떎 癒쇱� �옉�꽦�맂 湲��뱾�쓽 group媛믪뿉 +1 �떆�궓�떎.
	 	李멸퀬: 遺�紐④�蹂대떎 癒쇱� �옉�꽦�맂 湲��뱾��, 遺�紐④�蹂대떎 group媛믪씠 �겕�떎.
	 	
	 	遺�紐④��쓽 group 媛믪쓣 留ㅺ컻蹂��닔濡� �쟾�떖諛쏆븘, 遺�紐④�蹂대떎 癒쇱� �옉�꽦�맂 湲��뱾�쓽 group媛믪쓣 +1�떆�궎�뒗 硫붿냼�뱶  */
	public void boardReplyUp(BoardDto dto) {

		int group = dto.getB_group(); //遺�紐④��쓽 group媛� 媛��졇�삤湲�
		
		String sql = "update tblBoard2 set b_group=b_group+1 where b_group > ?";
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql); //?瑜� �젣�쇅�븳 update援щЦ�쓣 �떞�� pstmt媛앹껜 諛섑솚
			pstmt.setInt(1, group); //?媛� 遺�紐④��쓽 group媛믪쑝濡� 吏��젙
			pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println("boardReplyUp: "+e);
		}
		finally {
			try{pstmt.close();}catch(SQLException err){}
			try{con.close();}catch(SQLException err){}
		}
	}
	/* �떎�젣 �떟蹂�湲� �젙蹂� + 遺�紐④� group, level�젙蹂�(dto媛앹껜)瑜� �쟾�떖諛쏆븘 �떟蹂��떖湲� */
	public void boardReply(BoardDto dto){
		int group = dto.getB_group() + 1; //遺�紐④��뿉 ���븳 �떟蹂�湲� �옉�꽦�떆 +1
		int level = dto.getB_level() + 1; //�떟蹂�湲� �옉�꽦�떆 遺�紐④��쓽 level媛믪뿉 +1
		
		String sql ="select max(b_idx) from tblBoard2";
		
		int idx=0; //異붽��븷 �떟蹂�湲� 湲�踰덊샇 ���옣 蹂��닔
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){ //寃뚯떆�뙋�뿉 ���옣�맂 湲��쓽 媛��옣 �겙 湲�踰덊샇媛� �엳�쓣 寃쎌슦
				//湲��씠 �엳�쓣 寃쎌슦 �깉濡� 異붽��븷 �떟蹂�湲�踰덊샇瑜� ? 媛��옣 �겙 湲� 踰덊샇 +1 吏��젙
				idx = rs.getInt(1) +1;
			}else { //寃뚯떆�뙋�뿉 ���옣�맂 湲��쓽 媛��옣 �겙 踰덊샇媛� �뾾�쓣 寃쎌슦
				idx = 1; //湲��씠 �뾾�쓣寃쎌슦, �깉濡� 異붽��븷 �떟蹂�湲�踰덊샇瑜�? 1濡� 吏��젙
			}
			
			//�떟蹂�湲� 異붽� 荑쇰━
			String replySql = "insert into tblBoard2(b_idx, b_id, b_pw, b_name, b_email,"
					+ " b_title, b_content, b_group, b_level, b_date, b_cnt)"
					+ " values(?,?,?,?,?,?,?,?,?,now(),?";
			
			pstmt = con.prepareStatement(replySql);
			pstmt.setInt(1, idx); //泥ル쾲吏� ?媛믪쓣 �떟蹂�湲� 湲�踰덊샇濡� ���옣
			pstmt.setString(2, dto.getB_id());
			pstmt.setString(3, dto.getB_pw());
			pstmt.setString(4, dto.getB_name());
			pstmt.setString(5, dto.getB_email());
			pstmt.setString(6, dto.getB_title());
			pstmt.setString(7, dto.getB_content());
			pstmt.setInt(8, group); //+1�쓣 �븳 媛�
			pstmt.setInt(9, level); //+1�쓣 �븳 媛�
			pstmt.setInt(10, dto.getB_cnt());
			
			pstmt.executeUpdate();			
		}
		catch (Exception e) {
			System.out.println("BoardReply: " +e);
		}
		finally{
			try{rs.close();}catch(SQLException err){}
			try{pstmt.close();}catch(SQLException err){}
			try{con.close();}catch(SQLException err){}
		}
	}
	
	//二쇨� 異붽� �썝移�
	//�썝移�) �삉�떎瑜� �깉湲� 異붽��떆, 湲곗〈�쓽 湲��뱾�� 臾댁“嫄� group媛믪쓣 +1wmdrk tlzlsek
	public void groupUp(){
		String sql = "update tblBoard2 set b_group=b_group+1";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("groupUp: "+e);
		}finally {
			try{pstmt.close();}catch(SQLException err){}
			try{con.close();}catch(SQLException err){}
		}
	}
	//湲��궘�젣 硫붿냼�뱶
	public boolean boardDelete(String idx, String passwd) {
		String sql = "DELETE FROM tblBoard2 where b_idx=? and b_pass=?";
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql); //?瑜� �젣�쇅�븳 sql臾몄옣�쓣 pstmt�뿉 �떞�븘�넃怨� pstmt�옄泥대�� 諛섑솚 �빐�꽌 ���옣					
			//? ? 媛� �꽭�똿
			pstmt.setString(1, idx);
			pstmt.setString(2, passwd);
			
			//delete�떎�뻾
			pstmt.executeUpdate();
		}
		catch(Exception e){
			System.out.println("boardModify硫붿냼�뱶�뿉�꽌 �삤瑜�: " +e);
		}
		finally {
			try{pstmt.close();} catch(SQLException err){}
			try{con.close();} catch(SQLException err){}
		}
		return false;
	}//硫붿냼�뱶�걹
	
}//�겢�옒�뒪�걹


/* 	BoardDAO�겢�옒�뒪�뿉 留뚮뱺  2媛쒖쓽 硫붿냼�뱶瑜�  �슦由щ뒗 JSP紐⑤뜽1�뿉�꽌�뒗  
�듅�젙 List.jsp�럹�씠吏��뿉�꽌  BoardDAO媛앹껜瑜� �깮�꽦�븯�뿬  �샇異쒗븿�쑝濡쒖꽌 select �븳 湲��뱾�쓣 ���옣�븯���떎.
洹몃윭�굹 JSP紐⑤뜽2�뿉�꽌�뒗  �듅�젙 List.jsp�뿉�꽌 諛붾줈  BoardDAO媛앹껜�쓽 硫붿냼�뱶瑜� �샇異쒗븯�뒗 寃껋씠 �븘�땲�씪
BoardControllert�뿉�꽌 BoardDAO媛앹껜瑜� �깮�꽦�븯�뿬  2媛쒖쓽 硫붿냼�뱶瑜� �샇異쒗븿�쑝濡쒖꽌
select �븳 湲��뱾�쓣 �떞�� ArrayList瑜�  由ы꽩諛쏆븘   request�쁺�뿭�뿉 �떞�븘�꽌  List.jsp�럹�씠吏� 濡� �씠�룞 �떆�궎�뒗 諛⑹떇 �씠�떎.
*/

