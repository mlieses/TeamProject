<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

<title>ShareSpade : 글읽기 페이지</title>
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
		text-align: center;}
	
</style>
<script type="text/javascript">
	<%-- 2) 글삭제 버튼 눌렀을때 --%>
	function fnDelete() {
		//패스워드 입력하지 않았을때
		if(document.getElementById("pass").value == ""){
			alert("반드시 암호를 입력하세요");
			return false;
		}//패스워드를 입력했다면 <form>전송
		document.frmDelete.submit();		
	}
</script>
</head>
<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="table">
		<td colspan="3">
			<div align="center">
				<p id="p">Reading</p>
			</div>
		</td>
		
		<tr>
			<td colspan="3">
				<div align="center">
					<table width="95%" border="0" cellspacing="0" cellpadding="0">
				
						<tr>
							<td height="327" colspan="3" valign="top">
								<div align="center">
									<table id="border1" width="95%" height="373" border="1" cellpadding="0" cellspacing="1" bordercolor="#cccccc" class="border1">
										<tr>
											<td width="13%" height="33" class="text2" bgcolor="#f5f5f5">
												<div align="center" >작 성 자</div>
											</td>
											<td width="34%" style="text-align: left">
												&nbsp;&nbsp;<%=name %>
											</td>
											
											<td width="13%" bgcolor="#f5f5f5" >
												<div align="center">이메일</div>
											</td>
											<td width="40%" style="text-align: left">
												&nbsp;&nbsp;<%=email %>
											</td>
										</tr>
										
										<tr>
											<td height="33" class="text2" bgcolor="#f5f5f5" >
												<div align="center">제&nbsp;&nbsp;&nbsp; &nbsp; 목</div>
											</td>
											<td colspan="3"style="text-align: left">
												&nbsp;&nbsp;<%=title %>
											</td>
										</tr>
										
										<tr>
											<td height="245" class="text2" bgcolor="#f5f5f5" >
												<div align="center">내 &nbsp;&nbsp; 용</div>
											</td>
											<td colspan="3" style="text-align: left; vertical-align: top;">
												&nbsp;<%=content %>
											</td>
										</tr>
										<tr>
											<td class="text2" bgcolor="#f5f5f5" >
												<div align="center">패스워드</div>
											</td>
											<td colspan="3" style="text-align: left">
											<%-- 3) BoardController로 삭제를 한번더 물어보는 페이지로 이동하는 요청 --%>
												<form action="delete.board" name="frmDelete" method="post">
													<input type="hidden" name="idx" value="<%=idx%>"/>
													<input type="hidden" name="nowPage" value="<%=nowPage%>"/>
													<input type="password" name="pass" id="pass"/>
												</form>
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
							<td style="width: 48%">
								<div align="right" style="float: right;">
									<%-- 글답변 버튼 : 버튼눌럿을때 링크 걸어줌 --%>
										<input type="button" class="w3-button w3-border" 
										onclick="location.href='reply.board?nowPage=<%=nowPage %>&idx=<%=idx %>'" 
										value="답변"/>
									<%-- 글수정 버튼 : BoardController로 수정할 글번호 idx와 현재 상세포기페이지로 오기전의 페이지 번호를 넘겨준다--%>
									<input type="button" class="w3-button w3-border" 
										onclick="location.href='modify.board?nowPage=<%=nowPage %>&idx=<%=idx %>'" 
										value="수정"/>
									<%-- 1) 글삭제 버튼 눌렀을때--%>
									<input type="button" class="w3-button w3-border" 
										onclick="fnDelete();"
										value="삭제"/>
								</div>
							</td>
							<td width="10%">
								<div align="center">
									<%-- 목록버튼 : 무조건 첫페이지로 가는게 X!! 현재 read.jsp페이지로 오기 이전의 페이지로 이동하기 위함 --%>
									<input type="button" class="w3-button w3-border" 
										onclick="location.href='list.board?nowPage=<%=nowPage%>'"
										value="목록"/>
								</div>
							</td>
							<td width="42%"></td>
						</tr>
					
					</table>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>