<%@page import="home.SearchDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="DB.DAO"%>
<%@page import="DB.SelectDTO"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 

<!-- datepicker -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style type="text/css">
*{
	box-sizing: border-box;
}

body{
margin: 0px;
padding: 0px;

}

#nav2 div{

	margin-left: 10px;
	font-size: 17px;
}


#nav2 div a:link{

text-decoration: none;
}

#nav2 div a:hover{

text-decoration: underline;

}

.starR1{
    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat -52px 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    z-index: -9999;
}
.starR2{
    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    z-index: -9999;
}
.starR1.on{background-position:0 0;}
.starR2.on{background-position:-15px 0;}

</style>

<script type="text/javascript">


//날짜 선택
$(document).ready(function() {
	
    $("#datepicker").datepicker({	
     onSelect: function(date) {	
//	        alert(date);
        myFunction("date_select");
     },
     altField : '#date',
    dateFormat : 'yy년 mm월 dd일',
    maxDate:6,
    minDate:0
  });
 
    
    
    
});


//장소, 날짜 등 클릭 시..
function myFunction(id) {
	  var x = document.getElementById(id);
	  var a = document.getElementById("type_select");
	  var b = document.getElementById("location_select");
	  var c = document.getElementById("date_select");
	  var d = document.getElementById("number_select");
	
	  
	  
	  if (x.className.indexOf("w3-show") == -1) {//처음 클릭했다.
		  
		  //우선 전부 안보이게 지우고
		  a.className = a.className.replace(" w3-show", "");
		  b.className = b.className.replace(" w3-show", "");
		  c.className = c.className.replace(" w3-show", "");
		  d.className = d.className.replace(" w3-show", "");
	
		  //내꺼만 다시 보이게
		  x.className += " w3-show";
	  } else { // 열려있는 상태에서 클릭했다.
	    x.className = x.className.replace(" w3-show", "");
	  }
	}


//값 셋팅

function setValue(obj, target){
// 	var x = obj.innerHTM;
	var x = obj.value;
// 	alert(x);
	document.getElementById(target).value = x;
	var a = document.getElementById("type_select");
	var b = document.getElementById("location_select");
	var c = document.getElementById("date_select");
	var d = document.getElementById("number_select");
	
	a.className = a.className.replace(" w3-show", "");
	b.className = b.className.replace(" w3-show", "");
	c.className = c.className.replace(" w3-show", "");
	d.className = d.className.replace(" w3-show", "");

}


</script>

</head>
<body>
		
	<div style="width:100%;">		
			
				<jsp:include page="../Top.jsp" flush="false"/>
					<div class="w3-bar w3-border-top " style="margin-top: 55px; position: fixed; z-index: 0;">
				
				
				  <div class="w3-bar w3-lime" id="nav2" align="center">
				  	<div style="width: 63%">					  	  
					  	<div class="w3-bar-item"><a href="./detailPageController.do?a=1">전체</a></div>
					  	<div class="w3-bar-item"><a href="./detailPageController.do?a=2">카페</a></div>
					  	<div class="w3-bar-item"><a href="./detailPageController.do?a=3">스터디룸</a></div>
					  	<div class="w3-bar-item"><a href="./detailPageController.do?a=4">강의실</a></div>
					  	<div class="w3-bar-item"><a href="./detailPageController.do?a=10">야외</a></div>
				    </div>		
				  </div>
				  
				  <div class="w3-bar w3-lime">
				  	<div class="w3-bar-item" style="height: 55px;">
						<!-- 상세 조건  -->
						<form action="search.do" method="post">
						  <div class="w3-container">
						     <!-- 첫 row -->
						      <div class="w3-row w3-round-large w3-white w3-hide-small" style=" box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
						       display: inline-block; vertical-align: top; height: 38px; margin-left: 340px; width: 60%; margin-top: -5px;">
						        
						        <div class="w3-col l2 m2 w3-padding">
						           <button type="button" onclick="myFunction('type_select')" style="border: none; padding:0px; background-color: white;">
						          	<input type="text" id="type" name="type" placeholder ="공간" readonly="readonly" class="w3-input w3-border-0"   style = "text-align:center; font-size:1.5em; font-weight:bold; color:rgb(118,118,118); height: 30px;" >
						          </button>
						        </div>
						        
						        <div class="w3-col l3 m3 w3-border-left w3-padding" style="height: 40px;">
						           <button type="button" onclick="myFunction('location_select')" style="border: none; padding:0px; background-color: white;">
						          	<input type="text" id="location" name="location" placeholder="지역" readonly="readonly" class="w3-input w3-border-0" style = "text-align:center; font-size:1.5em; font-weight:bold; color:rgb(118,118,118); height: 30px;" >
						          </button>
						        </div>
						          
						        <div class="w3-col l3 m3 w3-border-left w3-padding" style="height: 40px;">
						          <button type="button" onclick="myFunction('date_select')" style="border: none; padding:0px; background-color: white;">
						          	<input type="text" id="datepicker" name="date" placeholder ="날짜" readonly="readonly" class="w3-input w3-border-0"  style = "text-align:center; font-size:1.5em; font-weight:bold; color:rgb(118,118,118); height: 30px;  ">
						          </button>
						        </div>
						        
						        <div class="w3-col l2 m2 w3-border-left w3-padding" style="height: 40px;">
						          <button type="button" onclick="myFunction('number_select')" style="border: none; padding:0px; background-color: white;">
						          	<input type="text" id="number" name="number" placeholder="인원" readonly="readonly" class="w3-input w3-border-0" style = "text-align:center; font-size:1.5em; font-weight:bold; color:rgb(118,118,118); height: 30px; ">
						          </button>
						        </div>
						        
						         <button class="w3-col w3-btn w3-round l2 m2 w3-padding" onclick="submit()" style="background-color:rgb(252,247,52); color:rgb(11,11,11); width:171px;">
						   			<b>검색</b>
						   	  	 </button>
						        	
						      </div><!--row -->
						       
						
						 
						   
						   <!-- 선택 row -->   
								<div class="w3-row w3-hide " style="position: fixed; z-index: 1;" id="type_select">
								 <div class="w3-col l10 w3-padding"></div>				
							        <div class="w3-col l2 m2 w3-padding w3-white w3-round" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); width: 30%; margin-left: 350px;">
							  			<input type="button" value="카페" onclick="setValue(this, 'type')" style="border: none; padding:0px; background-color: white;"><br/>
							  			<input type="button" value="스터디룸" onclick="setValue(this, 'type')" style="border: none; padding:0px; background-color: white;"><br/> 
							  			<input type="button" value="강의실" onclick="setValue(this, 'type')" style="border: none; padding:0px; background-color: white;"><br/>
							  			<input type="button" value="야외" onclick="setValue(this, 'type')" style="border: none; padding:0px; background-color: white;"><br/>  
							        </div>
							        <div class="w3-col l10 m10 w3-padding"></div>
						        </div>
						        
						       	<div class="w3-row w3-hide" style="position: fixed;" id="location_select">
							        <div class="w3-col l2 w3-padding"></div>
							        <div class="w3-col l5 w3-padding w3-white w3-round" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); width: 50%; margin-left: 520px; ">
							  			<table width="100%">
							  				<tr height="1.5em">
							  					<td><input type="button" value="강서구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  					<td><input type="button" value="금정구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  					<td><input type="button" value="기장구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  					<td><input type="button" value="남구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  				</tr>
							  				<tr>
							  					<td><input type="button" value="동구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  					<td><input type="button" value="동래구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  					<td><input type="button" value="부산진구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  					<td><input type="button" value="북구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  				</tr>
							  				<tr>
							  					<td><input type="button" value="사상구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  					<td><input type="button" value="사하구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  					<td><input type="button" value="서구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  					<td><input type="button" value="수영구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  					
							  				</tr>
							  				<tr>
							  					<td><input type="button" value="연제구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  					<td><input type="button" value="영도구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  					<td><input type="button" value="중구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  					<td><input type="button" value="해운대구" onclick="setValue(this, 'location')" style="border: none; padding:0px; background-color: white;"><br/></td>
							  				</tr>
							  			</table>
							        </div>
							        <div class="w3-col l5 w3-padding"></div>
						        </div>
						        
						        
						        <div class="w3-row w3-hide w3-center" style="position: fixed;" id="date_select" >
							       <!--  <div class="w3-col l6 w3-padding"></div>
							        <div class="w3-col l4 w3-padding-small w3-white w3-round" id="datepicker"  style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); width: 100%;"></div>
							        <div class="w3-col l2 w3-padding"></div> -->
						        </div>	
						        
						        
						        <div class="w3-row w3-hide" style="position: fixed;" id="number_select">
							        <div class="w3-col l10 w3-padding"></div>
							        <div class="w3-col l2 w3-padding w3-white w3-round" style="box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); margin-left: 1040px; width: 10%">
							  			<input type="button" value="소" onclick="setValue(this, 'number')" style="border: none; padding:0px; background-color: white;">(1~4인)<br/>
							  			<input type="button" value="중" onclick="setValue(this, 'number')" style="border: none; padding:0px; background-color: white;">(5~10인)<br/> 
							  			<input type="button" value="대" onclick="setValue(this, 'number')" style="border: none; padding:0px; background-color: white;">(10~20인)<br/>	  			 
							        </div>        
						        </div>
						        
								
						      
						   	 </div> <!-- 검색창  -->
   	   	   
						</form>
					</div>
				  </div>
				 
				</div>	
				
				
			<!-- 왼쪽 영역 , 오른쪽 영역 시작 -->
			<!-- 좌측 영역  -->
			<div style="float: left; width: 50%; margin-top: 152px; z-index: -999">
			
		
		
				<table width="100%">
					<%						
						DecimalFormat formatter = new DecimalFormat("###,###");

						DAO dao = new DAO();
						Vector<SelectDTO> vector = null;
						Vector<SearchDTO> vector1 = null;
						
						if(request.getAttribute("vector") == null){
							vector = dao.select(1);	
						}else if(request.getAttribute("vector") != null){							
							vector = (Vector<SelectDTO>)request.getAttribute("vector");
							
						}
						
							if(request.getAttribute("FindV") == null){
								// 글이 없는 경우 반복문 빠져나가고 콘솔오류 발생 방지
								 if(vector.size() == 0){
										%>
											<tr>
												<td align="left">
													<h1><font color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;검색 결과가 존재하지 않습니다.</font></h1>
												</td>
											</tr>
										
										<%				
										
									return;} 
								for(int i=0; i < vector.size() ; i++){
								
								
								SelectDTO dto	 = vector.get(i);								
								SelectDTO dto1	 = dao.selectReview(dto.getRoom_no()); // 룸 넘버 값 넘겨서 리뷰 글 개수 , 리뷰 점수 리턴.								
								
					%>					
					<tr align="center" height="300px;" style="z-index: -9997;">
						<td width="40%"><div style="width: 90%;">
						
							<!-- 리뷰 점수 값 받아오기 -->
							<input type="hidden" value="<%=dto1.getReviewPoint()%>" id="RPoint<%=i%>">
						
							<a href="detailPageController.do?a=8&room_no=<%=dto.getRoom_no()%>"><img src="upload/<%=dto.getImg1()%>" width="100%" height="200px;"></a></div>
						</td>
						<td width="50%" style="text-align:left; position: relative; z-index: -9999;">
							<div style="position: absolute; top: 0px; z-index: -9999;">
								<h1 style="margin-bottom: -3px;z-index: -9999;"><%= dto.getSubject()%></h1>
								<div id="starRev<%=i%>">
								  <span class="starR1">별1_왼쪽</span>
								  <span class="starR2">별1_오른쪽</span>
								  <span class="starR1">별2_왼쪽</span>
								  <span class="starR2">별2_오른쪽</span>
								  <span class="starR1">별3_왼쪽</span>
								  <span class="starR2">별3_오른쪽</span>
								  <span class="starR1">별4_왼쪽</span>
								  <span class="starR2">별4_오른쪽</span>
								  <span class="starR1">별5_왼쪽</span>
								  <span class="starR2">별5_오른쪽</span>
								  <p style="font-size: 24px; color: gray; display: inline;">&nbsp;&nbsp; 후기 : <%=dto1.getReviewNumber() %>개</p>
								</div>
							</div>
							<div>	
								<p>
									<img alt="예약가" src="re.JPG">
									&nbsp;<b>평일<span style="font-size: 24px;">&nbsp;<%=formatter.format(dto.getWeekday())%></span>원</b>
									&nbsp;<b>주말<span style="font-size: 24px;">&nbsp;<%=formatter.format(dto.getHoliday())%></span>원</b>
								</p>
							</div>
							<div>
								<p><b>참고사항</b></p>
								<%=dto.getContent() %>
							</div>
							
							<script type="text/javascript">
							
							$(document).ready(function() {
								
							var i = $("#RPoint<%=i%>").val() ; //별점값을 담을 변수 i 선언
																		
								if( i == 1){ // i = 1~5 --> 1은 별 1개 5는 별 5개
										
									 $('#starRev<%=i%> span:nth-child(2)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(2)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}
								
								else if( i == 2){ // i = 1~5 --> 1은 별 1개 5는 별 5개
									
									 $('#starRev<%=i%> span:nth-child(4)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(4)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}
								
								else if( i == 3){ // i = 1~5 --> 1은 별 1개 5는 별 5개
									
									 $('#starRev<%=i%> span:nth-child(6)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(6)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}
								
								else if( i == 4){ // i = 1~5 --> 1은 별 1개 5는 별 5개
									 $('#starRev<%=i%> span:nth-child(8)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(8)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}	
								else if( i == 5){ // i = 1~5 --> 1은 별 1개 5는 별 5개
									
									 $('#starRev<%=i%> span:nth-child(10)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(10)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}
								
								
							});
							
							
							</script>
							
							
							
						</td>
						<td width="10%" align="right"></td>
					</tr>	
					<%
							}//for문끝
								
						}//고급검색이 안되었을때.
						
						else{//고급검색 일때							
				
							 vector1 = (Vector<SearchDTO>)request.getAttribute("FindV");
							
							// 글이 없는 경우 반복문 빠져나가고 콘솔오류 발생 방지
							 if(vector1.size() == 0){
									%>
										<tr>
											<td align="left">
												<h1><font color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;검색 결과가 존재하지 않습니다.</font></h1>
											</td>
										</tr>
									
									<%				
									
									return;} 
						
								for(int i=0; i < vector1.size() ; i++){								
									
							
									SearchDTO dto = vector1.get(i);	
									
									SelectDTO dto1	 = dao.selectReview(dto.getRoom_no()); // 룸 넘버 값 넘겨서 리뷰 글 개수 , 리뷰 점수 리턴.	
							
							
					%>
								<tr align="center" height="300px;">
						<td width="40%"><div style="width: 90%;z-index: -9999;">
							
							<!-- 리뷰 점수 값 받아오기 -->
							<input type="hidden" value="<%=dto1.getReviewPoint()%>" id="RPoint<%=i%>">
							  
							<!-- 이미지 클릭시 name = date에 날짜 전송, name=room_no에 방 번호 전송  -->
							<a href="detailPageController.do?a=8&room_no=<%=dto.getRoom_no()%>"><img src="upload/<%=dto.getImg1()%>" width="100%" height="200px;"></a></div>
						</td>
						
						<td width="50%" style="text-align:left; position: relative; z-index: -9999;">
							<div style="position: absolute; top: 0px;">
								<h1 style="margin-bottom: -3px;"><%=dto.getSubject()%></h1>
								<div id="starRev<%=i%>"> 
								  <span class="starR1">별1_왼쪽</span>
								  <span class="starR2">별1_오른쪽</span>
								  <span class="starR1">별2_왼쪽</span>
								  <span class="starR2">별2_오른쪽</span>
								  <span class="starR1">별3_왼쪽</span>
								  <span class="starR2">별3_오른쪽</span>
								  <span class="starR1">별4_왼쪽</span>
								  <span class="starR2">별4_오른쪽</span>
								  <span class="starR1">별5_왼쪽</span>
								  <span class="starR2">별5_오른쪽</span>
								  <p style="font-size: 24px; color: gray; display: inline;">&nbsp;&nbsp; 후기 :<%=dto1.getReviewNumber()%>개</p>
								</div>
							</div>
							<div>	
								<p>
									<img alt="예약가" src="re.JPG">
									&nbsp;<b>평일<span style="font-size: 24px;">&nbsp;<%=formatter.format(dto.getWeekday())%></span>원</b>
									&nbsp;<b>주말<span style="font-size: 24px;">&nbsp;<%=formatter.format(dto.getHoliday())%></span>원</b>
								</p>
							</div>
							<div>
								<p><b>참고사항</b></p>
								<%=dto.getContent()%>
							</div>							
								
							<script type="text/javascript">
							
							$(document).ready(function() {
								
							var i = $("#RPoint<%=i%>").val() ; //별점값을 담을 변수 i 선언
																		
								if( i == 1){ // i = 1~5 --> 1은 별 1개 5는 별 5개
										
									 $('#starRev<%=i%> span:nth-child(2)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(2)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}
								
								else if( i == 2){ // i = 1~5 --> 1은 별 1개 5는 별 5개
									
									 $('#starRev<%=i%> span:nth-child(4)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(4)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}
								
								else if( i == 3){ // i = 1~5 --> 1은 별 1개 5는 별 5개
									
									 $('#starRev<%=i%> span:nth-child(6)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(6)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}
								
								else if( i == 4){ // i = 1~5 --> 1은 별 1개 5는 별 5개
									 $('#starRev<%=i%> span:nth-child(8)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(8)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}	
								else if( i == 5){ // i = 1~5 --> 1은 별 1개 5는 별 5개
									
									 $('#starRev<%=i%> span:nth-child(10)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(10)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}
								
								
							});
														
							</script>
							
						</td>
						<td width="10%" align="right"></td>
					</tr>		
					
					
					<%	}//for문 끝
					}//else 끝 %>								
				</table>			
			</div>
			<!-- 오른쪽 영역 시작 -->
			<div style="width: 50%; position: fixed; right: 0; margin-top: 152px; height:100%;z-index: -9999">
					
					<div id="map" style="width:100%; height:100%;"></div>
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8b1dfa990d9dfd48543e0889cfa06ab9"></script>
					<script>
						
						var container = document.getElementById('map');
						var options = {
							center: new daum.maps.LatLng(33.450701, 126.570667),
							level: 3
						};
				
						var map = new daum.maps.Map(container, options);
						
						// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			            // LatLngBounds 객체에 좌표를 추가합니다
			            var bounds = new daum.maps.LatLngBounds();
			            
						<%
						if(vector1==null){
						%>
							<c:forEach var="vec" items="<%=vector%>" begin="0" end="<%=vector.size()%>" step="1">
								displayMarker('${vec.wdo}','${vec.kdo}', '${vec.room_no}', '${vec.subject}');
								bounds.extend(new daum.maps.LatLng('${vec.wdo}','${vec.kdo}'));
							</c:forEach>
						
						<%
						}else if(vector1!=null){
						%>
							<c:forEach var="vec" items="<%=vector1%>" begin="0" end="<%=vector1.size()%>" step="1">
								displayMarker('${vec.a_wdo}','${vec.a_kdo}', '${vec.room_no}', '${vec.subject}');
								bounds.extend(new daum.maps.LatLng('${vec.a_wdo}','${vec.a_kdo}'));
							</c:forEach>
						<%
						}
						%>
						
						// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			            map.setBounds(bounds);
						
			        	 // 지도에 마커를 표시하는 함수입니다
			            function displayMarker(lat, lng, room_no, subject) {
			                
			                // 마커를 생성하고 지도에 표시합니다
			                var marker = new daum.maps.Marker({
			                    map: map,
			                    position: new daum.maps.LatLng(lat, lng) 
			                });	
			                
			                var iwContent = '<div style="text-align:center;width:150px;"><a href="m_detail?room_no='+room_no+'">'+subject+'</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			                iwRemoveable = true;
		                    
			                var infowindow = new daum.maps.InfoWindow({
			                    content: iwContent // 인포윈도우에 표시할 내용
			                });
			                
			             	
			             	
			                daum.maps.event.addListener(marker, 'click', function() {
			                	
			                	infowindow.open(map, marker);
			                	
			                    
			                });
			                
			                
			        	 }
						</script>
			</div>		
	
		</div>
	
	<script src="js/automap.js"></script>
</body>
</html>