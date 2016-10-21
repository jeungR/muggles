$(function(){
    
    function initCalendar(){
    	//로딩시 ajax
        var user_id =$('#user_id').html();
        var user_level =$('#user_level').html();
        console.log(user_id);
        console.log(user_level);
    	var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var $calendar = $('#index-calendar').fullCalendar({
            header: false,
            selectable: true,
            selectHelper: true,
            editable: false,
            droppable: false,
            eventStartEditable:false,
            locale: "ko",
            displayEventTime : false,
            // 이벤트
            events:
				{
					url: 'open_calendar_json.do',
					type: 'post',
					async: false,
					dataType:'json',
					data:{
						user_id: user_id,
						user_level: user_level
					},
					error: function(data){
						alert("서버 에러");
					}
				}
        });
    }

    function initAnimations(){
        $('#geo-locations-number, #percent-1, #percent-2, #percent-3').each(function(){
            $(this).animateNumber({
                number: $(this).text().replace(/ /gi, ''),
                numberStep: $.animateNumber.numberStepFactories.separator(' '),
                easing: 'easeInQuad'
            }, 1000);
        });

        $('.js-progress-animate').animateProgressBar();
    }
    
    function initGmap(){
        var map = new GMaps({
            el: '#index-gmap',
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
 			['버거킹', 37.49883142, 127.02760577]
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
    
    function pjaxPageLoad(){
        $('.widget').widgster();
        initCalendar();
        initAnimations();
        initGmap();
    }

    pjaxPageLoad();
    SingApp.onPageLoad(pjaxPageLoad);

});