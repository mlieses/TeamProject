package user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FindPasswordController.do")
public class FindPasswordController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}
	protected void doPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		if(request.getParameter("email")==null){		
			RequestDispatcher dis = request.getRequestDispatcher("user/findPassword.jsp");
			dis.forward(request, response);
			return;
		}		
		
		
		String email = request.getParameter("email");
		
		
		// DB처리할 객체 생성
		UserDAO udao = new UserDAO();
		int result = 0;
 		// 0 : 일반회원 비밀번호 찾기, 1 : 호스트회원 비밀번호 찾기
		int flag = Integer.parseInt(request.getParameter("option"));		
		
		// 일반회원, 호스트 회원 비밀 번호 찾기		
		System.out.println("email="+email);
		
		//------------------------------------smtp(mail-1.4.7 라이브러리 필요)----
		// smtp 변수들
		final String user = "skywing81@gmail.com"; //발신자의 이메일 아이디를 입력
		final String password = "qkrentjq8445"; //발신자 이메일의 패스워드를 입력
		
		//------------------------------------인증 난수------------------------
		String authNum = ""; // 인증 난수
		
		// 난수 생성 
		StringBuffer buffer = new StringBuffer();
		for(int i =0; i<=6;i++){
			int n = (int) (Math.random()*10);
			buffer.append(n);
		}	
		authNum = buffer.toString();		
		
		String content = "임시비밀번호 ["+ authNum +"]";	
		
		//-----------------------------------Property에 SMTP 서버 정보를 설정------
		/*
			1. mail.smtp.host			
			"mail.smtp.host"은 이메일 발송을 처리해줄 STMP 서버를 나타냅니다.			
			gmail을 SMTP서버로 사용할 경우 "smtp.gmail.com" 으로 설정, naver를 SMTP서버로 사용할 경우 "smtp.naver.com" 으로 설정합니다.			
			2. mail.smtp.port 			
			"mail.smtp.port "은 SMTP서버와 통신하는 포트를 말하는데 gmail일 경우 465를 Naver의 경우 587을 사용합니다.			
			주의. 구글과 네이버의 경우 Properties 설정 값이 다릅니다.!
		*/		
		Properties prop = new Properties(); 
		prop.put("mail.smtp.host", "smtp.gmail.com"); 
		prop.put("mail.smtp.port", 465); 
		prop.put("mail.smtp.auth", "true"); 
		prop.put("mail.smtp.ssl.enable", "true"); 
		prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {            	
                return new PasswordAuthentication(user, password);
            }
        });
		
		try {
				
			 MimeMessage message = new MimeMessage(session);
             message.setFrom(new InternetAddress(user));

             //수신자메일주소
             message.addRecipient(Message.RecipientType.TO, new InternetAddress(email)); 

             // Subject
             message.setSubject("임시 비밀번호 발급"); //메일 제목을 입력

             // Text
             message.setText(content);    //메일 내용을 입력

             // send the message
             Transport.send(message); ////전송
             System.out.println("message sent successfully...");      	
             
             if(flag == 0){
     		 // 일반 회원 비밀번호 찾기    			
     			result = udao.setUserPasswordUpdate(email,authNum);
     			
     		 }else{
     		 // 호스트 회원 비밀번호 찾기
     			result = udao.setHostPasswordUpdate(email,authNum);
     		 }
             
             
             if(result==0){
            	 response.setContentType("text/html; charset=utf-8");
  	     		
                 PrintWriter out = response.getWriter();
                 
                 out.println("<script>");
     			 out.println("alert('이메일이 존재하지 않습니다. 확인해 주세요.')");
     			 out.println("history.back();");
     			 out.println("</script>");
             }else{
            	 response.setContentType("text/html; charset=utf-8");
 	     		
                 PrintWriter out = response.getWriter();
                 
                 out.println("<script>");
     			 out.println("alert('임시 비밀번호가 발송되었습니다. 로그인 후 비밀번호를 변경해 주세요.')");
     			 out.println("location.href='index.jsp'");
     			 out.println("</script>");
             }
            
             
			
		} catch (Exception e) {
			System.out.println("메일 보내기 실패");
		}
		
	
		
	}


}
