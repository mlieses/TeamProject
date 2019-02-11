package app.mvc.board;

import java.util.List;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoardController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doService(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doService(req, resp);
	}

	//doService
	//: 사용자가 get방식이든 post방식으로 요청하든지 간에
	//	요청을 받을 하나의 임의의 메소드 만들기
	private void doService(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {		
			
		req.setCharacterEncoding("UTF-8");
		
			/* 어떤 페이지에서 요청이 들어왔는지 사용자 요청 주소 알아내기 작업 */
			
			//사용자의 요청 전제추소인!! 프로젝트명을 포함한 전제 주소 알아오기
			String reqUri = req.getRequestURI(); //->/MVCBoard/list/board
			
			//사용자의 요청 주소 중에서 /MVCBoard 가져오기
			String ctPath = req.getContextPath();
			
			//사용자의 요청 주소 중에서 /list/board 가져오기
			String cmd = reqUri.substring(ctPath.length());
			//cmd : 사용자의 요청에 대한 이동할 서블릿 컨트롤러 주소가 저장된다.
			
			System.out.println("cmdddasd:"+cmd);
			
			//이동할 페이지주소를 담을 변수
			String nextPage = null;;
			
			if(cmd.equals("/list.board")) {//이동할 페이지-> 게시판 리스트 목록보기 이면
				
				//[2] try-catch 추가 (DAO,DTO 만든 후)
				try {
					BoardDAO dao = new BoardDAO();
					//현재 DB의 tblBoard2테이블에 저장되어 있는 글목록을 검색한
					//BoardDto객체들을 지니고 있는 ArrayList 가져오기
					List list = dao.BoardList(); //글목록 가져오기◆◆◆◆◆◆◆◆◆◆◆◆◆◆(List)
					
					//select한 글목록이 담긴 ArrayList를 request영역에 담기
					req.setAttribute("list", list);
					
					//select한 게시판의 전체글 개수 request영역에 담기
					req.setAttribute("total", dao.getTotalRecord());
					
					//현재 보여질 페이지 번호 저장
					req.setAttribute("nowPage", req.getParameter("nowPage"));
					//현재 보여질 블럭 번호 저장
					req.setAttribute("nowBlock", req.getParameter("nowBlock"));
					
				} catch (Exception e) {
					e.printStackTrace();
					
					/* 위 소스는 List.jsp페이지로 이동하면서  select한 글레코드 들을 담고 있는
						 ArrayList자체를 request영역에 담아 request영역까지 같이 전달 하는 것*/
				} 
				
				//실제 이동할 게시판 리스트 목록 페이지 저장
				nextPage = "board/list.jsp"; //MVC중에서 View
				
			//[3] 추가
			}else if(cmd.equals("/searchList.board")){ //이동할 페이지가 게시판 검색 페이지 요청이면
				try {
					req.setCharacterEncoding("UTF-8");
					
					//list.jsp에서 넘어온 값 전달받기
					String k = req.getParameter("key"); //검색기준값
					String w = req.getParameter("word"); //검색어
			/* 먼저할일!
			 BoardDAO.java(자바빈클래스) -> 검색어, 검색기준값에 해당하는 글목록 -> select.
			 BoardList(String k, Sting w) 메소드 추가하기 */
					
			//DB작업을 위한 DAO객체 생성(자바빈 객체)
			BoardDAO dao = new BoardDAO();
			
			//k와 w를 BoardList에 전달하여 DB의 tblBoard2테이블에 저장되어 있는 글목록을 검색한
			//BoardDto객체들을 기니고 있는 ArrayList가져오기
			List list = dao.BoardList(k,w); //글목록 가져오기 ◆◆◆◆◆◆◆◆◆캐스팅(List)
			
			//select한 글목록이 담긴 ArrayList를 request영역에 담기
			req.setAttribute("list", list);
			//현재 보여질 페이지 번호 저장
			req.setAttribute("nowPage", req.getParameter("nowPage"));
			//현재 보여질 블럭번호 저장
			req.setAttribute("nowBlock", req.getParameter("nowBlock"));
			} catch (Exception e) {
				e.printStackTrace();
			}
			//실제 이동할 게시판 리스트 목록 페이지 저장
			nextPage = "board/list.jsp"; //MVC중에서 View		
			//----[3]추가 끝----
				
				/* 여기부터 게시판 외  */
			}else if(cmd.equals("/searchList.board")) {//요청페이지: 게시판 검색 페이지
				//[?] 추가-----------------
				try {
					req.setCharacterEncoding("UTF-8");
					//list.jsp 요청페이지에서 넘어온 검색기준값과 검색어 전달받기
					String k = req.getParameter("key");
					String w = req.getParameter("word");
					/* 	BoardDAO --> k와w에 해당하는 글목록 select하는 구문 추가
					 	BoardList(String k, String w) 메소드 추가 */
					//DB작업을 위한 DAO객체 생성(자바빈 객체)
					BoardDAO dao = new BoardDAO();
					
					List list = (List) dao.BoardList(k, w); //글목록 가져오기(ArrayList)
					
					req.setAttribute("list", list); //select한 글목록이 담긴 AList를 request영역에 담기
					
					req.setAttribute("nowPage", req.getParameter("nowPage")); //현재보여질 페이지번호 저장
					req.setAttribute("nowBlock", req.getParameter("nowBlock"));//현재보여질 블럭번호 저장
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				//실제 이동할 게시판 리스트 목록 페이지 저장
				System.out.println("1");
				nextPage = "board/list.jsp"; //MVC중에서 View				
				//[?]추가 끝-----------------
				
			}else if(cmd.equals("/write.board")){//요청페이지: 글쓰기
				nextPage = "board/write.jsp"; //◆글쓰기 페이지 주소 저장
				System.out.println("2 write.jsp");
			}//[4] 추가-----
			else if(cmd.equals("/writeConfirm.board")){ //글추가 요청이면
				System.out.println("3");
				try {
					req.setCharacterEncoding("UTF-8");
					
					//DB작업을 위한 DAO객체 생성(자바빈 객체)
					BoardDAO dao = new BoardDAO();

					//write.jsp에서 전달받은 쓸 글에 대한 내용을 전달받아 저장할 객체 생성
					BoardDto dto = new BoardDto();
					dto.setB_name(req.getParameter("writer")); //작성자 이름 --- dto에 저장
					dto.setB_id(req.getParameter("writer")); //작성자이름(아이디)
					dto.setB_email(req.getParameter("email"));
					dto.setB_title(req.getParameter("title"));
					dto.setB_content(req.getParameter("content"));
					dto.setB_pw(req.getParameter("pass"));
					
					dao.boardInsert(dto); //★DAO에도 boardInsert()메소드 추가				
					
				} catch (Exception e) {
					System.out.println("4");
					e.printStackTrace();					
				}
				
				System.out.println("5");
				
				nextPage = "/list.board"; //이동할 List페이지 지정
						
			//[4]추가 끗-----
				
			}else if(cmd.equals("/read.board")){//요청페이지: 글 상세보기
				//[5]추가----------
				//list.jsp페이지에서 전달한 상세내용을 볼 글번호 가져오기
				String idx = req.getParameter("idx");
				//DB작업을 위한 DAO객체 생성
				BoardDAO dao = new BoardDAO();
				//상세내용을 볼 글번호를 전달하여
				//상세내용을 담고 있는 DTO객체 리턴 받기
				BoardDto dto = dao.boardRead(idx); //---> BoardDAO에 boardRead()메소드 만들기
				/* request영역에 담기 */
				req.setAttribute("name", dto.getB_name());
				req.setAttribute("email", dto.getB_email());
				req.setAttribute("title", dto.getB_title());
				req.setAttribute("content", dto.getB_content());
				//어떤 페이지에서 글 상세보기 페이지로 넘어왓는지, 이전페이지 번호 담기
				req.setAttribute("nowPage", req.getParameter("nowPage"));
				//상세볼 글번호 값 저장
				//저장이유: 글상세보기 페이지에서 글수정, 글삭제 등의 작업을 하기위해 request영역에 저장
				req.setAttribute("idx", idx);
				
				//이동할 글 상세보기 페이지 read.jsp지정
				nextPage = "board/read.jsp";				
				//[5]끗-----------
			}else if(cmd.equals("/modify.board")){//요청페이지: 글 수정하기
				System.out.println("mofidy 페이지 넘어왔다");	
				//[6]수정페이지에 필요한 것 추가
				try {
					/* read.jsp에서 받아오는 값 */
					//수정할 글 번호 받아오기
					String idx = req.getParameter("idx");
					
					/* DB작업(자바빈에 수정할 글 번호 전달 후, 수정하기전의 글 내용 받아오기) */
					BoardDAO dao = new BoardDAO();
					//수정할 글의 내용을 볼 글번호를 전달하여
					//수정하기 전 내용을 받고 있는 DTO객체 리턴받기
					BoardDto dto = dao.boardRead(idx);
					
					/* 받아온 수정하기 전 글내용(dto객체)을 request영역에 담기 */
					req.setAttribute("name", dto.getB_name());
					req.setAttribute("email", dto.getB_email());
					req.setAttribute("title", dto.getB_title());
					req.setAttribute("content", dto.getB_content());
					//어떤? 페이지에서 글 상세보기 페이지로 넘어왔는지, 이전 페이지 번호 담기
					req.setAttribute("nowPage", req.getParameter("nowPage"));
					//수정할 글번호 값 저장
					req.setAttribute("idx", idx);
				} catch (Exception e) {
					e.printStackTrace();
				}
				//수정하기 전의 글에 대한 내용을 뿌려주기 위한 주소 저장(글수정 디자인 페이지)
				nextPage = "board/modify.jsp";				
				//[6]끗----------
			}
			//[7] 이동할 페이지가 수정확인 페이지 요청이면!
			else if(cmd.equals("/modifyConfirm.board")){
				System.out.println("modifyConfirm 페이지 넘어왔다");	
				try { /* modify.jsp에서 받아오는 값 */
					int idx = Integer.parseInt(req.getParameter("idx")); //수정할 글 번호 받아옴
					String title = req.getParameter("title"); //수정할 글 제목 데이터 가져옴
					String content = req.getParameter("content"); //수정할 글 내용 데이터 가져옴
					
					/* 자바빈 (DTO)에 저장 */
					BoardDto dto = new BoardDto();
					dto.setB_idx(idx);	//수정할 번호 저장
					dto.setB_title(title); //수정할 제목 저장
					dto.setB_content(content); //수정할 내용 저장
					
					/* 데이터베이스 글수정 작업 */
					BoardDAO dao = new BoardDAO();
					
					dao.boardModify(dto); //수정할 글정보를 담고있는 dto객체를 전달하여 실제 update함
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				//글 수정 후 list.jsp로 이동하기 위한 주소 저장
				nextPage = "/list.board";
				//[7]끝 -------------------------------------
			}
			else if(cmd.equals("/delete.board")){//요청페이지: 글 삭제하기
				System.out.println("1 delete 페이지 넘어왔다");	
				//이동할 페이지가 글삭제를 한번더 물어보는 페이지 요청이면
				/* read.jsp에서 받아오는 값 */
				String idx = req.getParameter("idx"); //삭제할 글번호 받기
				String nowPage = req.getParameter("nowPage"); //페이지번호
				String passwd = req.getParameter("pass"); //패스 값
				System.out.println("2 read에서 값 받았다");	
				/* read.jsp에서 받아온 데이터를 request영역에 담기 */
				req.setAttribute("idx", idx);
				req.setAttribute("nowPage", nowPage);
				req.setAttribute("pass", passwd);
				System.out.println("3 request영역에 담았다");	
				//글삭제를 한번더 물어보는 페이지 주소 저장
				nextPage = "board/delete.jsp";
				System.out.println("4 글삭제할꺼니??");	
				//--> board/delete.jsp 페이지 만들기~~~
				
			}else if(cmd.equals("/deleteConfirm.board")){//글삭제 요청이면
				System.out.println("5 글삭제 요청중");	
				try{
					/* delete.jsp에서 받아오는 값 */
					//삭제할 글번호 받아오기
					String idx = req.getParameter("idx");
					//삭제하기 위해 입력한 패스워드 값 받아오기
					String passwd = req.getParameter("pass");
					System.out.println("6 글삭제 글번호 받아오는 중");	
					/* 데이터베이스 글 삭제 작업 */
					BoardDAO dao = new BoardDAO();
					System.out.println("7 글삭제작업!");	
					//삭제에 성공하면 true반환, 실패하면 false반환
					boolean result = dao.boardDelete(idx, passwd);
					//만약 삭제 성공시, list.jsp로 이동하는 주소 저장
					if(result == true){
						nextPage = "/list.board";
					}else{//삭제 실패시 passError.jsp로 이동하는 주소 저장
						nextPage = "board/passError.jsp";
					}
					System.out.println("7 성공이냐 실패냐");	
				}catch(Exception e){
					e.printStackTrace();
				}
				System.out.println("8 delete 결과!");	
			}
			else if(cmd.equals("/reply.board")){//요청페이지: 답변글 달기
				//답변달기위한 부모글번호 넘겨받기
				String idx = req.getParameter("idx");
				
				try{
					BoardDAO dao = new BoardDAO();
					BoardDto dto = dao.boardRead(idx);
					
					req.setAttribute("title", dto.getB_title()); //부모글제목
					req.setAttribute("content", dto.getB_content()); //부모글내용
					req.setAttribute("nowPage", req.getParameter("nowPage")); //이전페이지번호 (어떤?페이지에서 글상세보기 페이지로 넘어왔는지)
					req.setAttribute("idx", idx); //부모글번호
				}catch(Exception e){
					e.printStackTrace();
				}
				//이동할 답변글 달기 위한 페이지 주소 저장
				nextPage = "board/reply.jsp";
				System.out.println("reply.jsp 으로 왓다");
				
			}else if(cmd.equals("/replyConfirm.board")){//실제 답변 달기 요청이면
				System.out.println("replyConfirm.board 으로 왓다");
				//답변달기위한 부모글번호 넘겨받기
				String idx = req.getParameter("idx");
				
				try{
					BoardDAO dao = new BoardDAO(); //db작업을 위한 DAO객체-> 부모글의 group번호, level들여쓰기 값을 가져오기
					BoardDto bumoDto = dao.boardRead(idx); //부모글번호 전달--> Dto객체 리턴받음(부모글내용)
					
					int group = bumoDto.getB_group(); //부모글의 그룹번호
					int level = bumoDto.getB_level(); //부모글의 들여쓰기 값 꺼내오기
					
					//답변글 내용을 저장할 Dto객체 생성
					BoardDto redto = new BoardDto();
					//reply.jsp에서 전달받은 답변글 데이터들을 redto객체에 저장하긔
					redto.setB_name(req.getParameter("writer"));
					redto.setB_id(req.getParameter("writer"));
					redto.setB_email(req.getParameter("email"));
					redto.setB_title(req.getParameter("title"));
					redto.setB_content(req.getParameter("content"));
					redto.setB_pw(req.getParameter("pass"));
					//위의 부모글에 대한 그룹번호와 들여쓰기 값을 redto객체에 저장하기
					redto.setB_group(group);
					redto.setB_level(level);
					
					dao.boardReplyUp(redto); //먼저 작성된 글들의 group값을 +1 시킴
					dao.boardReply(redto); //실제 답변글정보+부모글 group,level정보 전달하여 답변달기
				}
				catch(Exception e){
					e.printStackTrace();
				}
				//이전페이지번호 담기 (어떤페이지에서 --- 글상세보기 페이지로 넘어왓는지 : request영역에)
				req.setAttribute("nowPage", req.getParameter("nowPage"));
				//답변달기 성공 후 다시 이동할 list.jsp페이지 주소 저장
				nextPage = "/list.board";
			}	
			//실제이동
			RequestDispatcher view = req.getRequestDispatcher(nextPage);
			view.forward(req, resp);
		}
	}
	
	
