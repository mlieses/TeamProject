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
		int room_no =Integer.parseInt(request.getParameter("room_no"));
		SpaceDao dao = new SpaceDao();
		request.removeAttribute("list");
		request.removeAttribute("commentList");
		request.removeAttribute("noList");
		request.removeAttribute("allCount");
		request.removeAttribute("reviewList");
		
		
		//space의 정보를 list에 담아온다
		List list = dao.getSpace(room_no);
		request.setAttribute("list", list);
		
		//comment를 가져온다
		ArrayList<CommentDTO> comList = new ArrayList<CommentDTO>();
		comList = dao.getCommentList(room_no);
		request.setAttribute("commentList", comList);
		System.out.println("커멘드 사이즈:"+comList.size());
		//예약이 다찬 날짜를 가져온다
		
		ArrayList<String> noList = new ArrayList<String>();
		for(int i=0;i<7;i++){
			String noday = dao.getNoDate(room_no, i);
			if(noday!=null){
				noList.add(noday);
			}
		}
		request.setAttribute("noList", noList);
		
		//review를 가져온다
		int allCount = dao.getReviewCount();
		request.setAttribute("allCount", allCount);
		
		
		ArrayList<ReviewDTO> reviewList = dao.getReviewList(room_no);
		request.setAttribute("reviewList", reviewList);
		
		
		RequestDispatcher dis = request.getRequestDispatcher("m_detail.jsp");
		dis.forward(request, response);
	}
}
