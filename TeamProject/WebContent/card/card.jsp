<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	/* <jsp:include page="../Top.jsp" flush="false"/>
		동적 페이지 폴더 변경 */		
	String servlet = request.getServletPath();
	//StringTokenizer st = new StringTokenizer(servlet,"/");
		
	//System.out.println(servlet+" : "+st.countTokens());
	//String folder = st.nextToken();
	
	// 홈화면버튼 동적경로 지정
	String path="";
	String path1="";
	String path2 = "user/";
	
	
	request.setAttribute("path", path);
	request.setAttribute("path1", path1);
	request.setAttribute("path2", path2);
%>

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
//일반회원 0, 호스트회원 1
var login_flag=0;


$(document).ready(function() {	  
	
// 	<!-- 구글 로그인 구현 -->
// 	<!-- 구글 CLIENT_ID : 463533794318-unijrkh4odbf94n2pms494toetghdgir.apps.googleusercontent.com -->
// 	<!-- 구글 redirect_uri : http://localhost:8080/TeamProj/google-->
// 	<!-- 구글 client_secret : Vwl1rm1fi2naT41YevXIP7IB -->
	$("#google-sign").click(function(){	
		var popUrl ="https://accounts.google.com/o/oauth2/v2/auth?"
			+"redirect_uri=http://localhost:8181/TeamProject/google&"
			+"response_type=code&"			
			+"client_id=463533794318-unijrkh4odbf94n2pms494toetghdgir.apps.googleusercontent.com&"
			+"scope=openid%20email&"
			+"access_type=offline";	
			//팝업창에 출력될 페이지 URL
	
	var popOption = "width=400, height=500, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
	
	var win = window.open(popUrl,"",popOption);		
		
   });
// 	<!-- Rest API 키  :  7bed2c2cc35da2f635429b5665085d84 -->
// 	<!-- /PrivateProject1225/kakao -->
// 	<!-- “https://kauth.kakao.com/oauth/authorize?client_id=7bed2c2cc35da2f635429b5665085d84
// 	&redirect_uri=http://localhost:8181/TeamProj/kakao&response_type=code” -->	
	$("#kakao-sign").click(function(){	
		var popUrl ="https://kauth.kakao.com/oauth/authorize?client_id=7bed2c2cc35da2f635429b5665085d84"
			+"&redirect_uri=http://localhost:8181/TeamProject/kakao&response_type=code";	
			//팝업창에 출력될 페이지 URL
	
	var popOption = "width=400, height=500, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
	
	var win = window.open(popUrl,"",popOption);		
		
   });
   
   // 로그인 모달 호스트 로그인 체크박스 이벤트
   $("#host_login").click(function(){
	   
	   if($("#host_login").is(":checked")){
		   
		   if(confirm("호스트 로그인 하시겠습니까?")){
			   $(".lbl_email").text("호스트 아이디");
			   $(".lbl_pass").text("호스트 비밀번호");
			   $("input[name='email']").attr("placeholder","호스트 아이디");
			   $("input[name='email']").val("");
			   $("input[name='pass']").attr("placeholder","호스트 비밀번호");
			   $("input[name='pass']").val("");
			   login_flag = 1;
		   }else{
			   $("#host_login").prop("checked",false);
		   }
		   
	   }else{		   
		   $(".lbl_email").text("이메일");
		   $(".lbl_pass").text("비밀번호");
		   $("input[name='email']").attr("placeholder","이메일");
		   $("input[name='email']").val("");
		   $("input[name='pass']").attr("placeholder","비밀번호");
		   $("input[name='pass']").val("");
		   login_flag = 0;
	   }
	   
   });		
	
	
});

// 모달 로그인 버튼 클릭시
function login_click(){
	// action="${path1}./UserLoginController.do" 
	// login_flag == 0 일반회원 로그인
	// login_flag == 1 호스트회원 로그인
	if(login_flag == 0 ){
		document.login_form.action = "${path1}./UserLoginController.do";
		document.login_form.submit();	
	}else{		
		document.login_form.action = "${path1}./HostLoginController.do";
		document.login_form.submit();		
	}
}

function host_click_modal() {
	
	 var y = document.getElementById("drop_host");
	 if (y.className.indexOf("w3-show") == -1) {
		    y.className += " w3-show";
		  } else { 
		    y.className = y.className.replace(" w3-show", "");
	 }
}

function host_space(){
	location.href="./detailPageController.do?a=7";
 }
/* ------------------  */

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
      	<h4>${sessionScope.udto.name }님의 카드현황</h4>
    </header>

    <div id="body" class="w3-container w3-sand">
    	<div class="w3-container" id="whole">
    	 <c:choose>
	    	<%-- 일반 회원이 로그인 됐을 때 --%>
	      	<c:when test="${email ne null }">
			<h6 class="w3-left"> ${sessionScope.udto.email} 현재 진행중인 예약 현황</h6>
				<br/>
				<span class="w3-right">총 ${fn:length(rList)}개의 내역</span>
				<c:set var="size" value="${fn:length(rList)}"/> 
				<c:if test="${size == 0}">
				<p align="center" style="color: grey">예약 내역이 없습니다</p>
				</c:if>
			<%-- 일반회원 또는 호스트회원 로그인이 둘다 안되있을 때 --%>
	      	<c:otherwise>
	      		<a href="${path1}./UserSingUp_authController.do" class="w3-bar-item w3-button">회원가입</a>
	      		<a href="#home" class="w3-bar-item w3-button" onclick="document.getElementById('id01').style.display='block'">로그인</a><!-- 로그아웃 -->     	
	      	</c:otherwise>	
			</c:when>
		</c:choose>
		</div>
    </div>

    <footer id="foot" class="w3-container w3-sand">
      <h5>ShareSpace</h5>
    </footer>
  </div>
  
  </div>

</body>
</html>