package alertUser;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import booking.BookingDTO;


@WebServlet("/AlertUserController.do")
public class AlertUserController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}
	protected void doPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String email = request.getParameter("email");
		
		AlertDAO dao = new AlertDAO();
		
		JSONArray todayBookList = dao.getTodayBook(email);
		int nextDayCount = dao.getNextDayBook(email);
		
		JSONArray jarray = new JSONArray();
		jarray.add(todayBookList);
		jarray.add(nextDayCount);
		
		PrintWriter out = response.getWriter();
		out.println(jarray);
		
		
		
	}
}
