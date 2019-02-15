<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  
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
<title>공간 리뷰 확인</title>

<!-- bxslider -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<style type="text/css">
#whole {
	width: 70%;
	margin: auto;
	min-height: 725px;
}

body {
	font-family: "Nanum Barun Gothic";
	letter-spacing: 1px;
	margin-top: 60px !important;
}

#whole>h2 {
	font-weight: bold;
	color: grey;
}

.bx-wrapper {
	margin-left: 45%;
	box-shadow: none !important;
	margin-top: 10px!important; 
	margin-bottom: 10px!important;
/* 	margin: 10px auto !important; */
	
}

.bx-wrapper .bx-controls-direction a {
   
    margin-left: -50px;
    margin-right: -50px;
   
}

.checked {
	color: orange;
}



/*rating*/

/* Three column layout */
.side {
	float: left;
	width: 15%;
	margin-top: 10px;
}

.middle {
	margin-top: 10px;
	float: left;
	width: 70%;
}

/* Place text to the right */
.right {
	text-align: right;
}

/* Clear floats after the columns */
.row:after {
	content: "";
	display: table;
	clear: both;
}

/* The bar container */
.bar-container {
	width: 100%;
	background-color: #f1f1f1;
	text-align: center;
	color: white;
}

/* Individual bars */
.bar-5 {
/* 	width: 40%; */
	height: 18px;
	background-color: #4CAF50;
}

.bar-4 {
/* 	width: 30%; */
	height: 18px;
	background-color: #2196F3;
}

.bar-3 {
/* 	width: 10%; */
	height: 18px;
	background-color: #00bcd4;
}

.bar-2 {
/* 	width: 4%; */
	height: 18px;
	background-color: #ff9800;
}

.bar-1 {
/* 	width: 15%; */
	height: 18px;
	background-color: #f44336;
}

/* Responsive layout - make the columns stack on top of each other instead of next to each other */
@media ( max-width : 400px) {
	.side, .middle {
		width: 100%;
	}
	.right {
		display: none;
	}
}
</style>

<script type="text/javascript">
  
$(function(){
	  $('.spaceList').bxSlider({
	    mode: 'horizontal',
	    slideWidth: 100,
	    minSlides: 1,
	    maxSlides: 5,
	    pager: false,
	    controls: true
	    
	  });
	});
  

</script>

</head>
<jsp:include page="../Top.jsp" flush="false"/>

<body>
<c:if test="${fn:length(sList) == 0}">
<div class="w3-container" id="whole">
	<h2 class="w3-left">공간 후기 관리</h2>
	&nbsp;&nbsp;&nbsp;
	<p>등록된 공간이 없습니다.</p>
	
</div>
</c:if>

<c:if test="${fn:length(sList) > 0}">
<div class="w3-container" id="whole">

	<h2 class="w3-left">공간 후기 관리</h2>
		  		
	<div class="spaceList">
	  	<c:forEach var="sList"  items="${requestScope.sList}">
	  		<div style=" text-align: center;">
	  			<a href="./HostingReviewController.do?host_id=${sessionScope.hdto.host_id}&room_no=${sList.room_no}">
		  		<img src="img/${sList.pic1}" alt="${sList.subject}" class="w3-circle"  name="spacePic" style="width:70px; height:70px; margin:0 auto;">
		  		<small>${sList.subject}</small>
		  		</a>
	  		</div>
	  	</c:forEach>	
	  			
	  </div><!-- 공간 정보 뿌리기1 end-->
	
	
	<div class="w3-row">
		<!-- 그래프 -->
	  	<div class="w3-container w3-quarter">
	  		<c:set var="sum" value="0"/>
	  		<c:set var="count" value="${fn:length(rList)}"/>
	  		<c:set var="count5" value="0"/>
	  		<c:set var="count4" value="0"/>
	  		<c:set var="count3" value="0"/>
	  		<c:set var="count2" value="0"/>
	  		<c:set var="count1" value="0"/>
	  		
	  		<c:forEach var="rList"  items="${requestScope.rList}">
	  			<c:set var="sum" value="${sum+rList.re_point}"/>
	  			<c:choose>
	  				<c:when test="${rList.re_point==5}">
	  					<c:set var="count5" value="${count5+1}"/>
	  				</c:when>
	  				<c:when test="${rList.re_point==4}">
	  					<c:set var="count4" value="${count4+1}"/>
	  				</c:when>
	  				<c:when test="${rList.re_point==3}">
	  					<c:set var="count3" value="${count3+1}"/>
	  				</c:when>
	  				<c:when test="${rList.re_point==2}">
	  					<c:set var="count2" value="${count2+1}"/>
	  				</c:when>
	  				<c:when test="${rList.re_point==1}">
	  					<c:set var="count1" value="${count1+1}"/>
	  				</c:when>
	  			</c:choose>
	  		
	  		</c:forEach>
	  		
	  		<hr style="border:3px solid #f1f1f1">
	  		<c:if test="${check == 0}">
	  		<p><b>전체 공간의 평점 </b></p>
	  		</c:if>
	  		
	  		<c:if test="${check != 0}">
	  		<p><b>${rList[0].subject}의 평점 </b></p>
	  		</c:if>
	  		
			<hr style="border:3px solid #f1f1f1">
			<p> ${fn:length(rList)}개 후기 &nbsp;&nbsp;평균 <fmt:formatNumber value="${sum/count}" pattern=".0"/> 점</p>
			
			<div class="row">
			  <div class="side">
			    <div>5점</div>
			  </div>
			  <div class="middle">
			    <div class="bar-container">
			      <div class="bar-5"  style="width: ${count5/count*100}%"></div>
			    </div>
			  </div>
			  <div class="side right">
			    <div>${count5 }</div>
			  </div>
			  <div class="side">
			    <div>4점</div>
			  </div>
			  <div class="middle">
			    <div class="bar-container">
			      <div class="bar-4" style="width: ${count4/count*100}%"></div>
			    </div>
			  </div>
			  <div class="side right">
			    <div>${count4}</div>
			  </div>
			  <div class="side">
			    <div>3점</div>
			  </div>
			  <div class="middle">
			    <div class="bar-container">
			      <div class="bar-3" style="width: ${count3/count*100}%"></div>
			    </div>
			  </div>
			  <div class="side right">
			    <div>${count3}</div>
			  </div>
			  <div class="side">
			    <div>2점</div>
			  </div>
			  <div class="middle">
			    <div class="bar-container">
			      <div class="bar-2" style="width: ${count2/count*100}%"></div>
			    </div>
			  </div>
			  <div class="side right">
			    <div>${count2}</div>
			  </div>
			  <div class="side">
			    <div>1점</div>
			  </div>
			  <div class="middle">
			    <div class="bar-container">
			      <div class="bar-1" style="width: ${count1/count*100}%"></div>
			    </div>
			  </div>
			  <div class="side right">
			    <div>${count1}</div>
			  </div>
			</div>
			<hr style="border:3px solid #f1f1f1">
	  		
	  		
	  	</div>
	  	
	  	
	  	<!--  리뷰 -->
	  	<div class="w3-container w3-threequarter">
	  		
	  		<span class="w3-right"> <a href="./HostingReviewController.do?host_id=${sessionScope.hdto.host_id}">전체보기</a></span>
	  		<br/>
	  		<c:forEach var="rList"  items="${requestScope.rList}">
			  <div class="w3-border-top w3-border-bottom" style="margin: 5px;"><!-- 리뷰 하나 시작-->
			    <header class="w3-container w3-light-grey w3-padding">
			    	<span class="w3-large"><b>${rList.subject}&nbsp;&nbsp; <small> ${rList.room_type}</small></b></span>&nbsp;
			    
			    	<c:forEach var="j" begin="${rList.re_point}" end="4" step="1">
			    	<span class="w3-right fa fa-star"></span>
					</c:forEach>
			    	<c:forEach var="i" begin="1" end="${rList.re_point}" step="1">
			    	<span class="w3-right fa fa-star checked"></span>
					</c:forEach>
			    </header>
			    <div class="w3-container">
			    	<span>작성자: ${rList.email}</span>
			    	<span class="w3-right">작성일: ${rList.re_date}</span>
			      <hr style="margin-top:3px;">
			      
			      <p>${rList.re_content}</p><br>
			    </div>
			  </div><!-- 리뷰 하나 종료 -->
			</c:forEach> 
			    
			
	  		
	  		
	  		
	  
	  	</div>
  	</div>


</div>
</c:if>
</body>
<div class="w3-cell-bottom" style="padding-bottom: 0px;">
<%-- <jsp:include page="../Footer.jsp" flush="false"/> --%>
</div>

</html>