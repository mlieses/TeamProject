<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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

<title>ShareSpade : 글쓰기 페이지</title>
<style>
	body{ 	background-image: url("board/study1_2.jpg");
			background-repeat:no-repeat;
			background-attachment: fixed;
			background-position: right top, center center; 
			background-size: 80%;
			font-family: "Nanum Barun Gothic"; }
	#page{	margin: auto;
				width: 100%;
				width: 1000px;
				padding: 10px;			
				letter-spacing: 1px;
				}
	
	#title{ margin-top: 30px;
		width: 500px;
		background-color: white;
		border-radius : 0 0 50px 0 ;
		border-top: 2px solid #000000;
		border-bottom: 1px solid #808080;
		border-right: 1px solid #808080;
		border-spacing: 50px;}
	
	#table { 
		background-color: white;
		}
	
	#td{ border: 1px solid gray;
		}
	
	#p{font-family: "Tangerine", cursive, sans-serif;
		line-height: 10px; 
		font-size: 64px;
		text-shadow : 3px 2px 3px gray; 
		text-align: center;}
	#width{ width: 100px;}
</style>

<script type="text/javascript">
	//[3] BoardController로 글쓰기 내용 전송
	function fnInsert(){
		document.frmInsert.submit();
	}
</script>

</head>
<body>
<!-- Navbar 복사4-->
<jsp:include page="../Top.jsp" flush="false"/>
<!-- 복사4종료  -->
<!-- [1] -->
<form method="post" action="writeConfirm.board" name="frmInsert">
<!-- [1]끝 -->

<!-- 페이지 center-->
<div id="page" width="97%" border="0" cellspacing="0" cellpadding="0">
				<tr>
	        		<td colspan="4">&nbsp;</td>
	        	</tr>
	        	<tr>
	        		<td colspan="4">&nbsp;</td>
	        	</tr>
	  <td colspan="3">
	   	<div align="center">
			<p id="p">Writing</p>
		</div>
	  </td>

	  <tr> 
	    <td colspan="4">
	    	<div align="center"> 
		        
		     <br/><p>" 글쓰기 페이지 입니다 "</p><br/>
		     <tr>
		     <td height="327" colspan="3" valign="top">
		        <div align="center"> 
                <table id="table" width="95%" height="373" cellpadding="0" cellspacing="1" class="w3-table">
                	
                  <tr> 
                    <td width="10%">작성자</td>
                    <td style="text-align: left">
                    	<input type="text" name="writer" size="20" class="w3-input"/>
                    </td>
                    <td>
                    	<div align="center"> 
                        	<label>메일주소</label>
                      	</div>
                    </td>
                    <td  style="text-align: left">
                        <input type="text" name="email" size="40" class="w3-input" />
                    </td>
                  </tr>      
                  
                         
                  <tr> 
                    <td height="31">
                    	<label>제목</label>
                    </td>
                    <td colspan="3" style="text-align: left">
                    	<input type="text" name="title" size="70" class="w3-input" />
                    </td>
                  </tr>
                  <tr> 
                    <tdclass="text2">
                    	<div align="center"><i class="material-icons">sms</i><br/>내용</div>
                    </td>
                    <td colspan="3" style="text-align: left">
                    	<textarea name="content" rows="15" cols="100"></textarea>
                    </td>
                  </tr>
                  <tr> 
                    <td bgcolor="#e4e4e4" class="text2">
                    	<div align="center">패스워드</div>
                    </td>
                    <td colspan="3" style="text-align: left">
                    	<input type="password" name="pass"/>
                    </td>
                  </tr>
                </table>
              </div>
              </td>
          </tr>
  
          <tr> 
            <td width="48%">
            <div align="right">
            	<%-- 글 등록 버튼/ [2]:자바스트립트 함수로 form전송 하기 --%>
            	<a href="javascript:fnInsert();">
					<input type="button" class="w3-button w3-border w3-red" value="등록"></a>
            </div>
            </td>
            <td width="10%">
            <div align="center">
            	<%-- 목록 보기 버튼(List.jsp로 이동) <--BoardController에 요청 --%>
            	<a href="list.board">
            		<input type="button" class="w3-button w3-border w3-green" value="목록"></a>
            </div>
            </td>
            <td width="42%"></td>
            
          </tr>
     
      </div></td>
  </tr>
</div>
</form>
</body>
</html>