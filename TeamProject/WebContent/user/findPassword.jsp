<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<title>Insert title here</title>
<script type="text/javascript">
	// 비밀번호 찾기 클릭시 이벤트
	// 비밀번호 찾기 시나리오 
	// 드롭다운 버튼의 호스트 또는 일반회원 비밀번호 찾기 선택
	// 0 : 일반회원 비밀번호 찾기
	// 1 : 호스트회원 비밀번호 찾기
	// 찾기 버튼 클릭시 임시비밀번호를 발급해서 해당 이메일로 발송
	function user_passFind(){
		
		document.password_form.submit();
	}

</script>
</head>
<body>
	<!-- 최상단 네비 바 시작 -->
	<jsp:include page="../Top.jsp" flush="false"/>
	<!-- 최상단 네비 바 종료 -->
	<!-- 본문 시작 -->
	<form action="./FindPasswordController.do" method="post" name="password_form">
		<div class="w3-container" style="margin-top: 95px;">
			
			<h1 class="w3-center  w3-margin-top"><b>SS</b> share space 회원 비밀번호 찾기</h1>
			
			<div class="w3-row w3-margin-top"></div>
			<div class="w3-row w3-margin-top">
				<div class="w3-col m4 "><p> </p></div>		
				<div class="w3-col m4 w3-dark-grey w3-left">
					<p>&nbsp;&nbsp;&nbsp;<i class="w3-xxlarge fa fa-envelope"></i></p> 
				</div>
				<div class="w3-col m4"><p> </p></div>
			</div>
			<div class="w3-row w3-margin-top">
				<div class="w3-col m4"><p> </p></div>		
				<div class="w3-col m4">
					 <select class="w3-select w3-border" name="option">
					    <option value="" disabled selected>찾고싶은 계정을 고르세요</option>
					    <option value="0">일반회원 비밀번호</option>
					    <option value="1">호스트회원 비밀번호</option>					    
					  </select>					 
				</div>	
				<div class="w3-col m4"><p> </p></div>
			</div>		
			<div class="w3-row w3-margin-top">
				<div class="w3-col m4"><p> </p></div>		
				<div class="w3-col m4">
					 <input type="text" class="w3-input" placeholder="찾으실 비밀번호 계정의 이메일" name="email">
				</div>				
				<div class="w3-col m4"><p> </p></div>
			</div>		
			<div class="w3-row">
				<div class="w3-col m4"><p> </p></div>
				<div class="w3-col m4"><small>● 찾으실 계정의 이메일을 입력해주세요</small></div>
				<div class="w3-col m4"><p> </p></div>
			</div>
			<div class="w3-row w3-margin-top" style="margin-bottom: 319px;">
				<div class="w3-col m4"><p> </p></div>
				<div class="w3-col m4">
					<input type="button" id="btn_submit" onclick="user_passFind()" class="w3-button w3-block w3-red" value="비밀번호 찾기">
				</div>
				<div class="w3-col m4"><p> </p></div>
			</div>						
		</div>
	</form>	
	<!-- 푸터 영역 -->
	<jsp:include page="../Footer.jsp"/>
	<!-- 푸터 영역 -->
</body>
</html>