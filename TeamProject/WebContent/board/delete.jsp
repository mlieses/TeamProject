<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//BoardController.java 서블릿으로 부터 전달받은 3개의 값
	String idx = request.getAttribute("idx").toString();
	String nowPage = request.getAttribute("nowPage").toString();
	String pass = request.getAttribute("pass").toString();

%>

<script type="text/javascript">
	//현재 delete페이지가 실행될때 이름없는 함수 (무명함수) 호출 함
	window.onload = function(){
		//버튼 2개중 하나 선택
		var result = confirm("정말 삭제하시겠습니까?") //예: true, 아니요: false
		
		if(result == true){
			//예 (밑의 form태그 실행하여 BardController로 요청)
			document.frmDelete.submit();
		}else{
			//아니오 (삭제no)
			history.back();	
		}
	}
</script>

<form name="frmDelete" method="post" action="deleteConfirm.board">
	<input type="hidden" name="idx" value="<%=idx %>">
	<input type="hidden" name="nowPage" value="<%=nowPage %>">
	<input type="hidden" name="pass" value="<%=pass %>">
</form>

