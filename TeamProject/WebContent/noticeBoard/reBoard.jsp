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
			<tr height="40">
				<th width="50"> NO </th>
				<th width="100"> ADMIN </th>
				<th width="200"> SUBJECT </th>
				<th width="100"> DATE </th>
				<th width="50"> HIT </th>			
			</tr>
			<!-- 게시글이 없을 경우   -->
			<c:if test="${count <= 0 }">
					<tr height="60">
						<td colspan="5" align="center"> 게시글이 없습니다.</td>
					</tr>
			</c:if>
			<!-- 게시글이 1개라도 있을 경우   -->
			<c:if test="${count > 0}">	
				<c:forEach var="v" items="${boardList }">
					<tr height="40">
						<td align="center">${v.notice_no}</td>
						<td align="center">${v.admin }</td>
						<td class="notice_subject"><a href="./ReBoardReadController.do?notice_no=${v.notice_no}">${v.notice_subject}</a></td>
						<td align="center">${v.notice_date}</td>
						<td align="center">${v.notice_hit}</td>
					</tr>
				</c:forEach>
			</c:if>
			
				<tr>
					<td colspan="4"></td>					
						<td>
							<c:if test="${sessionScope.udto.email eq 'admin'}">
								<button class="w3-button w3-blue" onclick="location.href='./ReBoardInsertController.do'">
									글쓰기
								</button>
							</c:if>	
						</td>					
				</tr>
			
		</table>
	<p>

	<!-- 페이지 카운터링  -->
	<c:if test="${count >0 }" >

	<!-- 이전이라는 링크를 걸어줄지 파악 -->
	<c:if test="${startPage > 10 }">
	<a href="./ReBoardListController.do?pageNum=${startPage-10 }"> [이전] </a>	
	</c:if>
	
	<!-- 페이징 처리 [1] [2] [3] .. -->
	<c:forEach var="i" begin="${startPage }" end="${endPage }">
	<a href="./ReBoardListController.do?pageNum=${i}"> [${i}]</a>	
	</c:forEach>
	
	<!-- 다음이라는 링크를 걸어줄지 파악 -->
	<c:if test="${endPage < pageCount }">
	<a href="./ReBoardListController.do?pageNum=${startPage+10 }"> [다음] </a>	
	</c:if>
	</c:if>	
</center>
</div>
 <!-- footer -->
 <jsp:include page="../Footer.jsp"></jsp:include>
</body>
</html>