<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- 구글 폰트 -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link href="css/recharge.css" rel="stylesheet">
<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<style type="text/css"></style> 
<script type="text/javascript">

	function delete_check(){			
			if(confirm("탈퇴 하시겠습니까?")){
				document.form_host_delete.submit();				
			}			
		}		
	
	
	$("#auth_check").click(function(){		
		
		if($("#auth_check").is(":checked")==true){
			$("#btn_submit").prop("disabled",false);
		}else{
			$("#btn_submit").prop("disabled",true);
		}
		
		
	});

</script>
</head>
<body>

<form action="./HostDelete.do" method="post" name="form_host_delete">
	<input type="hidden" name="host_id" value="${sessionScope.hdto.host_id }">
	<div class="w3-container">	
	<div class="w3-row">					
		<div class="w3-col m8 w3-orange w3-left">
			<p>&nbsp;&nbsp;&nbsp;<i class="w3-xxlarge  fa fa-star"></i>&nbsp;&nbsp;&nbsp;호스트 탈퇴</p> 
		</div>		
	</div>
	<div class="w3-row w3-margin-top" ></div>
	<div class="w3-row" >								
		<div class="w3-col m8">
			이메일
		</div>
		<div class="w3-col m4"></div>
	</div>
	<div class="w3-row" >								
		<div class="w3-col m8">
			<input type="text" id="host_id" class="w3-input" placeholder="호스트아이디" name="host_id" value="${sessionScope.hdto.host_id }" disabled="disabled">
		</div>		
		<div class="w3-col m4"></div>
	</div>
	<div class="w3-row">								
		<div class="w3-col m8">
			<small>● 현재 탈퇴할 호스트 아이디 정보 </small>
		</div>	
		<div class="w3-col m4"></div>
	</div>
	<div class="w3-row w3-margin-top" ></div>
	<div class="w3-row w3-margin-top" ></div>
	<div class="w3-row">								
		<div class="w3-col m8">
			유의 사항
			<hr>
			 <ul>	 			 		
	 			<li><font color="red">탈퇴 시 30일간 재가입이 불가능</font>하며, 제재 중 탈퇴 시에는 이력에 따라 최대 1년간 재가입이 제한될 수 있습니다.</li>	 							
				<li>회원님께서 작성하신 게시물의 작성자 정보는 탈퇴 시 <font color="red">[*비회원*]으로 자동전환</font> 됩니다.</li> 
				<li>삭제를 원하는 게시물이 있다면 탈퇴 전 삭제하시기 바랍니다.</li>				
				<li>탈퇴 후에는 회원정보가 삭제되어 본인 여부를 확인할 수 있는 방법이 없기 때문에 삭제 요청을 주셔도 임의로 삭제 처리가 불가능 합니다.</li>				
				<li>탈퇴 후 재가입 시 <font color="red">기존 계정 정보는 복구되지 않습니다.</font></li> 
				<li>회원탈퇴 후에는 회원정보가 삭제되어 정보가 복구되지 않으니 신중하게 탈퇴를 고려해주시기 바랍니다.</li> 
				<li>탈퇴 후 재가입 시 회원님께서 사용하시던 아이디를 타인이 선점할 경우 재사용하실 수 없습니다.</li>
				<li>기존 회원가입 정보는 유지 됩니다.</li>		
			</ul>
			<hr>			
		</div>	
		<div class="w3-col m4"></div>
	</div>
	<div class="w3-row w3-margin-top" ></div>
	<div class="w3-row w3-margin-top" ></div>
	<div class="w3-row">								
		<div class="w3-col m8">
			● 위 사항에 동의 하십니까?
			<p>&nbsp;&nbsp;<input type="checkbox" class="w3-check" id="auth_check">동의 합니다. </p>
		</div>
		<div class="w3-col m4">
		</div>
	</div>
	<div class="w3-row w3-margin-top" ></div>
	<div class="w3-row">								
		<div class="w3-col m8">	
			<hr>		
			<input type="button" id="btn_submit" class="w3-button w3-block w3-red" value="탈  퇴" onclick="delete_check()" disabled="disabled">
		</div>
		<div class="w3-col m4">
		</div>
	</div>
	</div>
</form>
</body>
</html>