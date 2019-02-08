package user;

import java.sql.Date;

public class HostingReviewInfoDTO {

	/**1.공간에 대한 정보*/
	private int room_no;
	private String host_id;
	private String subject;
	private String room_type;
	private String pic1;
	
	
//	/**1-1. 호스트의 공간 평점과 평점 갯수 에 관한 정보*/
//	private int pointAvg;
//	private int po1cnt;
//	private int po2cnt;
//	private int po3cnt;
//	private int po4cnt;
//	private int po5cnt;
	
	
	/**getter setter*/
	public int getRoom_no() {
		return room_no;
	}
	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}
	public String getHost_id() {
		return host_id;
	}
	public void setHost_id(String host_id) {
		this.host_id = host_id;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getRoom_type() {
		return room_type;
	}
	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}
	public String getPic1() {
		return pic1;
	}
	public void setPic1(String pic1) {
		this.pic1 = pic1;
	}
//	public int getPointAvg() {
//		return pointAvg;
//	}
//	public void setPointAvg(int pointAvg) {
//		this.pointAvg = pointAvg;
//	}
//	public int getPo1cnt() {
//		return po1cnt;
//	}
//	public void setPo1cnt(int po1cnt) {
//		this.po1cnt = po1cnt;
//	}
//	public int getPo2cnt() {
//		return po2cnt;
//	}
//	public void setPo2cnt(int po2cnt) {
//		this.po2cnt = po2cnt;
//	}
//	public int getPo3cnt() {
//		return po3cnt;
//	}
//	public void setPo3cnt(int po3cnt) {
//		this.po3cnt = po3cnt;
//	}
//	public int getPo4cnt() {
//		return po4cnt;
//	}
//	public void setPo4cnt(int po4cnt) {
//		this.po4cnt = po4cnt;
//	}
//	public int getPo5cnt() {
//		return po5cnt;
//	}
//	public void setPo5cnt(int po5cnt) {
//		this.po5cnt = po5cnt;
//	}
	
	
	
}
