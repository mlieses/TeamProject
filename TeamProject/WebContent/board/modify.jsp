<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% //[2]. 하나의 글 상세보기 페이지 : 하나의 글 내용 뿌려주기 
	String name = request.getAttribute("name").toString();
	String email = request.getAttribute("email").toString();
	String title = request.getAttribute("title").toString();
	//뿌려줄 글 내용
	String content = request.getAttribute("content").toString().replace("/r/n", "<br/>");
	String nowPage = request.getAttribute("nowPage").toString(); //현재 상세보기 페이지로 오기전의 페이지 번호
	String idx = request.getAttribute("idx").toString(); //뿌려줄 글 번호
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
<style>
	body{	margin: auto;
				width: 100%;
				width: 1000px;
				padding: 10px;			
				font-family: "Nanum Barun Gothic"; 
				letter-spacing: 1px;
	
				background-image: url("board/study1_2.jpg");
				background-repeat:no-repeat;
				background-attachment: fixed;
				background-position: right top, center center; 
				background-size: 80%;
				}
	
	#table{ margin-top: 30px;
		background-color: white;
		border-radius : 0 0 50px 0 ;
		border-top: 2px solid #000000;
		border-bottom: 1px solid #808080;
		border-right: 1px solid #808080;
		border-spacing: 50px;}
	
	#border1 { background-color: white;
		}
	
	#td{ border: 1px solid gray;
		}
	
	#p{font-family: "Tangerine", cursive, sans-serif;
		line-height: 10px; 
		font-size: 64px;
		text-shadow : 3px 2px 3px gray; 
		text-align: cneter;}
	#width{ width: 100px;}
	
</style>

<title>ShareSpade : 수정페이지</title>
</head>
<body>
<form method="post" action="modifyConfirm.board" name="frmModify">

	<input type="hidden" name="idx" value="<%=idx %>"> <%-- 수정할 글 번호 전달 --%>
	<input type="hidden" name="nowPage" value="<%=nowPage %>"> <%-- 상세보기 페이지로 오지건의 페이지번호 전달 --%>

	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	    <td colspan="3">
	    	<div id="table" align="center"> 
		        <table width="95%" border="0" cellspacing="0" cellpadding="0">
		        	<p id="p">Modify</p>
		   			<br/><p>" 글 수정 페이지 입니다 "</p><br/>
		          <tr> 
		            <td height="327" colspan="3" valign="top">
		            	<div align="center"> 
			                <table id="border1" width="95%" height="373" border="1" cellpadding="0" cellspacing="1" class="border1">
			                  <tr> 
			                    <td width="13%" height="33" bgcolor="#e4e4e4" class="text2">
			                    	<div id="width" align="center">작 성 자</div>
			                    </td>
			                    <td width="34%" style="text-align: left">&nbsp;<%=name %></td>
			                    <td width="13%" bgcolor="#e4e4e4">
			                    	<div align="center"> 
			                        	<p class="text2">이메일</p>
			                       </div></td>
			                    <td width="40%" style="text-align: left">&nbsp;<%=email %></td>
			                  </tr>
			                  <tr> 
			                    <td height="33" bgcolor="#e4e4e4" class="text2">
			                    	<div align="center">제&nbsp;&nbsp; &nbsp; 목 </div>
			                    </td>
			                    <td colspan="3" style="text-align: left">
			                    	<input type="text" name="title" size="70" value="<%=title %>">
			                    </td>
			                  </tr>
			                  <tr> 
			                    <td height="245" bgcolor="#e4e4e4" class="text2">
			                    	<div align="center"><i class="material-icons">sms</i><br/>내 &nbsp;&nbsp; 용</div>
			                    </td>
			                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
			                    	<textarea name="content" rows="15" cols="100"><%=content %></textarea>
			                    </td>
			                  </tr>
			                </table>
		              	</div>
		              </td>
		          </tr>
		          <tr> 
		            <td colspan="3">&nbsp;</td>
		          </tr>
		          <tr> 
		            <td width="48%">
		            	<div align="right">
		            	<%-- 수정버튼을 눌렀을때, form action="modifyConfirm.board" 요청 --%>
		                	<input type="button" class="w3-button w3-border w3-white" 
		                		onclick="document.frmModify.submit();" value="수정">
		                </div>
		            </td>
		            <td width="10%">
		            	<div align="center">
		            		<%-- 목록버튼을 눌렀을때, BoardController서블릿으로 list.jsp로 이동하는 요청 함 --%>
		               		<input type="button" class="w3-button w3-border w3-white" 
		               			onclick="location.href='list.board?nowPage=<%=nowPage%>'" value="목록">
		               	</div>
		            </td>
		            <td width="42%"></td>
		          </tr>
		          	  <td width="13%" height="20" class="text2">
			                    </td>
		        </table>
	    	</div>
	  	</td>
	  </tr>
	</table>
</form>
</body>
</html>