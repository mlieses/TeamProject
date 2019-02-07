package user;

import java.sql.Date;

public class HostingReviewDTO {
	
	/**2.리뷰에 대한 정보 */
	private int room_no;
	private String host_id;
	private String subject;
	private String room_type;
	private String people;
	
	private int review_no;
	private int book_no;
	private String email;
	private Date re_date;
	private int re_point;
	private String re_content;
	private String re_host_reply;
	private Date re_reply_date;
	
	
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
	public String getPeople() {
		return people;
	}
	public void setPeople(String people) {
		this.people = people;
	}
	public int getReview_no() {
		return review_no;
	}
	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}
	public int getBook_no() {
		return book_no;
	}
	public void setBook_no(int book_no) {
		this.book_no = book_no;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getRe_date() {
		return re_date;
	}
	public void setRe_date(Date re_date) {
		this.re_date = re_date;
	}
	public int getRe_point() {
		return re_point;
	}
	public void setRe_point(int re_point) {
		this.re_point = re_point;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public String getRe_host_reply() {
		return re_host_reply;
	}
	public void setRe_host_reply(String re_host_reply) {
		this.re_host_reply = re_host_reply;
	}
	public Date getRe_reply_date() {
		return re_reply_date;
	}
	public void setRe_reply_date(Date re_reply_date) {
		this.re_reply_date = re_reply_date;
	}
	
}
