// 	var disabledDays = ["2019-2-2","2019-1-3"];
	$(".t_btn").attr("disabled",true);	//날짜를 선택하기전 시간 버튼 disabled
	$(".price-view").html(a_price);			//처음부터 아무것도 선택되지 않을때 0표시
	
	
	
	//예약 불가능한 날짜 체크
	function disableAllTheseDays(date) {
		
	    var m = date.getMonth(), d = date.getDate(), y = date.getFullYear();
	    for (i = 0; i < disabledDays.length; i++) {
	        if($.inArray(y + '-' +(m+1) + '-' + d,disabledDays) != -1) {
	        	console.log("예약불가능한 날짜는 : "+disabledDays);
	            return [false];
	        }
	    }
	    return [true];
	}
	
	
	//선택한 날짜의 예약가능한 시간 ajax로 동작
	 function nonBtn(date){
		 $(".t_btn").attr("disabled",false);	//	
		 $(".t_btn").removeClass("w3-grey");	//시간버튼 클릭시 변경되는 색상 모두 제거
		 	list = new Array();
		 $.ajax({
	        url:'TimeSpaceController',
	        type:'post',
	        data:{"date":date, "room_no":num},
	        success : function(data){
	        	
	        	var json = JSON.parse(data);
	        	
// 	        	$(".t_btn").attr("disabled",false);
	        	for(var i=0;i<12;i++){
//	        		console.log("j i : "+json[i]);
	        		if(json[i]==1){
	        			$(".t_btn").eq(i).attr("disabled",true);
	        		}
	        	}
	        }
	     }); 
	 }
	 
	 

	 
	 var firstTarget;//첫번째로 클릭한 이벤트타켓
	 
	$(".t_btn").on("click", function(event){
		var f_date = [];				//선택한 날짜
		f_date = s_date.split(" ");
// 		alert(f_date[1]);
		var d_str = f_date[1];			//선택한 날짜의 요일 추출
		var target = $(event.target);
		
						
		var test = 1;
		
		if(!firstTarget){//값이 비어 있을때
			target.addClass("w3-grey");
			firstTarget = target;
		}else{
			var firstNumber = parseInt(firstTarget.attr("id"));
			var secondNumber = parseInt(target.attr("id"));
			console.log("첫 :"+firstNumber+"two : "+secondNumber);
			console.log(typeof(firstNumber));
			console.log(typeof(secondNumber));
			list = new Array();
			if(firstNumber<secondNumber){
				
//				alert("여기dy");
				$(".t_btn:gt("+firstNumber+")").removeClass("w3-grey");
				for(i=firstNumber;i<=secondNumber;i++){
					if($(".t_btn").eq(i-1).attr("disabled")){
						
						list.splice(0, list.length);
						alert("잘못누르셨습니다 다시 눌러주세요");
						break;
					}
					console.log("i : "+i);
					$(".t_btn").eq(i-1).addClass("w3-grey");
					list.push($(".t_btn").eq(i-1).attr("id"));
				}
			}else if(firstNumber == secondNumber){
//				alert("같은곳");
				console.log("== 첫 : "+firstNumber+", two : "+secondNumber);
				list.splice(0, list.length);
				$(".t_btn:gt("+(secondNumber-1)+")").removeClass("w3-grey");
				firstTarget.removeClass("w3-grey");
				firstTarget=null;
			}else if(firstNumber > secondNumber){
//				alert("여기");
				console.log("> 첫 : "+firstNumber+", two : "+secondNumber);
				list.splice(0, list.length);
				$(".t_btn:gt("+(firstNumber-1)+")").removeClass("w3-grey");
				target.addClass("w3-grey");
				firstTarget = target;
			}
		}
		
		
		/*
		if(target.hasClass("w3-grey")){
			var num = list.indexOf(target.attr("id"));
			list.pop(num);
			target.removeClass("w3-grey");
		}else{
			target.addClass("w3-grey");
		 	list.push(target.attr("id"));
		}
		*/
		if(d_str=="Sat" || d_str=="Sun"){
			var price = day_price;
			var timeNum = list.length;
			a_price = String(price*timeNum);
		}else{
			var price = sun_price;
			var timeNum = list.length;
			a_price = String(price*timeNum);
		}
		$(".price-view").html(a_price);
		console.log("start");
// 		 console.log(list.length);
		
		list.forEach(function(element) {
			console.log(element);
		});
	})
	
	
	//캘린더 함수
	 $("#datepicker1").datepicker({
			minDate: 1,
			maxDate: 7,
			defaultDate:+1,
			dateFormat: 'yy-mm-dd D',
			beforeShowDay: disableAllTheseDays,
			onSelect: function(date) {
				
				s_date=date;

				nonBtn(date)
				firstTarget=null;
//	 	         alert(date);
		    }   

		});
	
	
	

	//예약하기 버튼 누르면 값넣고 form 동작
	$("#req-btn").on("click", function(){
		if(email=="" && host_id==""){
			alert("로그인해주세요");
			
		}else if(list.length===0){
			alert("시간을 선택해주세요");
		}else{
			$("#selectDate").attr("value", s_date);
			$("#time").attr("value",list);
			$("#allPrice").attr("value",a_price);
			$("form").submit();
		}
	});
	
	
	 
/* option 표시 */
//  	alert(typeof(${hosting.elevator})); //number
	function optionDisplay(){
		//무료
		if(elevator==0){
			$("#elevator").css("display", "none")
		}
		if(socket==0){
			$("#socket").css("display", "none")
		}
		if(airconditioner==0){
			$("#airconditioner").css("display", "none")
		}
		if(heating==0){
			$("#heating").css("display","none")
		}
		if(toilet==0){
			$("#toilet").css("display", "none")
		}
		//유료옵션
		if(parking==0){
			$("#parking").css("display", "none")
		}
		if(wifi==0){
			$("#wifi").css("display", "none")
		}
		if(projector==0){
			$("#projector").css("display", "none")
		}
		if(laptop==0){
			$("#laptop").css("display", "none")
		}
		if(cabinet==0){
			$("#cabinet").css("display", "none")
		}
	}
	//comment 등록버튼
	$("#insert_btn").on("click", function(event){
		var content = $("#c_content").val();
		$("#c_content").value="";
		$.ajax({
	        url:'CommentInsertController',
	        type:'post',
	        //session의 email받아서 넣어야함
	        data:{"content":content, "room_no":num, "email":email},
	        success : function(data){
	        	console.log(data);
	        	var comment_no = parseInt(data)
	        	console.log(comment_no);
	        		$(".content-comment ul li:first-child").after(function(){
	        			
        				return 	 '<li class="w3-bar">'
        						+'	<button class="w3-right w3-white w3-border-0 c-btn delete'+comment_no+'" id="'+comment_no+'">x</button>'
        						+'	<button class="w3-white w3-right w3-border-0 u-btn update'+comment_no+'" id="'+comment_no+'">'
        						+'		<img src="https://img.icons8.com/metro/26/000000/edit.png">'
        						+'	</button>'
        						+'	<div class="w3-bar-item item-img-div">'
        						+'		<img src="img/c1.PNG" class="w3-circle w3-hide-small c-profile-img">'
        						+'	</div>'
        						+'	<div class="w3-bar-item item-div">'
        						+'		<span>'+comment.nickName+'</span><br> <span>('+comment.email+')</span>'
        						+'	</div>'
        						+'	<div class="item-content upContent'+comment_no+'">'
        						+'		<span>'+content+'</span>'
        						+'	</div>'
        						+'</li>';
        			
        			//동적 버튼 이벤트 추가해야함
	        		});	
	        		
	        		$(document).on("click", ".delete"+comment_no, function(event){
	        			console.log("동적 생성 삭제 버튼 눌러짐");
	        			del(event);
	        		}); 
	        		$(document).on("click", ".update"+comment_no, function(event){
	        			console.log("동적 생성 수정 버튼 눌러짐")
	        			update(event);
	        		});
	        		
	        	
	        }
		}); 
	});
	//comment 삭제버튼
 	$(".c-btn").on("click", function(event){
	
		console.log("삭제버튼 들어옴");
		del(event);
	}); 
	
	function del(event){
		console.log("del에 들어옴");
		var here = $(event.target);
		
		here.parent().css("display","none");
		var comment_no = here.attr("id");
		$.ajax({
	        url:'CommentDeleteController',
	        type:'post',
	        data:{"comment_no":comment_no},
	        success : function(data){
	        	console.log(parseInt(data));
	        }
		});
	}
	
	
	
	//comment 수정 버튼 input으로 변경
	$(".u-btn").on("click", function(event){
		console.log("수정버튼 들어옴");
		update(event);
	});
	
	function update(event){
		var here = $(event.target);
		var comment_no = here.attr("id");
		console.log(comment_no);
		var content = $(".upContent"+comment_no+" span").html(); 
		console.log(content);
		$(".upContent"+comment_no).remove();
		
		
		here.parent().append("	<div class='item-input input-div"+comment_no+"'> "
							+"		<input type='text' class='w3-input' id='c_content"+comment_no+"' "
							+"		style='width:590px; display:inline-block;' /> "
        					+"		<button class='w3-button w3-grey' id='update_btn"+comment_no+"'>등록</button> "
        					+"	</div>");
		here.prev().remove();
		here.remove();
		
		$("#c_content"+comment_no).val(content);
		$(document).on("click", "#update_btn"+comment_no, function(event){
			
			var update_content = $("#c_content"+comment_no).val();
			console.log("update_content : "+update_content);
			$.ajax({
		        url:'CommentUpdateController',
		        type:'post',
		        data:{"comment_no":comment_no, "content":update_content},
		        success : function(data){
		        	console.log("data값: "+parseInt(data));
		        	if(parseInt(data)==1){
		        		var input_div = $(".input-div"+comment_no).parent();
		        		console.log(input_div.html());
		        		$(".input-div"+comment_no).remove();
		        		input_div.prepend('	<button class="w3-right w3-white w3-border-0 c-btn delete'+comment_no+'" id="'+comment_no+'">x</button>'
        								+	'	<button class="w3-white w3-right w3-border-0 u-btn update'+comment_no+'" id="'+comment_no+'">'
        								+	'		<img src="https://img.icons8.com/metro/26/000000/edit.png">'
        								+	'	</button>');
		        		input_div.append('	<div class="item-content upContent'+comment_no+'"> '
        									+'		<span>'+update_content+'</span> '
        									+'	</div>');
		        		
		        		
		        		$(document).on("click", ".delete"+comment_no, function(event){
		        			del(event);
		        		});
		        		$(document).on("click", ".update"+comment_no, function(event){
		        			update(event);
		        		});
		        		
		        	}
		        }
			});	
		});
	}
	$(document).on("click", ".c-btn", function(event){
		del(event);
	});
	$(document).on("click", ".u-btn", function(event){
		update(event);
	});
	
	//무한스크롤-----------------------------------
	let isEnd = false;


	function renderList(comment){
        // 리스트 html을 정의
		let html = 	 '<li class="w3-bar">';
		if(user_email == comment.email || host_email == comment.email){
			html+=	 '	<button class="w3-right w3-white w3-border-0 c-btn delete'+comment.comment_no+'" id="'+comment.comment_no+'">x</button>'
					+'	<button class="w3-white w3-right w3-border-0 u-btn update'+comment.comment_no+'" id="'+comment.comment_no+'">'
					+'		<img src="https://img.icons8.com/metro/26/000000/edit.png">'
					+'	</button>'
		}
        	html+=	 '	<div class="w3-bar-item item-img-div">'
					+'		<img src="img/c1.PNG" class="w3-circle w3-hide-small c-profile-img">'
					+'	</div>'
					+'	<div class="w3-bar-item item-div">'
					+'		<span>'+comment.nick_name+'</span><br> <span>('+comment.email+')</span>'
					+'	</div>'
					+'	<div class="item-content upContent'+comment.comment_no+'">'
					+'		<span>'+comment.com_content+'</span>'
					+'	</div>'
					+'</li>';
		$(".content-comment ul li:last-child").after(html);
		
	
	}


	
	function fetchList(){
		if(isEnd == true){
			
			return;
		}
		// 방명록 리스트를 가져올 때 시작 번호
		// renderList 함수에서 html 코드를 보면 <li> 태그에 data-no 속성이 있는 것을 알 수 있다.
		// ajax에서는 data- 속성의 값을 가져오기 위해 data() 함수를 제공.
//		let startNo = $(".c-btn").last().attr("id");
	    console.log("코멘트 시작번호 "+commentLastNum);
	    if(commentLastNum>1 || commentLastNum!=""){
			$.ajax({
		    		url:"CommentSelectController" ,
		    		type: "post",
		    		datatype:"json",
		    		data: {"startNo":commentLastNum, "room_no":num},
		    		success: function(data){
		                    // 컨트롤러에서 가져온 방명록 리스트는data에 담겨오도록 했다.
		            		// 남은 데이터가 10개 이하일 경우 무한 스크롤 종료
		    				var ja = $.parseJSON(data);
		    				//console.log("array 개수:"+ja.length);
		    				if(ja.length<10){
		    					isEnd=true;
		    				}
		    				
		            		$.each(ja, function(index, comment){
		            			
		            			renderList(comment);
		            			
		            		});
		            }
		    });
	    }
	}
	let timer;


	
	$(window).scroll(function(event){
		
		let $window = $(this);
		let scrollTop = $window.scrollTop();
        let windowHeight = $window.height();
        let documentHeight = $(document).height();
        
        
//        console.log("documentHeight:" + documentHeight + " | scrollTop:" +
//        			scrollTop + " | windowHeight: " + windowHeight );
//        console.log("documentHeight:"+ documentHeight +"plus"+(scrollTop+windowHeight))
        // scrollbar의 thumb가 바닥 전 10px까지 도달 하면 리스트를 가져온다.
        
        if(timer) {
			window.clearTimeout(timer);
		}
        timer = window.setTimeout(function(){
        	if( scrollTop + windowHeight + 5 > documentHeight ){
   	    	 fetchList();
        	}
        }, 500);   
	});

	
	//없는 옵션 가림
	optionDisplay();
	
	
	
	
	
	
	
	
	
	