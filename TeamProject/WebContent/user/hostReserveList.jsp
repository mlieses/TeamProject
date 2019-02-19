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
	z-index: 0; 
	
}

.bx-wrapper .bx-controls-direction a {
   
    margin-left: -50px;
    margin-right: -50px;
    
   
}

.checked {
	color: orange;
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

	<h2 class="w3-left">공간 예약 확인</h2>
		  		
	<div class="spaceList">
	  	<c:forEach var="sList"  items="${requestScope.sList}">
	  		<div style=" text-align: center;">
	  			<a href="./HostingReservationController.do?host_id=${sessionScope.hdto.host_id}&room_no=${sList.room_no}">
		  		<img src="upload/${sList.pic1}" alt="${sList.subject}" class="w3-circle"  name="spacePic" style="width:70px; height:70px; margin:0 auto;">
		  		<small>${sList.subject}</small>
		  		</a>
	  		</div>
	  	</c:forEach>	
	  			
	  </div><!-- 공간 정보 뿌리기1 end-->
	
	
	<div class="w3-row">
		
	  	<div class="w3-container w3-quarter">
	  		<hr style="border:3px solid #f1f1f1">
	  		<c:if test="${check == 0}">
	  		<p><b>전체 공간의 예약 내역 </b></p>
	  		</c:if>
	  		
	  		<c:if test="${check != 0}">
	  		<p><b>${rList[0].subject}의 예약 내역 </b><p>
	  		</c:if>
	  		<p>${fn:length(rList)}개의 예약<p>
	  		<hr style="border:3px solid #f1f1f1">
	  	</div>
	  	
	  	<!--  예약 -->
	  	<div class="w3-container w3-threequarter">
	  		
	  		<span class="w3-right"> <a href="./HostingReservationController.do?host_id=${sessionScope.hdto.host_id}">전체보기</a></span>
	  		<br/>
	  		<c:forEach var="rList"  items="${requestScope.rList}">
			  <div class="w3-border-top w3-border-bottom" style="margin: 5px;">
			    <header class="w3-container w3-light-grey w3-padding">
			    	<span class="w3-large"><b>${rList.subject}&nbsp;&nbsp; <small> ${rList.room_type}</small></b></span>&nbsp;
			    </header>
			    <div class="w3-container">
			    	<span>예약자: ${rList.email}</span>
			    	<span class="w3-right">예약자 번호: ${rList.book_phone}</span>
			      <hr style="margin-top:3px;">
			      
			      <table width="100%">
		      		<tr>
			    		<td width=25%>예약 상태:</td>
			    		<td width=25%>
			    			      <c:choose>
		        					 <c:when test = "${rList.rStatus == 0}">
								     	다가 올 예약
								     </c:when>
								     <c:when test = "${rList.rStatus == 1}">
								     	지난 예약
								     </c:when>
								     <c:when test = "${rList.rStatus == 2}">
								     	취소 된 예약
								     </c:when>
							      </c:choose>
			    		</td>
			    		<td width=25%>결제 금액:</td>
			    		<td width=25%>${rList.total_price}</td>
		    		</tr>
		    		<tr>
			    		<td width=25%>예약 날짜:</td>
			    		<td width=25%>${rList.book_date}</td>
			    		<td width=25%>예약 시간:</td>
			    		<td width=25%>${rList.startT}:00 ~ ${rList.endT}:50</td>
		    		</tr>
		    	</table>
			    </div>
			  </div><!-- 예약 하나 종료 -->
			</c:forEach> 
			    
			
	  		
	  		
	  		
	  
	  	</div>
  	</div>


</div>
</c:if>
</body>
<div class="w3-cell-bottom" style="padding-bottom: 0px;">
<jsp:include page="../Footer.jsp" flush="false"/>
</div>

</html>