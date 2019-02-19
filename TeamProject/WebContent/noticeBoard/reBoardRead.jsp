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
<!-- css -->
<link rel="stylesheet" href="css/reBoard.css">
<title>Insert title here</title>	
</head>
<body>

<jsp:include page="../Top.jsp"></jsp:include>

<!-- 페이지 center-->
<div class="w3-content w3-padding" style="max-width:1250px">

	<!-- 게시판 테이블 만들기 -->	
	<center>
	<p>	
		<p id="subject" width="1000">공지 사항</p>
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
				<td  style="white-space: pre;"> ${notice.notice_content} </td>
			</tr>
			
			<tr>
				<td  colspan="2" align="right">
					<c:if test="${sessionScope.udto.email eq 'admin'}">				
						<button class="w3-button w3-blue" style="margin: 0;"
						onclick="location.href='./ReBoardUpdateController.do?notice_no=${notice.notice_no}'">
							수정	
						</button>					
						<button class="w3-button w3-blue" onclick="deletebtn()">삭제</button>
					</c:if>			    				
				</td>
			</tr>
			
		</table>
				<button class="w3-button w3-blue" onclick="location.href='./ReBoardListController.do'">목록</button>
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