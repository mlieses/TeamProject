<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://apis.google.com/js/platform.js" async defer></script>
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
</head>
<body>
<!-- 최상단 네비 바 시작 -->
<jsp:include page="../Top.jsp" flush="false"/>
<!-- 최상단 네비 바 종료 -->
	<!-- 일반 유저 / 호스트 구분 시작 -->
	<c:set var="email" value="${sessionScope.udto.email }"/>	    					
	<c:if test="${email eq null }"> 
    	<c:set var="email" value="${sessionScope.hdto.email }"/>						
    </c:if>
	
	<form action="./ReservationController.do" method="get">
			<input type="hidden" name="userId" value="${email}"> 		
			<div class="w3-row " style="margin-top: 100px; margin-bottom: 345px;">
				<div class="w3-col m3">
					<p></p>
				</div>
				<div class="w3-col m6" align="center">
					 <h1 style="margin-bottom: 120px;"> 예약이 완료 되었습니다.</h1>						
					 <input type="submit"  class="w3-button w3-block w3-xlarge w3-red w3-margin-top" value="내 예약 확인하러 가기" >
				</div>
				<div class="w3-col m3">
					<p></p>
				</div>
			</div>
		
	</form>


<!-- 최상단 네비 바 시작 -->
<jsp:include page="../Footer.jsp" flush="false"/>
<!-- 최상단 네비 바 종료 -->
</body>
</html>