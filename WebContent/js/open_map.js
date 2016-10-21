$(function(){
    function initGmap(){
        var map = new GMaps({
            el: '#gmap',
            lat: 37.4989329,
            lng: 127.0281888,
            zoomControl : false,
            panControl : false,
            streetViewControl : true,
            mapTypeControl: false,
            overviewMapControl: false
        });
        
        /*멀티 마커 등록*/
        var locations = [
 			['버거킹', 37.49883142, 127.02760577],
 			['세븐트레인', 37.49879311, 127.02876449],
 			['강남불백', 37.49951237, 127.02841043]
  		];
        /*멀티마커 애니매이션 적용*/
        for (i = 0; i < locations.length; i++) { 
	        (function(i){
	        	setTimeout( function(){
		            map.addMarker({
		                lat: locations[i][1],
		                lng: locations[i][2],
		                animation: google.maps.Animation.DROP,
		                draggable: true,
		                title: locations[i][0],
		                click: function(e) {
		                    console.log('You clicked in this marker');
		                }
		            });
		        }, 1000+i*50);
	        })(i);
        }
    }

    /*위젯 스크롤바 설정*/
    function initChat(){
        $('.widget-chat-list-group').slimscroll({
            height: '600px',
            size: '4px',
            borderRadius: '1px',
            opacity: .3
        });
    }
    
    function pageLoad(){
        initGmap();
        initChat();
        $(".autogrow").autosize({append: "\n"}); /*텍스트area 자동 늘리기*/
    }

    pageLoad();
    SingApp.onPageLoad(pageLoad);
});