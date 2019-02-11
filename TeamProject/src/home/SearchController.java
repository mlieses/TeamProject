package home;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/search.do")
public class SearchController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Process(request, response);
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Process(request, response);
	}

	protected void Process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//검색 기준값
		//가격, 지역, 날짜, 인원, 옵션 
		
		
		request.setCharacterEncoding("utf-8");
		String type = request.getParameter("type");//공간 타입
		String location = request.getParameter("location");//위치
		String date = request.getParameter("date");//날짜
		String number = request.getParameter("number");//수용인원수
		System.out.println(number);

		SearchDAO dao = new SearchDAO();
		Vector<SearchDTO> FindV = dao.FindSpace(type, location, date, number);
		System.out.println("공간 갯수"+FindV.size());
		request.setAttribute("FindV", FindV );
				
		RequestDispatcher dis = request.getRequestDispatcher("Jong/detail.jsp?dateValue="+date);
		dis.forward(request, response);
	}

	
}
