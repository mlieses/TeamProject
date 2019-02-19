package alertUser;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;


@WebServlet("/AlertHostController.do")
public class AlertHostController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}

	protected void doPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String host_id = request.getParameter("host_id");
		String email = request.getParameter("email");
		
		JSONArray hostList = new JSONArray();
		
		AlertDAO dao = new AlertDAO();
		
		//자기 공간에 등록된 예약
		JSONArray todayBook = dao.getTodayRoomBook(host_id);
//		int nextRoomBookNum = dao.getNextRoomBook(host_id);
		
		//host가 예약한 공간
		JSONArray todayBookList = dao.getTodayBook(email);
		int nextDayCount = dao.getNextDayBook(email);
		
		
		hostList.add(todayBook);
//		hostList.add(nextRoomBookNum);
		hostList.add("0");
		hostList.add(todayBookList);
		hostList.add(nextDayCount);
		
		PrintWriter out = response.getWriter();
		out.println(hostList);
		
	}
	
}
