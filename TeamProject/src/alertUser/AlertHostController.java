package alertUser;

import java.io.IOException;
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
		
		AlertDAO dao = new AlertDAO();
		JSONArray todayBook = dao.getTodayRoomBook(host_id);
		
		int nextRoomBookNum = dao.getNextRoomBook(host_id);
		
		
				
		
	}
	
}
