<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- 복사 1 font -->
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>

<!-- 복사2 google icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<style type="text/css">
	.con{
		border: 1px solid white;		
		margin-top: 75px;						
	}
	.hostRow{
		border: 1px solid white;
		width: 100%;		
	}
	.hostCol{
		border: 1px solid white;					
	}
	.ul_left>li{		
		list-style-type: none;
		padding-bottom: 10px;
	}
	.ul_left>li a{
		text-decoration: none;		
		font-size: 1.2em;
		color: grey;
	}
	.div_sticky{
		position: sticky;
		top : 95px;
	}	

</style>

<script type="text/javascript">
$(document).ready(function() {	
		$(".a_click1").css("color","black");
		$("#contents").load("user/hostProfileUpdate.jsp");		
		
	$(".a_click1").click(function(){
		//alert("클릭");
		$(".a_click1").css("color","black");
		$(".a_click2").css("color","grey");		
		$("#contents").load("user/hostProfileUpdate.jsp");
	});
	/* 호스트 탈퇴시 */
	$(".a_click2").click(function(){
		//alert("클릭");
		$(".a_click1").css("color","grey");
		$(".a_click2").css("color","black");
		$("#contents").load("user/hostDelete.jsp");	

	});
		
});

</script>
</head>
<body>
<%-- <!-- home페이지에서 공간관리 누를때 request값 a를 받기위한 input태그 -->
<input type="hidden" id="MyPage" value="${param.a}"> --%>
<!-- 최상단 네비 바 시작 -->
<jsp:include page="../Top.jsp" flush="false"/>
<!-- 최상단 네비 바 종료 -->
<div class="w3-container w3-padding-large con">		
		<div class="w3-row hostRow">
			<div class="w3-col m2 hostCol"></div>				
			<div class="w3-col m2 div_sticky hostCol" align="left">
				<h1 style="padding-left: 20px;">목록</h1>			
				<ul class="ul_left">
					<li><a href="#" class="a_click1">프로필 수정</a></li>
					<li><a href="#" class="a_click2">호스트 탈퇴</a></li>
					<!-- <li><a href="#" class="a_click2">공간등록 정보</a></li> 내가 등록한 공간
					<li><a href="#" class="a_click3">내 예약관리</a></li> 예약한 공간에 대한 리뷰
					<li><a href="#" class="a_click4">리뷰</a></li>					 -->
					<!-- <li><a href="#" class="a_click5"></a></li> -->
				</ul>			
			</div>		
			<div class="w3-col m6 hostCol" id="contents" style="margin-bottom: 100px;"></div>
			<div class="w3-col m2 hostCol"></div>			
		</div>
</div>
<!-- Footer -->
	<jsp:include page="../Footer.jsp" flush="false"/>
<!-- Footer 끝 -->

</body>
</html>