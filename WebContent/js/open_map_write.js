$(function(){
	/*******구글맵********/
	function initGmap(){
        var map = new GMaps({
            el: '#gmap',
            zoom:16,
            lat: 37.4989329,
            lng: 127.0281888,
            zoomControl : false,
            panControl : false,
            streetViewControl : true,
            mapTypeControl: false,
            overviewMapControl: false
        });
        
        GMaps.on('click', map.map, function(event) {
            map.removeMarkers();
        	var index = map.markers.length;
            var lat = event.latLng.lat();
            var lng = event.latLng.lng();
            //클릭한 위치 input으로 보내기
            $('#map-lat').val(lat);
            $('#map-lng').val(lng);
            
            map.addMarker({
              lat: lat,
              lng: lng,
              title: 'Marker',
              animation: google.maps.Animation.DROP
            });
          });
	}
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
    	initGmap();
        $('#wysiwyg').wysihtml5({
            html: true,
            customTemplates: bs3Wysihtml5Templates,
            stylesheets: []
        });
        $('.widget').widgster();
        //init parsley for pjax requests
        $( '#validation-form' ).parsley();
    }
    pageLoad();
    SingApp.onPageLoad(pageLoad);
});