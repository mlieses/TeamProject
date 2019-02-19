<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
<title>Insert title here</title>
<script type="text/javascript">
// 이메일 중복체크 ajax
$(document).ready(function() {
	$("#user_id_check").click(function(){
		
		var flag = -1;		
		var email = $("input[name='user_email']").val();
		var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);

		
		if(!getMail.test(email) || email ==""){
			alert("형식에 맞게 입력해주세요!");
			$("input[name='email']").focus();
			 return false;
		}	
		
		//ID정규표현식을 이용하여 입력한 email값이 맞을 경우(통과)
		$.ajax({
			type : "POST",
			url  : "./HostIdCheck.do",
			data: {"email": email}, //{parameterName, data} 형식
			success: function(result){					
				flag = result;		  	
				
				if(flag==0){
					$("#p_alert").text("*등록된 이메일이 존재 합니다");
					$("#p_alert").css("color","red");
					$("#btn_submit").attr("disabled",true);
					 return false;
				}else if(flag==-1){
					$("#p_alert").text("*사용 가능한 이메일 입니다.");
					$("#p_alert").css("color","blue");
					$("#btn_submit").attr("disabled",false);
					$("#user_id_check").attr("disabled",true);
					 return false;
				}		 		
				
			}
		});// ajax 끝	
	
	}); // 중복 체크버튼 이벤트 끝
	
	//이메일 입력이 다시 일어날 때 이벤트
	$("input[name='user_email']").keyup(function() {
		var disabled = $("#user_id_check").is(":disabled");
		//alert("111"+disabled);
		$("#p_alert").text("");			

		if(disabled == true){
			//alert("비활성화");
			$("#p_alert").text("");			
			$("#btn_submit").attr("disabled",true);
			$("#user_id_check").attr("disabled",false);
		}
		
	});	

});// ready 끝




// 유효성 검증
function user_signup() {
	
	var user_pass = $("input[name='user_pass']").val();
	var user_pass_ck = $("input[name='user_pass_ck']").val(); 
	var getCheck= RegExp(/^[a-zA-Z0-9]{4,12}$/);
	
	
	if(!getCheck.test(user_pass) || user_pass ==""){
		alert("비밀번호 형식에 맞게 입력해주세요!");
		 $("input[name='user_pass']").focus();
		 return false;
	}
	
	if($("input[name='name']").val()==""){
		alert("닉네임을 입력해주세요");
		$("input[name='name']").focus();
		return false;			
	}	
	if(user_pass != user_pass_ck){
		alert("비밀번호가 다릅니다.");
		$("input[name='user_pass']").focus();
		return false;			
	}
	
	
	document.user_form.submit();	
	
}

	

</script>
</head>
<body>
<!-- 최상단 네비 바 시작 -->
<jsp:include page="../Top.jsp" flush="false"/>
<!-- 최상단 네비 바 종료 -->
<!-- 본문 시작 -->
 <form action="./UserSignUpController.do" method="post" name="user_form">
	<div class="w3-container w3-margin-top">
		<div class="w3-row w3-margin-top"></div>
		<div class="w3-row w3-margin-top"></div>
		<div class="w3-row w3-margin-top"></div>	
		<div class="w3-row w3-margin-top"></div>
		<h1 class="w3-center  w3-margin-top"><b>SS</b> share space 회원 가입</h1>
		
		<div class="w3-row w3-margin-top"></div>
		<div class="w3-row w3-margin-top">
			<div class="w3-col m4 "><p> </p></div>		
			<div class="w3-col m4 w3-dark-grey w3-left">
				<p>&nbsp;&nbsp;&nbsp;<i class="w3-xxlarge fa fa-envelope"></i></p> 
			</div>
			<div class="w3-col m4"><p> </p></div>
		</div>
		<div class="w3-row w3-margin-top">
			<div class="w3-col m4"><p> </p></div>		
			<div class="w3-col m3 ">
				 <input type="text" class="w3-input" placeholder="이메일" name="user_email">
			</div>
			<div class="w3-col m1">
				<button type="button" class="w3-button w3-white w3-border w3-border-red w3-round-large" id="user_id_check">중복확인</button>
			</div>
			<div class="w3-col m4"><p> </p></div>
		</div>
		<div class="w3-row">
			<div class="w3-col m4"><p> </p></div>
			<div class="w3-col m4"><small>● 회원 로그인시 이메일 정보가 필요 합니다.<font color="red">(필수)</font></small></div>
			<div class="w3-col m4"><p> </p></div>
		</div>
		<div class="w3-row" >
			<div class="w3-col m4"><p> </p></div>	
			<div class="w3-col m4" id="p_alert"></div>
			<div class="w3-col m4"><p> </p></div>	
		</div>
		<div class="w3-row w3-margin-top"></div>
		<div class="w3-row w3-margin-top">
			<div class="w3-col m4 "><p> </p></div>		
			<div class="w3-col m4 w3-dark-grey w3-left">
				<p>&nbsp;&nbsp;&nbsp;<i class="w3-xxlarge fa fa-user"></i></p> 
			</div>
			<div class="w3-col m4"><p> </p></div>
		</div>
		<div class="w3-row w3-margin-top">
			<div class="w3-col m4"><p> </p></div>		
			<div class="w3-col m4 ">
				 <input type="text" class="w3-input" placeholder="닉네임" name="name">
			</div>
			<div class="w3-col m4"><p> </p></div>
		</div>
		<div class="w3-row">
			<div class="w3-col m4"><p> </p></div>
			<div class="w3-col m4"><small>● 회원 로그인후 보여줄 닉네임 입니다.<font color="red">(필수)</font></small></div>
			<div class="w3-col m4"><p> </p></div>
		</div>		
		<div class="w3-row w3-margin-top"></div>
		<div class="w3-row w3-margin-top">
			<div class="w3-col m4 "><p> </p></div>		
			<div class="w3-col m4 w3-dark-grey w3-left">
				<p>&nbsp;&nbsp;&nbsp;<i class="w3-xxlarge fa fa-unlock-alt"></i></p> 
			</div>
			<div class="w3-col m4"><p> </p></div>
		</div>
		<div class="w3-row w3-margin-top">
			<div class="w3-col m4"><p> </p></div>		
			<div class="w3-col m4">
				 <input type="password" class="w3-input" placeholder="비밀번호" name="user_pass">
			</div>
			<div class="w3-col m4"><p> </p></div>
		</div>
		<div class="w3-row">
			<div class="w3-col m4"><p> </p></div>
			<div class="w3-col m4"><small>● 회원 로그인시 필요한 비밀번호 입니다.<font color="red">(필수)</font></small></div>
			<div class="w3-col m4"><p> </p></div>
		</div>
		<div class="w3-row w3-margin-top"></div>
		<div class="w3-row w3-margin-top">
			<div class="w3-col m4 "><p> </p></div>		
			<div class="w3-col m4 w3-dark-grey w3-left">
				<p>&nbsp;&nbsp;&nbsp;<i class="w3-xxlarge fa fa-unlock"></i></p> 
			</div>
			<div class="w3-col m4"><p> </p></div>
		</div>
		<div class="w3-row w3-margin-top">
			<div class="w3-col m4"><p> </p></div>		
			<div class="w3-col m4">
				 <input type="password" class="w3-input" placeholder="비밀번호 확인" name="user_pass_ck">
			</div>
			<div class="w3-col m4"><p> </p></div>
		</div>
		<div class="w3-row">
			<div class="w3-col m4"><p> </p></div>
			<div class="w3-col m4"><small>● 위에 입력한 비밀번호를 한번더 입력해야 합니다.<font color="red">(필수)</font></small></div>
			<div class="w3-col m4"><p> </p></div>
		</div>
		<div class="w3-row w3-margin-top"></div>
		<div class="w3-row w3-margin-top">
			<div class="w3-col m4"><p> </p></div>		
			<div class="w3-col m4">
				 <input type="button" id="btn_submit" onclick="user_signup()" class="w3-button w3-block w3-red" value="가입하기" disabled="disabled">
			</div>
			<div class="w3-col m4"><p> </p></div>
		</div>	
		
		<div class="w3-row w3-margin-bottom"></div>
		<div class="w3-row w3-margin-bottom"></div>
		<div class="w3-row w3-margin-bottom"></div>
		<div class="w3-row w3-margin-bottom"></div>
		<div class="w3-row w3-margin-bottom"></div>
					
	</div>
 </form>
<!-- 본문 종료 -->
	<!-- 푸터 영역 -->
	<jsp:include page="../Footer.jsp"/>
	<!-- 푸터 영역 -->
</body>
</html>