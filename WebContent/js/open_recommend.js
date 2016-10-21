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
		$('#wysiwyg-recommend-site').wysihtml5({
            html: true,
            customTemplates: bs3Wysihtml5Templates,
            stylesheets: []
        });
        $('.widget').widgster();
        $('.js-progress-animate').animateProgressBar();
        $('img[data-src]').each(function(){
        	delete this.holder_data;
        });
        $(".select2").each(function(){
            $(this).select2($(this).data());
        });
        $( '#validation-form' ).parsley();
        /*테이블 클릭시 페이지 이동*/
        $('.search-result-item-body').on('click',function(){
        	$( location ).attr("href", "open_recommend_view.do");
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
        
        //추천사이트 리스트
        var readRecomm = function readRecomm(){
    		
			$.ajax({
			url:"./open_recommend_json_list.do",
			type:"post",
			dataType:"json",
			success:function(json){
				console.log(json);
				$("#recom_title").empty();
				$.each(json, function(index,value){
					//유료여부
					if(value.cost == "무료"){
						var cost = "free";
					}else{
						var cost="free+";
					}
					//온라인 여부
					if(value.recomm_olin == "없음"){
						var olin = "";
					}else{
						var olin = "동영상 강의";
					}
					
					var title=$('<section class="search-result-item" id="recomm_list"></section>')
					.html('<a class="image-link" href="./open_recomm_view.do?recomm_seq='+value.recomm_seq+'">'+
							'<img class="image" src="upload/'+value.recomm_img+'" style="width:200px;height:150px;">'+
						'</a>');
					var content=$('<div class="search-result-item-body"></div>')
					.html('<div class="row">'+
	   							 '<div class="col-sm-9">'+
	     						   '<h4 class="search-result-item-heading">'+
	       						     '<a href="./open_recomm_view.do?recomm_seq='+value.recomm_seq+'"">'+value.recomm_title+'</a>'+
	      						  '</h4>'+
	      						  '<span class="badge bg-danger fw-normal pull-right">'+olin+'</span>'+
	     						   '<p class="info">'+
	           						 	value.recomm_language+
	    						    '</p>'+
	   								     '<p class="description text-box-ellipsis text-gray-darker">'+
	        								value.recomm_content+
	       								 '</p>'+
	   						 '</div>'+
	   					 '<div class="col-sm-3 text-align-center">'+
	     					   '<p class="value3 mt-sm">'+
	     					  cost+
	       						 '</p>'+
	       					 '<p class="fs-mini text-muted">'+
	       					     	value.cost_detail+
	     							   '</p>'+
	     						   '<a class="btn btn-primary btn-info btn-sm" href="#">Learn More</a>'+
	    							'</div>'+
								'</div>');
					
					$(title).append(content);
					$("#recom_title").append(title);
				});
			}
		});
	}
	readRecomm();
    }
    pageLoad();
    SingApp.onPageLoad(pageLoad);
});