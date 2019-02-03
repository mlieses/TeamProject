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

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

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

	margin-left: 50px;
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

<script type="text/javascript">
	
$(document).ready(function() {
	
		
	var i = 2 ; //별점값을 담을 변수 i 선언
		
	if( i == 2){ // i = 1~10 --> 1은 별 0.5개 10은 별 5개
			
	$('.starRev span:nth-child(2)').parent().children('span').removeClass('on');
	 $('.starRev span:nth-child(2)').addClass('on').prevAll('span').addClass('on');
		  return false; 
	}
	
});

</script>

</head>
<body>


<jsp:include page="../Top.jsp" flush="false"/>

		
	<div style="width:100%; margin-top: 55px;" >		
		
				<table width="100%" border="1">
					<%										
						DAO dao = new DAO();
						Vector<SelectDTO> vector = null;
						String host_id = request.getParameter("HostId");
						
						if(request.getAttribute("vector") == null){
						
							vector = dao.select(host_id);	//아이디 값 넣어주기
						}
					
							for(int i=0; i < vector.size() ; i++){
								if(vector.size() == 0){break;} // 글이 없는 경우 반복문 빠져나가고 콘솔오류 발생 방지
								SelectDTO dto = vector.get(i);	
							
								
								
					%>					
					<tr align="center" height="100px;">
						<td width="20%"><div style="width: 90%"><img src="upload/<%=dto.getImg1()%>" width="100%"></div></td>
						<td width="50%" style="text-align:left; position: relative; padding: 10px;">
							<span style="font-size: 20px;"><%=dto.getSubject()%></span>
						</td>	
						<td width="10%" align="center">
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