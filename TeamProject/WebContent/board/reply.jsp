<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
// 1.BoardController로 부터 전달받기
String title = "[답변]: " + request.getAttribute("title").toString();
String content = ">> " + request.getAttribute("content").toString().replace("\r\n","\r\n>>");
String nowPage = "[답변]: " + request.getAttribute("nowPage").toString();
String idx = "[답변]: " + request.getAttribute("idx").toString();
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
<title>ShareSpade : 답변페이지</title>
</head>
<body>
<form name="frmReply" method="post" action="replyConfirm.board">
<input type="hidden" name="idx" value="<%=idx%>"> <%-- 부모글번호 전달 --%>
<input type="hidden" name="nowPage" value="<%=nowPage %>">

<table width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td colspan="3"><div align="center"> 
        <table id="table" width="95%" border="0" cellspacing="0" cellpadding="0">
        	<p id="p">Modify</p>
        <br/><p>" 답변쓰기 페이지 입니다 "</p><br/>
          <tr> 
            <td colspan="3" valign="top">
            <div align="center"> 
                <table width="100%" height="373" border="0" cellpadding="0" cellspacing="1" class="border1">
                  <tr> 
                    <td width="13%" height="29" bgcolor="#e4e4e4" class="text2">
                    	<div id="width" align="center">작 성 자</div>
                    </td>
                    <td width="34%" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="text" name="writer" size="20" class="text2" />
                    </td>
                    <td width="13%" bgcolor="#e4e4e4">
                    	<div align="center"> 
                        	<p class="text2">메일주소</p>
                      	</div>
                    </td>
                    <td width="40%" bgcolor="#f5f5f5" style="text-align: left">
                        <input type="text" name="email" size="40" class="text2" />
                    </td>
                  </tr>             
                  <tr> 
                    <td height="31" bgcolor="#e4e4e4" class="text2">
                    	<div align="center">제&nbsp;&nbsp;&nbsp;목</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="text" name="title" size="70" value="<%=title%>"/>
                    </td>
                  </tr>
                  <tr> 
                    <td bgcolor="#e4e4e4" class="text2">
                    	<div align="center">내 &nbsp;&nbsp; 용</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                    	<textarea name="content" rows="15" cols="100"><%=content %>
                    	===========답변 글==========</textarea>
                    </td>
                  </tr>
                  <tr> 
                    <td bgcolor="#e4e4e4" class="text2">
                    	<div align="center">패스워드</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="password" name="pass"/>
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
            	<%-- 등록 버튼을 눌렀을때, 서블릿으로 요청 --%>
            	<input type="button" class="w3-button w3-border w3-white" 
		         onclick="document.frmReply.submit();" value="등록">
            </div>
            </td>
            <td width="10%">
            <div align="center">
            	<%-- 목록 버튼을 눌렀을때, 서블릿으로 요청 --%>
            	<input type="button" class="w3-button w3-border w3-white" 
		         onclick="location.href='list.board?nowPage=<%=nowPage%>'" value="목록">
            </div>
            </td>
            <td width="42%"></td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
</form>
</body>
</html>