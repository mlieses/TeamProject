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
<title>공간 리뷰 확인</title>


<style type="text/css">
#whole{
	width: 70%;
	margin: auto;
 	min-height: 725px;
 	border: 1px solid red;
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


</style>

<script type="text/javascript">


</script>

</head>
<jsp:include page="../Top.jsp" flush="false"/>

<body>
<div class="w3-container" id="whole">

	<h2 class="w3-left">공간 후기 관리</h2>
	<span class="w3-right"> ${fn:length(rList)}개의 내역</span><br/>
	<div class="w3-row w3-border">
	  	<div class="w3-container w3-quarter" style="border: 1px solid black">
	  		<h2>여기1</h2>
	  	</div>
	  	<div class="w3-container w3-threequarter" style="border: 1px solid blue">
	  		<h2>여기2</h2>
	  	</div>
  	</div>


</div>
</body>
<div class="w3-cell-bottom" style="padding-bottom: 0px;">
<jsp:include page="../Footer.jsp" flush="false"/>
</div>

</html>