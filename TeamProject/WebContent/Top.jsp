<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	/* <jsp:include page="../Top.jsp" flush="false"/>
		동적 페이지 폴더 변경 */		
	String servlet = request.getServletPath();
	StringTokenizer st = new StringTokenizer(servlet,"/");
		
	System.out.println(servlet+" : "+st.countTokens());
	String folder = st.nextToken();
	
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
<title>Insert title here</title>
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
	
   // 프리미엄 호스트 로그인시
   if("${sessionScope.hdto.host_level}" == 3 ){
	   $(".icon_crown").append("<i class='fas fa-crown' style='font-size:20px;color:blue;padding:0;margin:0'></i>");
   }
	
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
	location.href="./detailPageController.do?a=7&HostId=${sessionScope.hdto.host_id}";
 }
</script>
<style type="text/css">
a{
   text-decoration:none;
}
 .w3-bar-item{
  letter-spacing: 1px;
  font-family: "Nanum Barun Gothic" !important; 
  color: #666666;
  font-style: bold;
}
.user_drop>a{
	border-bottom: 1px solid #f2f2f2;
}
.user_drop>a:HOVER{
	border-bottom: 1px solid black;
}	

.nav_top{	
	height: 55px;
	z-index: 100;
}
</style>
</head>
<body>
<!-- Navbar 복사4-->
<div class="w3-top">
  <div class="w3-bar w3-white w3-wide w3-padding w3-card  nav_top">
    <a href="${path}index.jsp" class="w3-bar-item w3-button"><b>SS</b> share space</a>
    <c:set var="email" value="${sessionScope.udto.email }"/>
    <c:set var="host_id" value="${sessionScope.hdto.host_id }"/>
    <div class="w3-right w3-hide-small" ">   		      
      <c:choose>
      	<%-- 일반 회원이 로그인 됐을 때 --%>
      	<c:when test="${email ne null }">      		 		
      		<a href="#about" class="w3-bar-item w3-button" onclick="stars_click()"><i class="material-icons">stars</i></a>
      		<a href="${path1}./ReservationController.do?userId=${sessionScope.udto.email}" class="w3-bar-item w3-button">내 예약관리</a>
      		<div class="w3-dropdown-click">
      			<button onclick="click_modal()" class="w3-bar-item w3-button w3-dark-grey">${sessionScope.udto.name }</button>
      			<div id="drop" class="w3-dropdown-content w3-bar-block w3-card-4  w3-animate-zoom user_drop" style="right:0; width: 200px; top:56px; z-index: 9999">
      				<small>&nbsp;&nbsp;${sessionScope.udto.email} &nbsp;&nbsp;보유 포인트 : </small>    
      				<br><font color="red" class="w3-margin-left">${sessionScope.udto.point} </font> <small>포인트(￦)</small>  				   				
      				<hr>
      				<a href="${path1}./UserPageController.do" class="w3-bar-item w3-button">프로필수정/탈퇴</a>
      				<a href="${path1}./UserLogoutController.do" class="w3-bar-item w3-button">로그아웃</a>      				
    			</div>
      		</div>	
      		<%-- <a href="${path1}./UserLogoutController.do" class="w3-bar-item w3-button">로그아웃</a> --%> 
      	</c:when>
      		
      	<%-- 호스트 회원이 로그인 됐을 때 --%>	
      	<c:when test="${host_id ne null }">	      		
   			<a href="#about" class="w3-bar-item w3-button" onclick="host_space()"><i class="material-icons">stars</i></a>  			
   			<a href="${path1}./ReservationController.do?userId=${sessionScope.udto.email}" class="w3-bar-item w3-button">내 예약관리</a>
   			<div class="w3-dropdown-click">
   				<button onclick="host_click_modal()" class="w3-bar-item w3-button w3-orange">
   					<small class="icon_crown"></small>&nbsp;${sessionScope.hdto.host_nic }</button>
   				<div id="drop_host" class="w3-dropdown-content w3-bar-block w3-card-4  w3-animate-zoom user_drop" style="right:0; width: 200px; top:56px; z-index: 9999">
   						<small>&nbsp;&nbsp;${sessionScope.hdto.email} &nbsp;&nbsp;보유 포인트 : </small>    
      				<br><font color="red" class="w3-margin-left">${sessionScope.point} </font> <small>포인트(￦)</small>	  				   				
      				<hr>
   					<a href="${path1}./HostPageController.do" class="w3-bar-item w3-button">프로필수정/탈퇴</a>
   					<a href="${path1}./(링크)" class="w3-bar-item w3-button">리뷰</a>  					
   					<a href="${path1}./HostLogoutController.do" class="w3-bar-item w3-button">로그아웃</a>      				
 				</div>
   			</div>	
      	</c:when>		
      	
      	<%-- 일반회원 또는 호스트회원 로그인이 둘다 안되있을 때 --%>
      	<c:otherwise>
      		<a href="${path1}./UserSingUp_authController.do" class="w3-bar-item w3-button">회원가입</a>
      		<a href="#home" class="w3-bar-item w3-button" onclick="document.getElementById('id01').style.display='block'">로그인</a><!-- 로그아웃 -->     	
      	</c:otherwise>	
      </c:choose>            
    </div>
  </div>
</div>
<!-- 복사4종료  -->
<!-- 모달창 시작 -->
<div class="w3-container">  
  <div id="id01" class="w3-modal">
    <div class="w3-modal-content w3-card-4 w3-animate-zoom" style="max-width:600px">	
	  <header class="w3-container w3-teal w3-center"> 
	    <span onclick="document.getElementById('id01').style.display='none'" 
	          class="w3-button w3-xlarge w3-hover-red w3-display-topright" title="Close Modal">&times;</span>
	    <h2><i class="w3-xxlarge fa fa-user"></i>회원 로그인</h2>
	  </header>
      <form class="w3-container" name="login_form" method="post">
        <div class="w3-section">        
          <label><b class="lbl_email">이메일</b></label>
          <input class="w3-input w3-border w3-margin-bottom" type="text" placeholder="이메일" name="email" required>
          <label><b class="lbl_pass">비밀번호</b></label>
          <input class="w3-input w3-border" type="password" placeholder="비밀번호" name="pass" required>
          <input class="w3-check w3-margin-top" type="checkbox" id="host_login""> 호스트 로그인
          <button class="w3-button w3-block w3-green w3-section w3-padding" type="button" onclick="login_click()">로그인</button>
       	  <span class="w3-right w3-padding w3-hide-small">비밀번호를 잊으셨거나 변경이 필요하신가요? <a href="#"><font color="blue">비밀번호 재설정</font></a></span>
        </div>
      </form>
      	<hr>
      	<div class="w3-container w3-center">또는</div>
      <div class="w3-container w3-center w3-margin-bottom"><br>
      	<img src="${path}img/btn_google_signin_dark_normal_web@2x.png" height="60px" width="50%" id="google-sign"
      	onmouseover="this.src='${path}img/btn_google_signin_dark_focus_web@2x.png';" onmouseout="this.src='${path}img/btn_google_signin_dark_normal_web@2x.png';">        
        <img src="${path}img/kakao_account_login_btn_medium_narrow.png" height="55px" width="48%" id="kakao-sign"
        onmouseover="this.src='${path}img/kakao_account_login_btn_medium_narrow_ov.png';" onmouseout="this.src='${path}img/kakao_account_login_btn_medium_narrow.png';">       
      
      </div>      	
      <div class="w3-container w3-border-top w3-padding-16 w3-teal">
        <button onclick="document.getElementById('id01').style.display='none'" type="button" class="w3-button w3-red">Cancel</button>
        <span class="w3-right w3-padding w3-hide-small">share space의 회원이 아니신가요? <a href="${path1}./UserSingUp_authController.do"><font color="blue">회원 가입</font></a></span>
      </div>

    </div>
  </div>
</div>

<!-- 모달창 종료 -->
<script type="text/javascript">
 function click_modal() {
  var x = document.getElementById("drop");  
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else { 
    x.className = x.className.replace(" w3-show", "");
  }  
} 

 // 상단 호스트 별표 클릭시
 function stars_click(){	 
	 if("${sessionScope.udto.host_check}" != 1){		 
	 	if(confirm("호스트 등록이 되어있지 않습니다. 호스트 가입 하시겠습니까?")){
			 location.href="./HostController.do";
		}		 
	 }else{
		 alert("회원님은 이미 호스트가입이 되어 있습니다. 호스트 로그인 해주십시오.");
		 
	 }	
 }
 

</script>

</body>
</html>