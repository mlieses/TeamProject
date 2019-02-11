package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DB.DAO;
import DB.HostingDTO;
import user.HostDTO;


@WebServlet("/deleteBoardController.do")
public class deleteBoardController extends HttpServlet {
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//room_no값으로 where 찾아서 delete
		int room_no ;
		room_no =  Integer.parseInt(request.getParameter("roomNo"));
		
		DAO dao = new DAO();
		HostingDTO dto = new HostingDTO();
		dto.setRoom_no(room_no);
		
		dao.delete(dto);
				
		HttpSession session = request.getSession();
		HostDTO hdto =	(HostDTO)session.getAttribute("hdto");
		String hostId =	hdto.getHost_id();
		
		
		//작업다 끝낸뒤 detail.jsp로 이동
		RequestDispatcher dis = 
					request.getRequestDispatcher("/Jong/MyPageDetail.jsp?HostId="+hostId);
		
		dis.forward(request	,response);
		
		
		
	}

}
