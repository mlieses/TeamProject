package user;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HostingReviewController.do")
public class HostingReviewController extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req, resp);
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProc(req, resp);
	}
	
	protected void doProc(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String host_id = req.getParameter("host_id");
		String room_no = req.getParameter("room_no");
		HostingReviewDAO dao = new HostingReviewDAO();
		ArrayList<HostingReviewInfoDTO> SpaceList = null;
		ArrayList<HostingReviewDTO> ReviewList = null;
		
		if(host_id==null){
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("alert('호스트 로그인 후 이용 바랍니다')");
			out.println("history.go(-1)");
			out.println("</script>");
			return;
			
		}else if(room_no == null){// 처음 실행하거나 전체선택 버튼 눌러서 공간 전체의 값을 얻어와야 할때
			SpaceList = dao.SpaceList(host_id);
			ReviewList = dao.ReviewList(host_id);
			req.setAttribute("check", 0);
			
		}else if(room_no != null){
			SpaceList = dao.SpaceList(host_id);
			ReviewList = dao.ReviewList(host_id, room_no);
			req.setAttribute("check", 1);
			
		}
		req.setAttribute("sList", SpaceList);
		req.setAttribute("rList", ReviewList);
		
		RequestDispatcher dis = req.getRequestDispatcher("/user/hostReviewList.jsp");
		dis.forward(req, resp);
		
		
	}

}
