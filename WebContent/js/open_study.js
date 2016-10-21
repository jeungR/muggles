$(function(){
	
	/*********에디터********/
	var bs3Wysihtml5Templates = {
        "emphasis": function(locale, options) {
            var size = (options && options.size) ? ' btn-'+options.size : '';
            return "<li>" +
                "<div class='btn-group'>" +
                "<a class='btn btn-" + size + " btn-default' data-wysihtml5-command='bold' title='CTRL+B' tabindex='-1'><i class='glyphicon glyphicon-bold'></i></a>" +
                "<a class='btn btn-" + size + " btn-default' data-wysihtml5-command='italic' title='CTRL+I' tabindex='-1'><i class='glyphicon glyphicon-italic'></i></a>" +
                "</div>" +
                "</li>";
        },
        "link": function(locale, options) {
            var size = (options && options.size) ? ' btn-'+options.size : '';
            return "<li>" +
                ""+
                "<div class='bootstrap-wysihtml5-insert-link-modal modal fade'>" +
                "<div class='modal-dialog'>"+
                "<div class='modal-content'>"+
                "<div class='modal-header'>" +
                "<a class='close' data-dismiss='modal'>&times;</a>" +
                "<h4>" + locale.link.insert + "</h4>" +
                "</div>" +
                "<div class='modal-body'>" +
                "<input value='http://' class='bootstrap-wysihtml5-insert-link-url form-control'>" +
                "<label class='checkbox'> <input type='checkbox' class='bootstrap-wysihtml5-insert-link-target' checked>" + locale.link.target + "</label>" +
                "</div>" +
                "<div class='modal-footer'>" +
                "<button class='btn btn-default' data-dismiss='modal'>" + locale.link.cancel + "</button>" +
                "<button href='#' class='btn btn-primary' data-dismiss='modal'>" + locale.link.insert + "</button>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "<a class='btn btn-" + size + " btn-default' data-wysihtml5-command='createLink' title='" + locale.link.insert + "' tabindex='-1'><i class='fa fa-share'></i></a>" +
                "</li>";
        },
        "image": function(locale, options) {
            var size = (options && options.size) ? ' btn-'+options.size : '';
            return "<li>" +
                "<div class='bootstrap-wysihtml5-insert-image-modal modal fade'>" +
                "<div class='modal-dialog'>"+
                "<div class='modal-content'>"+
                "<div class='modal-header'>" +
                "<a class='close' data-dismiss='modal'>&times;</a>" +
                "<h4>" + locale.image.insert + "</h4>" +
                "</div>" +
                "<div class='modal-body'>" +
                "<h6>업로드할 이미지를 선택하세요</h6>" +
				  "<form name='photo' id='imageUploadForm' enctype='multipart/form-data' action='xtra_image_upload.do' method='post'>" +
                "<input type='file' id='imageBrowse' name='image1' size='30'/>" +
                "<button type='button' class='btn btn-default' id='btnImageBrowse'>파일 선택</button>" +
                "</form>" +
                "<div class='progress'>" +
                "<div class='progress-bar' id='imageProgressBar' role='progressbar' aria-valuenow='60' aria-valuemin='0' aria-valuemax='100' style='width: 0%;'>" +
                "</div>" +
                "</div>" +
                "<hr>" +
                "<div class='imageLink'>" +
                "<h6>웹상에 링크로 이미지를 넣을수도 있어요</h6>" +
                "<input value='http://' class='bootstrap-wysihtml5-insert-image-url form-control'>" +
                "</div>" +
                "</div>" +
                "<div class='modal-footer'>" +
                "<button class='btn btn-default' data-dismiss='modal'>" + locale.image.cancel + "</button>" +
                "<button class='btn btn-primary' data-dismiss='modal'>" + locale.image.insert + "</button>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "</div>" +
                "<a class='btn btn-" + size + " btn-default' data-wysihtml5-command='insertImage' title='" + locale.image.insert + "' tabindex='-1'><i class='glyphicon glyphicon-picture'></i></a>" +
                "</li>";
        },
        "html": function(locale, options) {
            var size = (options && options.size) ? ' btn-'+options.size : '';
            return "<li>" +
                "<div class='btn-group'>" +
                "<a class='btn btn-" + size + " btn-default' data-wysihtml5-action='change_view' title='" + locale.html.edit + "' tabindex='-1'><i class='fa fa-code'></i></a>" +
                "</div>" +
                "</li>";
        }
    };
	
	
    
	
    function pageLoad(){
    	$('#wysiwyg-study').wysihtml5({
            html: true,
            customTemplates: bs3Wysihtml5Templates,
            stylesheets: []
        });
        $('.widget').widgster();
        $( '#validation-form' ).parsley();
        $(".select2").each(function(){
            $(this).select2($(this).data());
        });
        $('#datetimepicker1').datetimepicker({
            format: 'YYYY.MM.DD'
        });
        $('#datetimepicker2').datetimepicker({
        	format: 'YYYY.MM.DD'
        });
        
        
        
        /*두번째 모달을 close, 첫번쨰 scroll 문제 해결*/
        $('.modal').on("hidden.bs.modal", function (e) {
            if($('.modal:visible').length)
            {
                $('.modal-backdrop').first().css('z-index', parseInt($('.modal:visible').last().css('z-index')) - 10);
                $('body').addClass('modal-open');
            }
        }).on("show.bs.modal", function (e) {
            if($('.modal:visible').length)
            {
                $('.modal-backdrop.in').first().css('z-index', parseInt($('.modal:visible').last().css('z-index')) + 10);
                $(this).css('z-index', parseInt($('.modal-backdrop.in').first().css('z-index')) + 10);
            }
        });
       
        /* 리스트 ajax */
    	var readServer = function readServer() {	        
    		$.ajax({
     	url: './open_study_list_json.do',
     	type: 'post',
      	dataType: 'json', 
     	success: function(json) {
     	 	  var color =1;
    			   var colorClass="";
     		   console.log(json);
       	 $('#open_study_list_json').empty();
       	 $.each(json, function(index, value) {
      		  //배경 바뀌게하기
      		  if(color == 1){
        			   colorClass="success";
        		   }else if(color ==2){
        			   colorClass="gray";
        		   }else if(color ==3){
        			   colorClass="info";
        		   }else if(color ==4){
        			   colorClass="primary";
        		   }else if(color ==5){
        			   colorClass="danger";
        		   }else if(color ==6){
        			 colorClass="success";
        		   }
      	 	console.log(color);
      	 	console.log(colorClass);
      	 	var title
         	 	= $('<div class="col-md-4" ></div>').html('<section class="widget">'+
         	             '<div class="widget-controls">'+
           	       '</div>'+
            	      '<div class="widget-body">'+
               	       '<div class="post-user mt-n-xs" >'+
                  	        '<span class="thumb pull-left mr">'+
                    	          '<img class="img-circle" src="demo/img/people/a2.jpg" alt="...">'+
                   	       '</span>'+
                  	        '<h5 class="mb-xs mt-xs" >작성자 <span class="fw-semi-bold">'+value.user_name+'</span></h5>'+
                      	    '<p class="fs-mini text-muted"><span> 시작일 :'+value.stu_s_date+' / 종료일 :'+ value.stu_e_date +
                      	    '</span> &nbsp; 작성시간: &nbsp; '+value.stu_wdate+'</p>'+
                    	  '</div>'+
                    	  '<div class="widget-middle-overflow windget-padding-md clearfix bg-'+colorClass+' text-white">'+
                    	      '<h3 class="mt-lg mb-lg">'+value.stu_title+'</h3>'+
                     	     '<ul class="tags text-white pull-right">'+
                            	  '<li><a href="./open_study_view.do?stu_seq='+value.stu_seq+'&user_seq='+value.user_seq+'">상세보기</a></li>'+
                            		'<li><a href="./open_study_join.do?stu_seq='+value.stu_seq+'&user_seq='+value.wuser_seq+'" id="stu_joinbtn">신청</a></li>'+	
                        	  '</ul>'+
                      	'</div>'+
                     	 '<p class="text-light fs-mini mt-sm text-box-ellipsis">'+value.stu_content+'</p>'+
                 	 '</div>'+
                 	 '<footer class="bg-body-light">'+
                   	   '<ul class="post-links  no-separator">'+
                    	      '<li><i class="glyphicon glyphicon-user"></i> '+value.stu_p_num+'/'+value.stu_m_num+'</li>'+
                     	 	    '<li><i class="glyphicon glyphicon-comment"></i> 2</li>'+
                    	  '</ul>'+
                 	 '</footer>'+
            	  '</section>');
         	  $('#open_study_list_json').append(title);
          	  if (color>5 ){
          		  color=1;
          		  }else {
          		  color ++;
          		  		}
          	  if(value.stu_m_num == value.stu_p_num){
          		  $("#stu_joinbtn").on("click",function(event){
          			 	 alert("참여할 수 없습니다.");
          			 	event.preventDefault();
          		  });
          	  }
        			  });
     				}
    			});
    		}
        /* 글쓰기 ajax */
        $('#stu_write').on('click',function(){  	   
     	  var stu_select_date= $('#multiple-select').val().toString();
     	  var user_seq = $(this).attr("idx");
     	  $.ajax({
     		url:'./open_study_write_ok.do',
     		type:'post',
     		dataType:'json',
     		data:{
     			 stu_title:$("#stu_title").val(),
     			 stu_s_date:$("#datepicker2i").val(),
     			 stu_e_date:$("#datepicker2ii").val(),
     			 stu_content:$("#wysiwyg-study").val(),
     			 stu_m_num:$("#number").val(),
     			 stu_location:$("#location").val(),
     			 stu_select_date:stu_select_date,
     			 user_seq:user_seq
     		},
     	  
     		success:function(json){
    			console.log(json);
    			console.log(user_seq);
     			if (json.flag == 0) {
                      alert('글쓰기에 성공했습니다');
    						$('.close').trigger('click');
    						$('.select2-search-choice').remove();
    						$("#stu_title").val('');
    						$("#datepicker2i").val('');
    						$("#datepicker2ii").val('');
    						$(".form-control wysihtml5-editor placeholder").val('');
    						$("#number").val('');
    						$("#location").val('');
    						$('#multiple-select').val('');
                      readServer();
                   } else {
                      alert('글쓰기에 실패했습니다');
                   
                      $('.close').trigger('click');
                 	  }
     				} 
     	 		});
        	});
        readServer();
    }
   
    pageLoad();
    SingApp.onPageLoad(pageLoad);

});