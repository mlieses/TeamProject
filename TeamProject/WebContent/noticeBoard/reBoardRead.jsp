<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Tangerine">
<!-- 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Open+Sans|Unica+One" rel="stylesheet">
<!-- 복사 1 font -->
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>


<title>Insert title here</title>

	<style type="text/css">
		table{ 	border: 1px solid #cccccc;
			border-radius : 0 50px 0 50px; 
			border-spacing: 10px;
			padding: 80px;
			margin: 0 auto;
			margin-bottom: 70px;
			border-top: 2px solid #000000;
			background-color:#f2f2f2;}
		td{	border-top: 1px solid #cccccc;}
		th{ color: #007acc;}
		#no{color: #808080; font-size: 12px;
			text-align: center;}
		#id{color: #808080; font-size: 12px;
			text-align: center;}
		li{	color: #ff6600;;
		list-style:square;
		float: left;}
		table tr #ctt:HOVER { height: 2px; 
			background-color: #ffffe6;}
		#subject { width: 1100px; 
		background-color:white;
		padding: 10px;
		margin: 0 auto;
		text-align: middle;
		font-family: 'Unica One','Open Sans', cursive, sans-serif;
		color: black;
		font-size: 42px;}
		
		.class{border: 3px solid #f00;
			background-color: #ffffe6;
			/* background-image: url("boardImg1.jpg");*/
			width: 500px;  height: 300px;
			overflow: visible; }
		.button {}
		.paging{border: 1px solid red;
				margin: 0 auto;}
		#OS{font-family: ''Open Sans', sans-serif;
			font-size: 42px;}
		
	</style>
	
</head>
<body>

<jsp:include page="../Top.jsp"></jsp:include>

<!-- 페이지 center-->
<div class="w3-content w3-padding" style="max-width:1250px">

	<!-- 제목 -->
	<div class="w3-container w3-padding-32" id="projects">
		<h3 class="w3-border-bottom w3-border-light-grey w3-padding-16">공지사항</h3>
		<h6 class="w3"></h6>
	</div>
 
	<!-- 게시판 테이블 만들기 -->	
	<center>
	<p>	
		<p id="subject" width="1000">NOTICE</p>
		<table width="1000">
			<tr>
				<td width="100"> NO </td>
				<td> ${notice.notice_no} </td>
			</tr>
			<tr>
				<td width="100"> ADMIN </td>
				<td> ${notice.admin } </td>
			</tr>
			<tr>
				<td width="100"> DATE </td>
				<td> ${notice.notice_date} </td>
			</tr>
			<tr>
				<td width="100"> HIT </td>
				<td> ${notice.notice_hit} </td>
			</tr>
			<tr>
				<td width="100"> SUBJECT </td>
				<td> ${notice.notice_subject } </td>
			</tr>
			<tr>
				<td width="100"> CONTENT </td>
				<td> ${notice.notice_content} </td>
			</tr>
			<c:if test="${sessionScope.udto.email eq 'admin'}">
			<tr>
				<td colspan="2" align="right">
					<button class="w3-button w3-blue" 
					onclick="location.href='./ReBoardUpdateController.do?notice_no=${notice.notice_no}'">
						수정
					</button>
					<button class="w3-button w3-blue" onclick="deletebtn()">삭제</button>
					</form>
					
					
				</td>
			</tr>
			</c:if>
		</table>
	<p>
</center>
</div>
<!-- footer -->
<jsp:include page="../Footer.jsp"></jsp:include>
<script>
	function deletebtn(){
		if(confirm("정말 삭제하시겠습니까??")){
			location.href="./ReBoardDeleteController.do?notice_no=${notice.notice_no}";
		}else{
			return;
		}
	}
</script>
</body>
</html>