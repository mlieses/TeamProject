package space;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import Comment.CommentDTO;

@WebServlet("/m_detail")
public class SpaceController extends HttpServlet {


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}

	protected void doPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("spacecontroller들어옴");
		request.setCharacterEncoding("UTF-8");
		int num =Integer.parseInt(request.getParameter("room_no"));
		SpaceDao dao = new SpaceDao();
		request.removeAttribute("list");
		request.removeAttribute("commentList");
		request.removeAttribute("noList");
		request.removeAttribute("allCount");
		request.removeAttribute("reviewList");
		
		
		//space의 정보를 list에 담아온다
		List list = dao.getSpace(num);
		request.setAttribute("list", list);
		
		//comment를 가져온다
		ArrayList<CommentDTO> comList = new ArrayList<CommentDTO>();
		comList = dao.getCommentList(num);
		request.setAttribute("commentList", comList);
		
		//예약이 다찬 날짜를 가져온다
		
		ArrayList<String> noList = dao.getNoDate(num);
		request.setAttribute("noList", noList);
		
		//review를 가져온다
		int allCount = dao.getReviewCount();
		request.setAttribute("allCount", allCount);
		
		
		ArrayList<ReviewDTO> reviewList = dao.getReviewList(num);
		request.setAttribute("reviewList", reviewList);
		
		
		RequestDispatcher dis = request.getRequestDispatcher("m_detail.jsp");
		dis.forward(request, response);
	}
}
