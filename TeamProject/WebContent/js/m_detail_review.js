var reviewNum = 1;
var reviewCount = $(".review_content").length;

if(allCount==5){
	
	$(".review_more_btn").addClass("w3-disabled");
}else if(allCount>5){
	
	$('.review_content:gt(4)').css("display", "none");
}



$(".review_more_btn").on("click", function(){
	reviewNum=reviewNum+1;
	if(allCount<=reviewNum*5){
		$(".review_content:lt("+allCount+")").css("display","");
		$(".review_more_btn").addClass("w3-disabled");
	}else{
		$(".review_content:lt("+reviewNum*5+")").css("display","");
	}
	
	
	
});