<%@page import="java.text.DecimalFormat"%>
<%@page import="DB.DAO"%>
<%@page import="DB.SelectDTO"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">


<style type="text/css">
*{
	box-sizing: border-box;
}

body{
margin: 0px;
padding: 0px;

}


.starR1{
    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat -52px 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
}
.starR2{
    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
}
.starR1.on{background-position:0 0;}
.starR2.on{background-position:-15px 0;}

</style>


</head>
<body>


<jsp:include page="../Top.jsp" flush="false"/>

		
	<div style="width:70%; margin: auto; margin-top: 95px;">		
		<div>
			<h1 align="center" style="border: groove; background-color: #cddc39" >공간 관리</h1>
		</div>
				<table width="100%" class="w3-table w3-bordered">
					<%
						DecimalFormat formatter = new DecimalFormat("###,###");
					
						DAO dao = new DAO();
						Vector<SelectDTO> vector = null;
						String host_id = request.getParameter("HostId");
						
						if(request.getAttribute("vector") == null){
						
							vector = dao.select(host_id);	//아이디 값 넣어주기
						}
					
							for(int i=0; i < vector.size() ; i++){
								if(vector.size() == 0){break;} // 글이 없는 경우 반복문 빠져나가고 콘솔오류 발생 방지
								SelectDTO dto = vector.get(i);	
								
								SelectDTO dto1	 = dao.selectReview(dto.getRoom_no()); // 룸 넘버 값 넘겨서 리뷰 글 개수 , 리뷰 점수 리턴.

								
								
					%>					
					<tr align="center" height="100px;">
						<td width="20%" style="position: relative;">
						
						<!-- 리뷰 점수 값 받아오기 -->
							<input type="hidden" value="<%=dto1.getReviewPoint()%>" id="RPoint<%=i%>">
							
							
							<div style="width: 100%">
								<a href="detailPageController.do?a=8&room_no=<%=dto.getRoom_no()%>"><img src="upload/<%=dto.getImg1()%>" width="100%" height="150px;"></a>
							</div>
								<div class="w3-row" style="position: absolute; bottom: 0px; left: 0px; height: 40px;">
								
								<%if(dto.getImg2() == null || dto.getImg2().equals("")) {%>	
									<div class="w3-third w3-container">
									  	<div style="width: 90%"><img src="Jong/basic.JPG" width="100%" height="30px;"></div>
									</div>			
							    <%}else { %>					
									<div class="w3-third w3-container">
									  	<div style="width: 90%"><img src="upload/<%=dto.getImg2()%>" width="100%"  height="30px;"></div>
									</div>
								<%} %>
								
								
								<%if(dto.getImg3() == null || dto.getImg3().equals("")) {%>	
									<div class="w3-third w3-container">
									  	<div style="width: 90%"><img src="Jong/basic.JPG" width="100%" height="30px;" ></div>
									</div>			
							    <%}else { %>					
									<div class="w3-third w3-container">
									  	<div style="width: 90%"><img src="upload/<%=dto.getImg3()%>" width="100%" height="30px;"></div>
									</div>
								<%} %>
								
								<%if(dto.getImg4() == null || dto.getImg4().equals("")) {%>	
									<div class="w3-third w3-container" >
									  	<div style="width: 90%"><img src="Jong/basic.JPG" width="100%" height="30px;"></div>
									</div>			
							    <%}else { %>					
									<div class="w3-third w3-container">
									  	<div style="width: 90%"><img src="upload/<%=dto.getImg4()%>" width="100%" height="30px;"></div>
									</div>
								<%} %>
								
							
								</div>				
						</td>
						<td width="50%" style="text-align:left; position: relative; padding: 20px;">
							<div style="position: absolute; top: 0px;">
								<h1 style="margin-bottom: -3px;"><%= dto.getSubject()%></h1>
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
								<p><br><br><br>
									<img alt="예약가" src="re.JPG"> &nbsp;   
									&nbsp;<b>평일<span style="font-size: 24px;">&nbsp;<%=formatter.format(dto.getWeekday())%></span>원</b>
									&nbsp;<b>주말<span style="font-size: 24px;">&nbsp;<%=formatter.format(dto.getHoliday())%></span>원</b>
								</p>
							</div>
							<div>	
								<p>	  
									<span class="w3-large"><i class="fa fa-male"></i></span>
										<b>인원 :&nbsp;<%=dto.getPeople()%></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					   				<span class="w3-large"><i class="fa fa-home"></i></span>
					   					<b> 방 유형 :&nbsp;<%=dto.getRoom()%></b>
								</p>
							</div>
							
							<script type="text/javascript">
							
							$(document).ready(function() {
								
							var i = $("#RPoint<%=i%>").val() ; //별점값을 담을 변수 i 선언
																		
								if( i == 1){ // i = 1~10 --> 1은 별 0.5개 10은 별 5개
										
									 $('#starRev<%=i%> span:nth-child(2)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(2)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}
								
								else if( i == 2){ // i = 1~10 --> 1은 별 0.5개 10은 별 5개
									
									 $('#starRev<%=i%> span:nth-child(4)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(4)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}
								
								else if( i == 3){ // i = 1~10 --> 1은 별 0.5개 10은 별 5개
									
									 $('#starRev<%=i%> span:nth-child(6)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(6)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}
								
								else if( i == 4){ // i = 1~10 --> 1은 별 0.5개 10은 별 5개
									 $('#starRev<%=i%> span:nth-child(8)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(8)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}	
								else if( i == 5){ // i = 1~10 --> 1은 별 0.5개 10은 별 5개
									
									 $('#starRev<%=i%> span:nth-child(10)').parent().children('span').removeClass('on');
									 $('#starRev<%=i%> span:nth-child(10)').addClass('on').prevAll('span').addClass('on');
										  return false; 
									}
								
								
							});
							
							
							</script>
							
						</td>
						<td width="10%" style="text-align:center; vertical-align:middle;">
							<a href="updateBoardController.do?roomNo=<%=dto.getRoom_no()%>"><button class="w3-btn w3-white w3-border w3-border-blue w3-round-large">수정</button></a>
							<a href="deleteBoardController.do?roomNo=<%=dto.getRoom_no()%>"><button class="w3-btn w3-white w3-border w3-border-blue w3-round-large">삭제</button></a>
						</td>
					</tr>	
					<%
						}		
					
					%>
					
				</table>
			
			</div>
			
				
		
</body>
</html>