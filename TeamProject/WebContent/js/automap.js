daum.maps.event.addListener(map, 'dragend', function() {
	// 지도의 현재 영역을 얻어옵니다 
    var bounds = map.getBounds();
    
    // 영역의 남서쪽 좌표를 얻어옵니다 
    var swLatLng = bounds.getSouthWest(); 
    var swLat = swLatLng.getLat();
    var swLng = swLatLng.getLng();
    // 영역의 북동쪽 좌표를 얻어옵니다 
    var neLatLng = bounds.getNorthEast(); 
    var neLat = neLatLng.getLat();
    var neLng = neLatLng.getLng();
    
   $.ajax({
	  url:'MoveSearchMapController.do',
	  type:'post',
	  data:{"swLat":swLat, "swLng":swLng, "neLat":neLat, "neLng":neLng},
	  datatype:"json",
	  success:function(data){
		  
	  }
   });
    
    
});