<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- 복사 1 font -->
<link href='https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css' rel='stylesheet' type='text/css'>

<!-- 복사2 google icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<!-- awsome icon -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" 
integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<title>Insert title here</title>
<style type="text/css">
div{
	padding: 0;
	margin: 0;
}
body{
	padding-top: 55px;
}
.con{
	border: 1px solid white;
	margin-top: 55px;	
}
.div_left{
	border: 1px solid white;	
	padding : 25px;
	
}
.div_right{		
	padding : 25px;	
}
.div_hr{
	margin:10px 0;
}
.div_sticky{
	position: sticky;
	top: 55px;	
}

small{
	/* border: 1px solid white; */
}
.div_table{

	border-left : 1px solid grey;	
	border-right: 1px solid grey;
	border-bottom: 1px solid grey;
}
</style>
<script type="text/javascript">
	// 유료옵션들을 변수에 담는다.	
	var parking =  parseInt("${boodto.parking}");
	var wifi =  parseInt("${boodto.wifi}");
	var projector =  parseInt("${boodto.projector}");
	var laptop =  parseInt("${boodto.laptop}");
	var cabinet =  parseInt("${boodto.cabinet}");
	var totalPay = parseInt("${allPrice}");
	
	$(document).ready(function(){	
		/* 등록된 공간의 유료옵션 유무 */
		if(parking == 0){
			$("#chk_1").attr("disabled", true );
		}
		if(wifi == 0){
			$("#chk_2").attr("disabled", true );
		}
		if(projector == 0){
			$("#chk_3").attr("disabled", true );
		}
		if(laptop == 0){
			$("#chk_4").attr("disabled", true );
		}
		if(cabinet == 0){
			$("#chk_5").attr("disabled", true );
		}	
		/* 유료옵션 클릭시 결제 정보에 가격 추가 */
		$("#chk_1").click(function(){
			if($("#chk_1").is(":checked")){
				$("#div_add1").append("<div class='w3-row'><div class='w3-col m6'>	주차 :</div><div class='w3-col m6' align='right'>+"+parking+"</div></div>");	
				totalPay += parking;
			}else{
				$("#div_add1").empty();
				totalPay -= parking;
			}
			$(".price").text(totalPay);			
		});
		$("#chk_2").click(function(){
			if($("#chk_2").is(":checked")){
				$("#div_add2").append("<div class='w3-row'><div class='w3-col m6'>	무선인터넷 :</div><div class='w3-col m6' align='right'>+"+wifi+"</div></div>");	
				totalPay += wifi;
			}else{
				$("#div_add2").empty();
				totalPay -= wifi;
			}
			$(".price").text(totalPay);			
		});
		$("#chk_3").click(function(){
			if($("#chk_3").is(":checked")){
				$("#div_add3").append("<div class='w3-row'><div class='w3-col m6'>	빔프로젝트 :</div><div class='w3-col m6' align='right'>+"+projector+"</div></div>");	
				totalPay += projector;
			}else{
				$("#div_add3").empty();
				totalPay -= projector;
			}
			$(".price").text(totalPay);			
		});
		$("#chk_4").click(function(){
			if($("#chk_4").is(":checked")){
				$("#div_add4").append("<div class='w3-row'><div class='w3-col m6'>	컴퓨터 :</div><div class='w3-col m6' align='right'>+"+laptop+"</div></div>");	
				totalPay += laptop;
			}else{
				$("#div_add4").empty();
				totalPay -= laptop;
			}
			$(".price").text(totalPay);
						
		});
		$("#chk_5").click(function(){
			if($("#chk_5").is(":checked")){
				$("#div_add5").append("<div class='w3-row'><div class='w3-col m6'>	사물함 :</div><div class='w3-col m6' align='right'>+"+cabinet+"</div></div>");	
				totalPay += cabinet;
			}else{
				$("#div_add5").empty();
				totalPay -= cabinet;
			}
			$(".price").text(totalPay);	
		});
		
		$(".price").text(totalPay);	
		
	});
	
	
	
</script>
</head>
<body>

<!-- 최상단 네비 바 시작 -->
<jsp:include page="../Top.jsp" flush="false"/>
<!-- 최상단 네비 바 종료 -->
<!-- 본문 시작 -->
	<!-- 일반 유저 / 호스트 구분 시작 -->
	<c:set var="email" value="${sessionScope.udto.email }"/>
	<c:set var="point_book" value="${sessionScope.udto.point }"/>    					
	<c:if test="${email eq null }"> 
    	<c:set var="email" value="${sessionScope.hdto.email }"/>
		<c:set var="point_book" value="${sessionScope.point}"/>				
    </c:if>
    <!-- 일반 유저 / 호스트 구분  끝-->
	<form action="./bookingInsertController.do" method="post" name="form_insert">
		<!-- insert 할 값들을 넘겨 주기 -->
		<input type="hidden" name="roomNumber" value="${roomNumber }"><!-- 룸넘버 -->
		<input type="hidden" name="selectDate" value="${selectDate }"><!-- 선택날짜 -->
		<input type="hidden" name="selectTime" value="${selectTime }"><!-- 선텍시간 -->	
		<input type="hidden" name="totalPay" value=""><!-- 총금액 -->
		<input type="hidden" name="startTime" value="${startTime }"><!-- 시작시간 -->
		<input type="hidden" name="usingTime" value="${time }"><!-- 이용시간 -->
		<input type="hidden" name="email" value="${email }"><!-- email -->
		<input type="hidden" name="point" value="${point_book }"><!-- 현재 보유 포인트 -->
		<!-- 전체 div -->	
		<div class="w3-row">
		<!-- div 오른쪽 시작 -->
			<div class="w3-col m2"><p> </p></div>				
			<div class="w3-col m5 div_left" align="left">
				<div class="w3-row">
					<div class="w3-col m5">		
						<img alt="${boodto.subject }" src="./upload/${boodto.pic1 }" width="270" height="170">
					</div>
					<div class="w3-col m1">
					<p></p>
					</div>	
					<div class="w3-col m3">
						<h2>${boodto.subject }</h2>
						<p>${boodto.content }</p>
					</div>
				</div>
				<hr>
				<div class="w3-row">
					<div class="w3-col m5">
						<h5>시작시간</h5>
					</div>
					<div class="w3-col m7">
						<h5><b>${selectDate }&nbsp;&nbsp;${startTime } 시</b></h5>
					</div>
				</div>
				<hr>
				<div class="w3-row">
					<div class="w3-col m5">
						<h5>총 예약시간</h5>
					</div>
					<div class="w3-col m7">
						<h5><b>${time} 시간</b></h5>
					</div>
				</div>
				<hr>
				<div class="w3-row">
					<div class="w3-col m12">
						<h5>유료 부대시설</h5>
						<input type="checkbox" id="chk_1" name = "parking" class="w3-check" value="${boodto.parking }"><b> 주차</b> &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" id="chk_2" name = "wifi" class="w3-check" value="${boodto.wifi }"><b> 무선 인터넷</b>  &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" id="chk_3" name = "projector" class="w3-check" value="${boodto.projector}"><b> 빔 프로젝트</b>  &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" id="chk_4" name = "laptop" class="w3-check" value="${boodto.laptop }"><b> 컴퓨터</b>  &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" id="chk_5" name = "cabinet" class="w3-check" value="${boodto.cabinet }"><b> 사물함</b>  &nbsp;&nbsp;&nbsp;&nbsp;
						<p class="w3-margin-top">각 유료 부대시설은 각각의 요금이 다르며 해당 가격 표는 아래와 같습니다.</p>
						<p>주차 : ${boodto.parking }원</p>
						<p>무선 인터넷 : ${boodto.wifi }원</p>
						<p>빔 프로젝트 : ${boodto.projector }원</p>
						<p>컴퓨터 : ${boodto.laptop }원</p>
						<p>사물함 : ${boodto.cabinet }원</p>
						
					</div>
				</div>
				<hr>
				<div class="w3-row">
					<div class="w3-col m12">
						<h5>취소 및 환불 규정</h5>
						<div class="w3-col m6 w3-dark-grey" align="center">
							<h6>취소 기준일</h6>
						</div>
						<div class="w3-col m6 w3-dark-grey" align="center">
							<h6>취소 수수료</h6>
						</div>
						<div class="w3-col m6 div_table" align="center">
							<h6>입실 1일 전</h6>
						</div>
						<div class="w3-col m6 div_table" align="center">
							<h6>없음</h6>
						</div>
						<div class="w3-col m6 div_table" align="center">
							<h6>당일</h6>
						</div>
						<div class="w3-col m6 div_table" align="center">
							<h6>환불 불가</h6>
						</div>
						<div class="w3-col m12 w3-margin-top">
							● 취소 규정이 적용되는 기준은 체크인 입니다.
						</div>
						<div class="w3-col m12">
							● 취소 수수료는 판매금액을 기준으로 계산 됩니다.
						</div>
											
					</div>
				</div>
				<hr>
				<div class="w3-row">
					<h5>필수 입력사항</h5>
					<div class="w3-row  w3-margin-top">
						<div class="w3-col m2"> 
							<p>이메일</p>
						</div>
						<div class="w3-col m4">						    					
    						<input type="text" class="w3-input" placeholder="예약자 이메일" name="email" value="${email }" disabled="disabled">												
						</div>
					</div>
					<div class="w3-row w3-margin-top">
						<div class="w3-col m2">
							<p>휴대 전화</p>
						</div>
						<div class="w3-col m4">
							<input type="text" class="w3-input" placeholder="예약자 전화번호" name="book_phone" maxlength="11">
						</div>
						<div class="w3-col m3" align="center">
							<button type="button" class="w3-button w3-white w3-border w3-border-red w3-round-large" id="phone_check">인증번호 전송</button>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m2">
							<p></p>
						</div>
						<div class="w3-col m10">
							<small>● 입력한 휴대전화 번호는 안심번호로 변경되어 호스트에게 전달 됩니다.</small>
						</div>						
					</div>					
					<div class="w3-row w3-margin-top">
						<div class="w3-col m2">
							<p> </p>
						</div>
						<div class="w3-col m4">
							<input type="text" class="w3-input" placeholder="인증번호" name="book_phone_2">
						</div>
						<div class="w3-col m3" align="center">
							<button type="button" class="w3-button w3-white w3-border w3-border-red w3-round-large" id="phone_check">인증번호 확인</button>
						</div>
					</div>
				</div>
				<hr>
				<div class="w3-row">
					<div class="w3-col m12">
						<h5>공지 사항</h5>
						<p><small>● 해당 공간의 호스트 사정으로 인한 취소 발생시 100% 환불 가능 합니다.</small></p>
						<p><small>● 해당 공간의 호스트 사정으로 객실 정보가 수시로 변경될 수 있습니다. 이로인한 불이익은 당사가 책임지지 않습니다.</small></p>
					</div>
				</div>
				<hr>				
			</div>
		   <!-- div 오른쪽 끝 -->
		   <!-- div 왼쪽 고정 바 시작 -->
			<div class="div_sticky">		
				<div class="w3-col m3 div_right w3-dark-grey w3-margin-bottom">
					<div class="w3-row">					
						<div class="w3-col m12">							
							<h5>예약일</h5>
						</div>	
						<div class="w3-col m12">
							<font size="6px"><b>${selectDate}</b></font>
						</div>							
						<div class="w3-col m12">						
						</div>						
					</div>
				</div>			
				<div class="w3-col m3 div_right w3-dark-grey">
					<div class="w3-row">					
						<div class="w3-col m6">						
							예약 인원
						</div>						
						<div class="w3-col m6" align="right">										
							<!-- 예약인원 소,중,대 상세표시 -->
							<c:set var="book_people" value="${boodto.people}"/>					
							<c:if test="${book_people eq '소' }">
								<c:set var="book_people" value="${boodto.people}(1~4명)"/>
							</c:if>
							<c:if test="${book_people eq '중'}">
								<c:set var="book_people" value="${boodto.people}(5~10명)"/>
							</c:if>
							<c:if test="${book_people eq '대'}">
								<c:set var="book_people" value="${boodto.people}(10명~20명)"/>
							</c:if>
							${book_people}
							
						</div>												
					</div>
					<hr>
					<div class="w3-row">					
						<div class="w3-col m6">						
						   <h4>보유 포인트</h4> 
						</div>
						<div class="w3-col m6" align="right">						
							<h3><font color="yellow">-${point_book }</font></h3>
						</div>												
					</div>
					
					<hr>
					<div class="w3-row">					
						<div class="w3-col m6">						
							<h6>옵션</h6>
						</div>
						<div class="w3-col m6" align="right">						
						</div>												
					</div>					
					<div id="div_add1"></div>
					<div id="div_add2"></div>
					<div id="div_add3"></div>
					<div id="div_add4"></div>
					<div id="div_add5"></div>				
					<hr>
					<div class="w3-row">					
						<div class="w3-col m6">						
							<h3><font color="red">결제금액</font></h3>
						</div>
						<div class="w3-col m6" align="right">
							<h2><font color="red" class="price"></font></h2>						
						</div>												
					</div>					
				</div>				
				<div class="w3-col m3">
					<div class="w3-row">
						<div class="w3-col m12">						
							 <input type="button" id="btn_submit" class="w3-button w3-block w3-xlarge w3-red" value="결제하기" onclick="javascript:func_insert();">
						</div>
					</div>
				</div>				
				<div class="w3-col m2"><p> </p></div>			
			</div>
			<!-- div 왼쪽 고정 바 끝 -->
		</div>
		<!-- 전체 div 끝-->
	</form>	
<!-- 본문 종료 -->

<!-- 최상단 네비 바 시작 -->
<jsp:include page="../Footer.jsp" flush="false"/>
<!-- 최상단 네비 바 종료 -->
<script type="text/javascript">
/* 폼전송시 체크 함수 */
function func_insert(){		
	var point_book = parseInt("${point_book}");
	var book_tel = $("input[name='book_phone']").val();
	// 휴대전화 번호 인증 정규식
	var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;	
	if(!regPhone.test(book_tel)){
		alert("전화번호 형식에 맞게 입력해 주세요");
		 $("input[name='book_phone']").focus();
		return false;
	}
	
	if(totalPay > point_book){			
		alert("포인트가 부족합니다 충전해 주세요");
		return false;
	}
	// 현재 결제할 총 가격
	document.form_insert.totalPay.value = totalPay;
	document.form_insert.submit();
}


</script>
</body>
</html>