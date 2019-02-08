<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "app.mvc.board.*" %>

<%
	//[2] 추가하기
	//페이징처리 변수
	int totalRecord = 0; //총 글 개수
	int numPerPage = 10; //한페이지당 보여질 글 개수
	int pagePerBlock = 5; //하나의 블럭당 보여질 페이지 개수
	int totalPage = 0; //총 페이지 수
	int totalBlock = 0; //총 블럭 수
	int nowPage = 0; //선택한 페이지 번호 (현재 사용자에게 보여질 페이지 번호)
	int nowBlock = 0; //선택한 블럭위치 (현재 사용자에게 보여질 블럭 번호)
	int beginPerPage = 0; //맨위의 글 번호(각각의 매 페이지마다 보여질 시작 글번호)
	
	// ArrayList가져오기(BoardController에서 전달한 request영역내부에 select한 글목록에 담긴)
	ArrayList list = (ArrayList)request.getAttribute("list");
	totalRecord = list.size(); //게시판의 총 글의 개수 구하여 저장
	
	/* 현재보여질 페이지번호 구하기 */
	if(request.getAttribute("nowPage") != null){
		// 페이지번호 받아와서 저장 (BoardController로 부터 전달받아 보여질)
		nowPage = Integer.parseInt(request.getAttribute("nowPage").toString());
	}
	
	/* 매 페이지마다 보여질 시작 글번호(맨위의 글번호) 구하기 */
	beginPerPage = nowPage * numPerPage;

	
	/* 총 페이지 수 구하기 
		총 블럭 수 = 총 페이지 수 / 하나의 블럭당 묶여질 페이지 개수 	*/
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);
	
	//[2]추가 여기까지.
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Tangerine">
<!-- 복사 1 font -->
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>

<!-- 복사2 google icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<!-- awsome icon -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" 
integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">

<!-- datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>  

<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/MVCBoard/style.css"/>
<script type="text/javascript">
<%-- 순서2. 검색어를 입력하지 않았을때 --%>
	function fnSearch(){
		var word = document.getElementById("word").value;
		if(word == null || word == ""){
			alert("검색어를 입력하세요.");
			document.getElementById("word").focus();
			return false;
		}
		else{
			document.frmSearch.submit();
		}
	}
<%-- 순서2. 끝 --%>
	
	function fnRead(val){
		document.frmRead.action = "read.board";
		document.frmRead.idx.value = val;
		document.frmRead.submit();
	}
</script>
<style>
	body{background-image: url("board/study1_2.jpg");
			font-family: "Nanum Barun Gothic"; 
			background-repeat:no-repeat;
			background-attachment: fixed;
			background-position: right top, center center; 
			background-size: 80%;}
			
	#page{	margin: auto;
			width: 100%;
			width: 1000px;
			height: 100%;
			height: 800px;
			padding: 10px;			
			letter-spacing: 1px;}

	.subject, .table, .page, p{ 
		}
	
	#p{font-family: "Tangerine", cursive, sans-serif;
		line-height: 30px; 
		font-size: 64px;
		text-shadow : 3px 2px 3px gray; 
		text-align: center;}
	
	.table{ border: 1px solid #cccccc;
			background-color: white;
			padding: 50px 80px;
			paading-top: 20px;
			margin: 0 auto;
			margin-bottom: 30px;
			border-top: 2px solid #000000;}
			
	.td{	border-top: 1px solid #cccccc;
			color: #404040;}
	#name, #date {font-size: 12px;}
	#title:HOVER { height: 2px; 
			background-color: #ffffe6;}
	#notice{ border: 1px solid #cccccc;
			padding: 10px;
			margin: 30px 0;}
			
	a{	text-decoration: none;
		color: black;}
	a:HOVER{text-decoration: underline;}
	
	.page{text-align: center;}	
	
	#pageBlock:HOVER { color:red;}
	
</style>

<%-- [5] 추가 --%>
<script type="text/javascript">
//하나의 글 상세보기 하기 위한, 글제목 링크를 클릭했을때
//글번호 전달 받는다
function fnRead(val){
	//BoardController에 전달할 글 상세보기 페이지 요청 가상 주소 저장
	document.frmRead.action = "read.board";
	//BoardController에 전달할 상세몰 글번호 저장
	document.frmRead.idx.value=val;
	//BoardController로 요청
	document.frmRead.submit();
}
</script>
<%-- [5]추가 끝 --%>
</head>
<body>
<!-- Navbar 복사4-->
<jsp:include page="../Top.jsp" flush="false"/>
<!-- 복사4종료  -->

<!-- 페이지 center-->
<div id="page" class="w3-content w3-padding" style="max-width:1564px" height="100%">


<table width="97%" height="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
	        		<td colspan="4">&nbsp;</td>
	        	</tr>
	        	<tr>
	        		<td colspan="4">&nbsp;</td>
	        	</tr>
	<tr> 
		<td colspan="3">
			<div align="center">
				<p id="p">Community Page</p>
			</div>
						
		</td>
	</tr>
	<tr> 
		<td colspan="3" valign="top">
			<div class="table" align="center"> 
	    	<table width="95%" border="0" cellspacing="0" cellpadding="0">
	        		
	        	<tr> 
	        		<td colspan="4">
	        		<!-- [3]글 목록 추가 : 글내용 뿌려주기 -->
	        			<% //게시판에 글이 없다면
	        				if(list.isEmpty()){
	        			%>
	        				등록된 글이 없습니다.
	        			<%
	        				//게시판에 글이 있다면
	        				}else{        			
	        			%>
	        				<table border="0" width="100%" cellpadding="2" cellspacing="0">
	        					<tr>
	        						<p id="notice">&nbsp;<i class="material-icons">notifications_none</i>&nbsp;&nbsp;"커뮤니티 게시판 입니다."</p>
	        					</tr>
	        					<tr align="center" height="120%">
	        						<th width="30">no</th>
	        						<th width="200">title</th>
	        						<th width="50">name</th>
	        						<th width="80">date</th>
	        						<th width="50">hit</th>
	        					</tr>
	        					<!-- 글내용 목록 출력 -->
	        					<%
	        					//각페이지마다 보여질 시작글번호 -->beginPerPage 부터~~
	        					//(각페이지마다 보여질 시작글번호 + 한페이지당 보여질 글의 개수) 만큼 반복
	        					for(int i=beginPerPage; i<(beginPerPage + numPerPage); i++){
	        						//만약 각 페이지마다 보여질 시작글번호가, 게시판의 총 글의 개수와 같아질때.	        					
	        						if(i == totalRecord){ //마지막 페이지에 글이 하나만 존재할깨
	        							//for문 빠져나감
	        							break;
	        						}
	        						BoardDto dto = (BoardDto)list.get(i);
	        						String name = dto.getB_name();
	        						String email = dto.getB_email();
	        						String title = dto.getB_title();
	        						String date = dto.getB_date();
	        						int idx = dto.getB_idx(); //글번호
	        						int cnt = dto.getB_cnt();
	        					%>
	        					<tr>
	        						<td class="td" align="center"><%=idx %></td>
	        							<%-- 추가[6]. 글제목을 눌렀을때
	        								- 글상세보기 페이지로 이동하는 요청을 BoardController에게 전달함
	        								- 상세몰 글번호를 fnRead함수에 전달함
	        							 --%>
	        						<td class="td" id="title" align="left"><a href="javascript:fnRead('<%=idx %>')">
	        							<i class="material-icons">label_important</i> <%=title %></a></td>
	        						<!-- <td align="left"><%=title %></td>  -->
	        						<td class="td" id="name" align="center"><%=name %></td>
	        						<td class="td" id="date" align="center"><%=date %></td>
	        						<td class="td" align="center"><%=cnt %></td>
	        						<!-- <td align="left"><a href="mailto:<%=email %>"><%=name %></a></td>  -->
	        					</tr>
	        					<%} //for 끝 %>
	        				</table>
	        				<%
	        				}	//if~else끝
	        				%>
	        				</td>
	        			</tr>	        	
	        		
	        		<!-- [3]여기까지 -->
	        	<tr>
	        		<td colspan="4">&nbsp;</td>
	        	</tr>
	        	<tr>
	        		<td colspan="4">&nbsp;</td>
	        	</tr>
				<tr>
					<%-- 순서1. 서블릿으로 요청을 위한 form태그로 묶는다 (검색어를 입력하지 않았을때 : fnSearch()함수 호출 --%>
					<form action="searchList.board" method="post" name="frmSearch" onsubmit="javascript:fnSearch();">
	            	<td colspan="1">
	            		<div align="right"> 
		            		<select name="key">
		              			<option value="titleContent" selected="selected">제목 + 내용</option>
		              			<option value="name">작성자</option>
		              		</select>
		              	</div>
	              	</td>
	              	&nbsp;
		            <td colspan="1" width="30px">
		            	<div align="center"> &nbsp;
		            		<input class="text" name="word" id="word"/>
		            	</div>
		            </td>
		            &nbsp;
		            <td wcolspan="1" width="20px">
		            	<div>
		            		<input type="submit" class="w3-button w3-border" value="검색"/>
		            	</div>
		            </td>
		            </form>
		            &nbsp;
		            <%-- 순서1. 끝 --%>
		            <%-- 글쓰기 버튼 --%>
		            <td colspan="1" style="text-align: left">
		            	<input type="button" onclick="location.href='write.board'" class="w3-button w3-border" value="글쓰기"/>		            		
		            </td>
		        </tr>	       		
			</table>
			</div>
	 	</td>
	
	</tr>
	<tr> 
		<!-- [4]페이징 추가 -->
		<div class="w3-bar">
		<td colspan="3" align="left" class="page">
		Before <<<
		<% if(totalRecord != 0) {%>
			<% if(nowBlock > 0) {%>
				<a href="list.board?nowBlock=<%=nowBlock-1 %>&nowPage=<%=((nowBlock-1)*pagePerBlock) %>" class="w3-button w3-hover-blue">
				이전 <%=pagePerBlock %>개</a>
			<%} %>
			
			<%for(int i=0; i<pagePerBlock; i++){ %>
				<a id="pageBlock" href="list.board?nowBlock=<%=nowBlock %>&nowPage=<%=(nowBlock*pagePerBlock)+i %>" class="w3-button w3-hover-red">
				<%= (nowBlock * pagePerBlock)+i+1 %></a>
				<% if((nowBlock*pagePerBlock)+i+1 == totalPage) break; %>
			<%} %>
			
			<% if(totalBlock > nowBlock + 1) { %>
				<a href="list.board?nowBlock=<%=nowBlock+1 %>&nowPage=<%=((nowBlock+1)*pagePerBlock) %>"  class="w3-button w3-hover-blue">
				다음 <%=pagePerBlock %>개</a>
			<%} %>
		<%} %>
		>>> Next
		<!-- [4]여기까지 -->
		</td> 
		</div>
	</tr>
</table>
<!-- 
	BoardController.java서블릿은  List.jsp페이지에서 전달한  검색어와 검색기준값을?????
	BoardDAO(자바빈객체)의 BoardList(String k, String w)메소드에 전달하여 DB작업후 응답결과를 얻어온다.
 -->
 
 <%-- 추가[7]. read.jsp로 이동 시, 동적으로 바뀌는 글번호와 현재선택한 페이지번호를 전달한다 --%>
 <form name="frmRead" mathod="post">
 	<input type="hidden" name="idx" value="">
 	<input type="hidden" name="nowPage" value="<%=nowPage%>">
 </form>
 <%-- [7]끗 --%>
 	
 	
 	<div>
	    <td colspan="5">&nbsp;</td>
	</div>
</body>
</html>





















