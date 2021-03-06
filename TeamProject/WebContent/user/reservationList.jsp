<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  
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
<title>예약확인</title>


<style type="text/css">
#whole{
	width: 60%;
	margin: auto;
 	min-height: 725px;
}

body{
	font-family: "Nanum Barun Gothic"; 
	letter-spacing: 1px;
 	margin-top: 60px !important;

}

#whole>h2{
	font-weight: bold;
	color:grey;
}

#filterbar > a{
	text-decoration: none;
	font-weight: bold;
 	color: white !important;

}

#filterbar > a:hover{
 	color: green !important;

}


.w3-third {
  height: 170px;
}  
.w3-rest{
 height: 170px;
}  


.checked {
  color: orange;
}


</style>

<script type="text/javascript">

function tog(show, hide) {
	document.getElementById(show).style.display='block';
	document.getElementById(hide).style.display='none';
}

function limit(no){
// 	alert("글자수는 10자로 이내로 제한됩니다.");
	var text_id = '#reviewArea' + no;
	var size_id = '#byte'+no;
	var len = $(text_id).val().length;
// 	alert(len);
	$(size_id).val(len);
	if($(text_id).val().length > 200) {

		alert("글자수는 200byte 이내로 제한됩니다.");

		$(text_id).val($(text_id).val().substring(0, 200));

	}
}


function start(idx, no){
// 	alert(idx);
	$('.fa').attr('class', 'fa fa-star');
	var id = '#starVal'+no;
	$(id).val(idx);
	for(var i = 1; i <= idx; i++){

		document.getElementById('star'+i+'_'+no).className= 'fa fa-star checked';
	}
	 
}


// 0 다가올
// 1 지난
// 2 취소
// $('#all2').click(function(){  

// 	$('.rStatus_0').css("display", "block");
// 	$('.rStatus_1').css("display", "block");
// 	$('.rStatus_2').css("display", "block");

// });

// $('#coming2').click(function(){  
// 	$('.rStatus_0').css("display", "block");
// 	$('.rStatus_1').css("display", "none");
// 	$('.rStatus_2').css("display", "none");

// });

// $('#last2').click(function(){  
// 	$('.rStatus_0').css("display", "none");
// 	$('.rStatus_1').css("display", "block");
// 	$('.rStatus_2').css("display", "none");

// });

// $('#cancled2').click(function(){  
// 	$('.rStatus_0').css("display", "none");
// 	$('.rStatus_1').css("display", "none");
// 	$('.rStatus_2').css("display", "block");

// });


function allList(){  

	$('.rStatus_0').css("display", "block");
	$('.rStatus_1').css("display", "block");
	$('.rStatus_2').css("display", "block");

}

function commingList(){
	
	$('.rStatus_0').css("display", "block");
	$('.rStatus_1').css("display", "none");
	$('.rStatus_2').css("display", "none");

}

function lastList(){  
	$('.rStatus_0').css("display", "none");
	$('.rStatus_1').css("display", "block");
	$('.rStatus_2').css("display", "none");

}

function cancleList(){  
	$('.rStatus_0').css("display", "none");
	$('.rStatus_1').css("display", "none");
	$('.rStatus_2').css("display", "block");

}



</script>

</head>
<jsp:include page="../Top.jsp" flush="false"/>

<body>
<div class="w3-container" id="whole">
<h2 class="w3-left">내 예약 정보<i class="material-icons" style="font-size:60px; vertical-align: middle;">event</i></h2>
<span class="w3-right">총 ${fn:length(rList)}개의 내역</span>
<div class="w3-bar w3-green" id="filterbar">
  <a class="w3-bar-item w3-hover-white w3-padding" id="all2" onclick="allList()">전체보기</a>  
  <a class="w3-bar-item w3-hover-white w3-padding" id="last2" onclick="lastList()">지난 예약</a>
  <a class="w3-bar-item w3-hover-white w3-padding" id="coming2" onclick="commingList()">다가올 예약</a>
  <a class="w3-bar-item w3-hover-white w3-padding" id="cancled2" onclick="cancleList()">취소 내역</a>
 
</div>
<c:set var="size" value="${fn:length(rList)}"/>
<c:if test="${size == 0}">
<p align="center" style="color: grey">예약 내역이 없습니다</p>
</c:if>
<!-- ReservationController에서 넘겨받은 request영역안에 있는 백터를 꺼내서 백터 사이즈만큼 반복 -->
<c:forEach var="rList"  items="${requestScope.rList}">
<div class="rStatus_${rList.rStatus} w3-row w3-border-top w3-border-bottom" style="margin: 10px auto; display: block;'">
  <div class="w3-third w3-container ">
    <img src="upload/${rList.pic1}" style="width: 100%; height: 100%"/>
<%--     <h2>${rList.pic1}</h2> --%>
  </div>
  <div class="w3-rest w3-container ">
    <h5>${rList.subject}<!-- 공간이름 --> </h5>
    <p style="margin:2px;">${rList.room_type}</p>
    <hr style="margin: 3px;"/>
    <div id="reservContent_${rList.book_no}" style="display: block; height: 60px">
    
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
    <div id="reviewContent_${rList.book_no}" style="display: none; height: 60px">
    	<c:choose>
        	<c:when test = "${rList.rStatus == 0}">
				<span style="color: grey;">공간 사용 전입니다</span>
			</c:when>
			<c:when test = "${rList.rStatus == 1}">
				<c:if test="${rList.re_content eq null}">
					<div id="beforeWriting_${rList.book_no}" style="display:block;">
						<span style="color: grey;">작성된 리뷰가 없습니다</span>
<%-- 						<a onclick="writingForm(${rList.book_no})">리뷰 작성</a> --%>
						
						<a onclick="document.getElementById('writingForm_${rList.book_no}').style.display='block'" style="color: blue">리뷰 작성</a>
					</div>
					<!-- 여기서부터 모달 -->
					
					<div id="writingForm_${rList.book_no}" class="w3-modal">
						<div class="w3-modal-content w3-card-4" style="width: 300px;">
						<!-- 
							review_no 자동증가 
							book_no
							room_no
							email
							re_date
							re_point
							re_content
						 -->	
						 <form action="ReviewController.do" method="post">
						 	<input type="hidden" name="book_no" value="${rList.book_no}">
						 	<input type="hidden" name="room_no" value="${rList.room_no}">
						 	<input type="hidden" name="email" value="${rList.email}">
						 	<div class="w3-container w3-light-grey w3-padding">
								<span>평점 :</span>
								
								<a href="javascript:start(1, ${rList.book_no})"><span id="star1_${rList.book_no}" class="fa fa-star checked"></span></a> 
								<a href="javascript:start(2, ${rList.book_no})"><span id="star2_${rList.book_no}" class="fa fa-star checked"></span></a>
								<a href="javascript:start(3, ${rList.book_no})"><span id="star3_${rList.book_no}" class="fa fa-star checked"></span></a>
								<a href="javascript:start(4, ${rList.book_no})"><span id="star4_${rList.book_no}" class="fa fa-star checked"></span></a>
								<a href="javascript:start(5, ${rList.book_no})"><span id="star5_${rList.book_no}" class="fa fa-star"></span></a>
								<input type="hidden" name="re_point" value="4" id="starVal${rList.book_no}">
							
							</div>
				
							<div class="w3-container">
								<small style="margin: 1px; float:right;"><input type="text" id="byte${rList.book_no}" maxlength="3" size="3" value="0" style="text-align:right; border: none;" >/200byte</small>
								<textarea id="reviewArea${rList.book_no}" rows="5" cols="28" onkeypress="limit(${rList.book_no})"	name="re_content" style="resize:none; overflow:hidden; width:100%;  height: 200px;"></textarea>
							</div>
				
							<div class="w3-container w3-light-grey">
								<button type="button" class="w3-button w3-light-grey "
									onclick="document.getElementById('writingForm_${rList.book_no}').style.display='none'" >닫기</button>
								<button class="w3-button w3-right w3-light-grey "
									type="submit">완료</button>
							</div>
							
						</form>
						</div>
					</div><!--모달 여기까지-->
					
					
				</c:if>
				<c:if test="${rList.re_content ne null}">
					<p style="margin:2px;">별점:${rList.re_point}점 </p>
					<textarea rows="2" cols="30" readonly="readonly" style="border:none; height: 2em;">${rList.re_content}</textarea>
				</c:if>
				
			</c:when>
			<c:when test = "${rList.rStatus == 2}">
				<span style="color: grey;">취소된 예약입니다</span>
			</c:when>
		</c:choose>
    	
    	
    	
    </div>
    <div>
	  	<button class="w3-button w3-blue w3-padding-small" onclick="tog('reservContent_${rList.book_no}', 'reviewContent_${rList.book_no}')">예약 보기</button>&nbsp;
	  	<button class="w3-button w3-blue w3-padding-small" onclick="tog('reviewContent_${rList.book_no}', 'reservContent_${rList.book_no}')">리뷰 보기</button>&nbsp;
	  	<button class="w3-button w3-blue w3-padding-small" onclick="location.href='m_detail?room_no=${rList.room_no}'">다시 예약</button>&nbsp;
 		<button class="w3-button w3-blue w3-padding-small" onclick="reserve_delete('${rList.book_no }','${rList.rStatus }','${rList.total_price }');">예약 취소</button>&nbsp;
 	</div>
  </div>
</div>
</c:forEach>

</div>
</body>
<div class="w3-cell-bottom" style="padding-bottom: 0px;">
<jsp:include page="../Footer.jsp" flush="false"/>
</div>
<script type="text/javascript">
	// 예약 취소 버튼 클릭시 이벤트
	/**예약 상태 추출 메소드
	 * 0: 사용 전 예약
	 * 1. 지난 예약
	 * 2. 취소된 예약*/
	function reserve_delete(book_no, status, total_price){
		// status 상태값 체크
		if(status=="1"){
			alert("예약일자가 지났습니다. 취소가 불가능 합니다.");
		}else if(status=="2"){
			alert("이미 취소된 예약 입니다.");
		}else{
			if(confirm("등록된 예약을 취소 하시겠습니까?")){
				// 해당 로그인된 이메일 정보와 예약 번호, 포인트를 넘겨 주어야한다.
				var email = "${sessionScope.udto.email}";			
				if(email==""){
					email= "${sessionScope.hdto.email}";
				}				
				location.href="./BookingCancelController.do?book_no="+book_no+"&email="+email+"&total_price="+total_price;
			}
		}
		
	}
</script>

</html>