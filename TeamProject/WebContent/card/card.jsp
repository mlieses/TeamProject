<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Tangerine">
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

<title>ShareSpace : Card</title>
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
<style type="text/css">
	#btn { position: fixed;
			left: 20px;
			bottom: 20px;}
	.w3-card-4 { border-radius : 30px;
			padding: 2px;
			position: fixed;
			left: 20px;
			bottom: 20px;}
	h4{text-align: center;}
	.w3-container { border-radius : 30px 30px 0 0;}
	#body{ border-radius : 0 0 0 0;
			top: 5px;
			height: 180px;}
	#foot { border-radius : 0 0 30px 30px;}
	 h5{text-shadow: 3px 2px 3px gray;
	 	color: white;
	 	text-align: center;}
	
</style>
</head>
<body>

<div class="w3-dropdown-hover">
  <button id="btn" class="w3-button w3-teal w3-xlarge">+</button>
    
  <div class="w3-card-4 w3-dropdown-content" style="width:250px;">
    <header id="head" class="w3-container w3-teal">
      	<h4>님의 카드현황</h4>
    </header>

    <div id="body" class="w3-container w3-sand">
    	<div class="w3-container" id="whole">
		<h6 class="w3-left">현재 진행중인 예약 현황</h6>
			<br/>
<%-- 		<span class="w3-right">총 ${fn:length(rList)}개의 내역</span> --%>
<%-- 		<c:set var="size" value="${fn:length(rList)}"/> --%>
			<c:if test="${size == 0}">
			<p align="center" style="color: grey">예약 내역이 없습니다</p>
			</c:if>
		</div>
    </div>

    <footer id="foot" class="w3-container w3-sand">
      <h5>ShareSpace</h5>
    </footer>
  </div>
  
  </div>

</body>
</html>