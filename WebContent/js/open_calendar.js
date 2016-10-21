$(function(){
    function pageLoad(){
        //일정보기 선택
    	$('#external-events div.bg-gray-light').on('click', function(){
    		$('#calendar .fc-event-container a').removeClass('hidden');
    	});
    	$('#external-events div.bg-danger').on('click', function(){
    		$('#calendar .fc-event-container a').addClass('hidden');
    		$('#calendar .fc-event-container a.bg-danger').removeClass('hidden');
    	});
    	$('#external-events div.bg-info').on('click', function(){
    		$('#calendar .fc-event-container a').removeClass('hidden');
    		$('#calendar .fc-event-container a.bg-danger').addClass('hidden');
    	});
    	
        //컬러선택 체크아이콘
        $('body').on('click', '.event-tag > span', function(){
            $('.event-tag > span').removeClass('fa-check-square').addClass('fa-square');
            $(this).removeClass('fa-square').addClass('fa-check-square');
        });
        //로딩시 유저정보
        var user_id =$('#user_id').html();
        var user_level =$('#user_level').html();
        
        //fullcalendar
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var $calendar = $('#calendar').fullCalendar({
            header: {
                left: '',
                center: '',
                right: ''
            },
            allDayDefault:false,
            displayEventTime : false,
            locale: "ko",
            selectable: true,
            selectHelper: true,
            select: function(start, end, allDay) {
            	var $modal = $("#edit-modal"),
                    $btn = $('#create-event');
                $btn.off('click');
                //버튼 클릭시 제목, 컬러값 받아서 이벤트 생성
                $btn.click(function () {
                    var title = $("#event-name").val();
                    var tagColor = $('.event-tag > span.fa-check-square').attr('data-tag');
                    console.log("jsp : "+user_level);
                    if (title) {
                    	//ajax 요청
                    	$.ajax({
                    		url: 'open_calendar_write_ok.do',
                    		type: 'post',
                    		data:{
                    			user_level: user_level,
                    			user_id: user_id,
                    			title: title,
                    			start: start.format(),
                    			end: end.format(),
                    			allDay: $.fullCalendar.moment(start.format()).hasTime()?false:true,
                    					className: tagColor
                    		},
                    		success: function(data,status,xhr){
                    			console.log("쓰기 성공");
                    			$calendar.fullCalendar( 'refetchEvents' );
                    		},
                    		error: function(data){
                    			alert("서버 에러");
                    		}
                    	});
                        
                        $("#edit-modal input").val("") //인풋 리셋
                    }
                    $calendar.fullCalendar('unselect');
                });
                //엔터시 버튼클릭으로 연결
                $('#event-name').off().keyup(function(e){
                	if(e.keyCode ==13)$btn.click();
                });
                $modal.modal('show');
                $calendar.fullCalendar('unselect');
            },
            editable: true,
            droppable:true,
            //일정 수정 drop
            eventDrop: function(event, delta, revertFunc) {
                //ajax 요청
				$.ajax({
					url: 'open_calendar_modify_ok.do',
					type: 'post',
					data:{
						event_id: event.id,
						start: event.start.format(),
						end: event.end==null?moment(event.start).add(2,'h').format():event.end.format(),
						allDay: moment(event.start).hasTime()?false:true,
					},
					success: function(data,status,xhr){
						console.log("수정 성공");
						$calendar.fullCalendar( 'refetchEvents' );
					},
					error: function(data){
						alert("서버 에러");
					}
				});

            },
            //일정 수정 resize
            eventResize: function(event, delta, revertFunc) {
                //ajax 요청
				$.ajax({
					url: 'open_calendar_modify_ok.do',
					type: 'post',
					data:{
						event_id: event.id,
						start: event.start.format(),
						end: event.end==null?moment(event.start).add(2,'h').format():event.end.format(),
						allDay: moment(event.start).hasTime()?false:true,
					},
					success: function(data,status,xhr){
						console.log("수정 성공");
						$calendar.fullCalendar( 'refetchEvents' );
					},
					error: function(data){
						alert("서버 에러");
					}
				});

            },
            // 달력 데이터
            events: {
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
			},

            eventClick: function(event) {
                //이벤트 확인 모달
                var $modal = $("#myModal"),
                    $modalLabel = $("#myModalLabel17");
                $modalLabel.html(event.title);
                $modal.find(".modal-body p").html(function(){
                    if (event.allDay){
                        return "종일 일정"
                    } else {
                    	//이벤트의 시작,끝 시간을 가져와서 출려함
                        return "시작일: <strong>" + moment(event.start).format("MM월 DD일  HH:mm") + "</strong></br>"
                            + (event.end == null ? "" : "종료일: <strong>" + moment(event.end).format("MM월 DD일  HH:mm") + "</strong>")
                    }
                }());
                //이벤트 삭제
                $('#delete-event').on('click', function(){
                	if(event.editable){
                		console.log(event.id);
                        //ajax 요청
        				$.ajax({
        					url: 'open_calendar_delete_ok.do',
        					type: 'post',
        					data:{
        						event_id: event.id,
        						user_id: user_id
        					},
        					success: function(data,status,xhr){
        						console.log("삭제 성공");
        						$calendar.fullCalendar( 'refetchEvents' );
        					},
        					error: function(data){
        						alert("서버 에러");
        					}
        				});
                	}else{
                		alert("학원 일정을 삭제할 수 있는 권한이 없습니다.");
                	}
                	
                })
                $modal.modal('show');
            }

        });
        //달력보기 변경
        $("#calendar-switcher").find("label").click(function(){
            $calendar.fullCalendar( 'changeView', $(this).find('input').val() )
        });
        //현재 날짜 나타내기
        var currentDate = $calendar.fullCalendar('getDate');

        $('#calender-current-date').html(
                moment(currentDate).format("MMM YYYY")+
                " - <span class='fw-semi-bold'>" +
                moment(currentDate).format("dddd") +
                "</span>"
        );

        //이전달 날짜 나타내기
        $('#calender-prev').click(function(){
            $calendar.fullCalendar( 'prev' );
            currentDate = $calendar.fullCalendar('getDate');
            $('#calender-current-date').html(
            		moment(currentDate).format("MMM YYYY")+
                    " - <span class='fw-semi-bold'>" +
                    moment(currentDate).format("dddd") +
                    "</span>"
            );
        });
      //다음달 날짜 나타내기
        $('#calender-next').click(function(){
            $calendar.fullCalendar( 'next' );
            currentDate = $calendar.fullCalendar('getDate');
            $('#calender-current-date').html(
            		moment(currentDate).format("MMM YYYY")+
                    " - <span class='fw-semi-bold'>" +
                    moment(currentDate).format("dddd") +
                    "</span>"
            );
        });
        
        $('#test-event').click(function(){
        	console.log($('#calendar').fullCalendar('clientEvents'));
        })
    }
    pageLoad();
    SingApp.onPageLoad(pageLoad);
});