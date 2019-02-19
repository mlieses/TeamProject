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
		<form action="./ReBoardUpdateProController.do" method="post">
			<table width="1000">
				<tr>
					<th width="100"> NO </th>
					<td> ${notice.notice_no } </td>
				</tr>
				<tr>
					<th width="100"> ADMIN </th>
					<td> ${notice.admin } </td>
				</tr>
				<tr>
					<th width="100"> DATE </th>
					<td> ${notice.notice_date} </td>
				</tr>
				<tr>
					<th width="100"> SUBJECT </th>
					<td width="900px">
						<input type="text" name="notice_subject" style="width:100%;" value="${notice.notice_subject}">
					</td>
				</tr>
				<tr>
					<th width="100"> CONTENT </th>
					<td width="900px">
						<textarea name="notice_content" rows="25" style="width:100%;">${notice.notice_content}</textarea>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<input type="hidden" name="notice_no" value="${notice.notice_no}">
						<button class="w3-button w3-blue" type="submit">수정</button>
						<button class="w3-button w3-blue" type="reset">취소</button>
					</td>
				</tr>
			</table>
		</form>
	<p>

	
</center>
</div>
<!-- footer -->
<jsp:include page="../Footer.jsp"></jsp:include> 
</body>
</html>