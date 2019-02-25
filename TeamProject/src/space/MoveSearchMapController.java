package space;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/MoveSearchMapController.do")
public class MoveSearchMapController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPro(request, response);
	}
	
	protected void doPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String swLat = request.getParameter("swLat");
		String swLng = request.getParameter("swLng");
		
		String neLat = request.getParameter("neLat");
		String neLng = request.getParameter("neLng");
		
		String sLatLng[] = {swLat, swLng, neLat, neLng};
		
		SpaceDao dao = new SpaceDao();
		ArrayList list = dao.getMoveSpaceList(sLatLng);
		
		PrintWriter out = response.getWriter();
		out.println(out);
		
		
	}

}
