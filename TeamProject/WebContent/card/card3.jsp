<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.alert {
  width: 400px;
  padding: 20px;
  background-color: #f44336;
  color: white;
}

.closebtn {
  margin-left: 15px;
  color: white;
  font-weight: bold;
  float: right;
  font-size: 22px;
  line-height: 20px;
  cursor: pointer;
  transition: 0.3s;
}

.closebtn:hover {
  color: black;
}
</style>
<script type="text/javascript">
function commingList(){
	
	$('.rStatus_0').css("display", "block");
	$('.rStatus_1').css("display", "none");
	$('.rStatus_2').css("display", "none");

}
</script>
<title>Insert title here</title>
</head>
<body>


<div class="alert" f="card_login()">
  <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span> 
  <strong>예약카드 알림! </strong>
  	${sessionScope.udto.name }님은 총 ${fn:length(rList)}개의 내역이 있습니다.
</div>


</body>
</html>