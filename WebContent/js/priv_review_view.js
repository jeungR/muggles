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
		$('#wysiwyg').wysihtml5({
			html: true,
			customTemplates: bs3Wysihtml5Templates,
			stylesheets: []
		});
		$('#wysiwyg2').wysihtml5({
			html: true,
			customTemplates: bs3Wysihtml5Templates,
			stylesheets: []
		});
        $('.widget').widgster();
        $( '#validation-form' ).parsley();
        $( '#validation-form2' ).parsley();
        $( '#validation-form3' ).parsley();
        $( '#validation-form4' ).parsley();
        $(".select2").each(function(){
            $(this).select2($(this).data());
        });
        $('#datetimepicker1').datetimepicker({
            format: 'YYYY.MM.DD'
        });
        $('#datetimepicker2').datetimepicker({
        	format: 'YYYY.MM.DD'
        });
        $('#print').click(function(){
            window.print();
        });
        initChat();
        $(".autogrow").autosize({append: "\n"}); /*텍스트area 자동 늘리기*/
        $('.selectpicker').selectpicker('refresh');
        
        /*코드 하이라이트 본문*/
    	var editor = CodeMirror.fromTextArea($('#code-mirror-view')[0], {
    	    lineNumbers: true,
    	    mode:"text/html",
    	    theme:"default",
    	    readOnly: true
    	});
    	/*코드 하이라이트 수정*/
    	var editor = CodeMirror.fromTextArea($('#code-mirror-mod')[0], {
    	    lineNumbers: true,
    	    mode:"text/html",
    	    theme:"default",
    	    extraKeys: {"Ctrl-Space":"autocomplete"}
    	});
    	/*코드 하이라이트 버튼클릭시 언어, 템플릿 적용*/
    	$('#code-language-mod').on("change", function(){
    		var language = $(this).val();
    		console.log(language);
    		editor.setOption("mode", language);
    	});
    	$('#code-tamplate-mod').on("change", function(){
    		var theme = $(this).val();
    		editor.setOption("theme", theme);
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
    }
    pageLoad();
    SingApp.onPageLoad(pageLoad);
});