<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sing - Register</title>
    <link href="css/application.css" rel="stylesheet">
    <!-- as of IE9 cannot parse css files with more that 4K classes separating in two files -->
    <!--[if IE 9]>
        <link href="css/application-ie9-part2.css" rel="stylesheet">
    <![endif]-->
    <link rel="shortcut icon" href="img/favicon.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="this it acon academy community site">
    <meta name="author" content="Muggles Team">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script>
        /* yeah we need this empty stylesheet here. It's cool chrome & chromium fix
         chrome fix https://code.google.com/p/chromium/issues/detail?id=167083
         https://code.google.com/p/chromium/issues/detail?id=332189
         */
    </script>
    <style>
    	#content {
    		padding-top:5%;
    	}
    </style>
</head>
<body class="login-page">

<div class="container">
    <main id="content" class="widget-login-container" role="main">
        <div class="row">
            <div class="col-lg-10 col-lg-offset-1">
                <h4 class="widget-login-logo animated fadeInUp">
                    <i class="fa fa-circle text-gray"></i>
                    Muggles
                    <i class="fa fa-circle text-warning"></i>
                </h4>
                <section class="widget widget-login animated fadeInUp">
                    <header>
                        <h3>회원가입</h3>
                    </header>
                    <div class="widget-body">
                        <p class="widget-login-info">
                            	정확한 정보를 입력해주세요.
                        </p>
                        <p class="widget-login-info">
                           	 회원가입 정보를 바탕으로 클래스별 게시판 이용가능 여부를 판단합니다.
                        </p>
                        <form action="./home_membership_ok.do" id="validation-form" class="login-form mt-lg form-label-left" method="post"
                              data-parsley-priority-enabled="false" enctype="multipart/form-data"
                              novalidate="novalidate">
                             <fieldset>
	                             <div class="form-group">
		                            <label class="control-label col-sm-3 col-xs-12">
		                                        	아이디
		                            </label>
		                            <div class="col-sm-7 col-xs-8">
		                            	<input type="text" id="user_id" name="user_id" class="form-control"
		                            					data-parsley-minlength="6"
		                                                placeholder="아이디"
		                                                required="required">
		                            </div>
		                            <div class="btn-group col-sm-2 col-xs-4">
								        <button id=chkId class="btn btn-primary btn-block mb-sm" role="button" type="button"><!-- 클릭하면 모달뜸 -->
											중복확인
										</button>
							        </div>
	                            </div>
	                            <div class="form-group">
	                                <label class="control-label col-sm-3" for="password">
	                                    비밀번호
	                                </label>
	                                <div class="col-sm-5">
	                                    <input type="password" id="user_pw" name="user_pw" class="form-control mb-sm"
	                                           data-parsley-trigger="change"
	                                           data-parsley-minlength="6"
	                                           placeholder="비밀번호"
	                                           required="required">
	                                </div>
	                                <div class="col-sm-4">
	                                    <input type="password" id="user_pw_r" name="user_pw_r" class="form-control"
	                                           data-parsley-trigger="change"
	                                           data-parsley-minlength="6"
	                                           data-parsley-equalto="#user_pw"
	                                           placeholder="비밀번호 확인"
	                                           required="required">
	                                </div>
	                            </div>
                            </fieldset>
                            <fieldset>
                                <!-- 이미지 -->
                                <div class="form-group">
                                    <label class="control-label col-sm-3" for="fileupload1">
                                        	사진 업로드
                                        	<span class="help-block">자신을 대표할 이미지를 올려주세요</span>
                                    </label>
                                    <div class="col-sm-9">
                                        <div class="fileinput fileinput-new" data-provides="fileinput">
                                            <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                                <img data-src="holder.js/100%x100%" alt="..." src="">
                                            </div>
                                            <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                                            <div>
                                                <span class="btn btn-default btn-file"><span class="fileinput-new">사진 선택</span><span class="btn btn-default fileinput-exists">사진변경</span><input type="file" name="photo"></span>
                                                <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">삭제</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                            <fieldset>
	                            <div class="form-group">
	                                <label class="control-label col-sm-3" for="title">이름</label>
	                                <div class="col-sm-9">
	                                    <input type="text" id="user_name" name="user_name" class="form-control mb-sm"
	                                           placeholder="이름" required="required">
	                                </div>
	                            </div>
	                            <div class="form-group">
	                           		<label class="control-label col-sm-3" for="radio">성별</label>
	                            	<div class="col-sm-9 radio">
	                                       &nbsp;&nbsp;&nbsp;
	                                       <input type="radio" name="gender" id="radio1" value="M" checked>
	                                       <label for="radio1">
	                                           남
	                                       </label>
	                                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                                       <input type="radio" name="gender" id="radio2" value="F">
	                                       <label for="radio2">
	                                           여
	                                       </label>
	                            	</div>
	                            </div>
	                        </fieldset>
                            <fieldset>
                            	<div class="form-group">
		                            <label class="control-label col-sm-3 col-xs-12" for="number">
		                                        	수강코스
		                            </label>
		                            <div class="col-sm-7 col-xs-8">
		                            	<input type="text" id="course_name" name="course_name" class="form-control"
		                                                placeholder="수강코스를 검색해주세요"
		                                                required="required" readonly>
                                        <input type="hidden" id="course_seq" name="course_seq">
		                            </div>
		                            <div class="btn-group col-sm-2 col-xs-4">
								        <button id=chkCs class="btn btn-primary btn-block mb-sm" role="button" type="button"><!-- 클릭하면 모달뜸 -->
											코스 검색
										</button>
							        </div>
	                            </div>
                            </fieldset>
                            <fieldset>
                            	<div class="form-group">
                                    <label class="control-label col-sm-3" for="basic">전화번호</label>
                                    <div class="col-sm-9">
                                        <input type="text" id="phone" name="phone" class="form-control mb-sm"
                                        		placeholder="ex) 010-1234-5678"
                                        		required="required">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-3" for="email">
                                        E-mail
                                    </label>
                                    <div class="col-sm-9">
                                        <input type="email" id="email" name="email" class="form-control mb-sm"
                                               data-parsley-trigger="change"
                                               data-parsley-validation-threshold="1"
                                               placeholder="ex) newbie@muggles.com"
                                               required="required">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-3" for="mask-date">
                                        	생년월일
                                    </label>
                                    <div class="col-sm-9">
                                        <input id="mask-date" name="birthDate" type="text" class="form-control" required="required" placeholder="ex) 1990-01-01">
                                    </div>
                                </div>
                            </fieldset>
                            <br />
                            <div class="clearfix">
	                            <div class="row">
	                                <div class="col-sm-6 col-sm-push-6">
	                                    <div class="clearfix">
	                                        <div class="checkbox widget-login-info pull-right ml-n-lg">
	                                            <input type="checkbox" id="checkbox1" value="1">
	                                            <label for="checkbox1">나는 다음의 <a href="#">약관</a>에 동의합니다. </label>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
                                <div class="btn-toolbar pull-right">
                                    <button type="submit" class="btn btn-inverse btn-md">회원가입 신청</button>
                                    <a class="btn btn-default btn-md" href="./index.do">취소</a>
                                </div>
                            </div>
                            
                        </form>
                    </div>
                </section>
            </div>
        </div>
        <!-- 모달 -->
        <div class="modal fade" id="myModal18" tabindex="-1" role="dialog" aria-labelledby="myModalLabel18" aria-hidden="true">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title text-align-center fw-bold mt" id="myModalLabel18">중복확인</h4>
                    </div>
                    <div class="modal-body bg-gray-lighter">
	                    <div class="row">
	                    	<center></center>
	                    </div>
		                <div class="modal-footer form-actions">
	                        <!-- <button type="button" class="btn btn-gray" data-dismiss="modal">취소</button> -->
	                        <button type="button" class="btn btn-success" data-dismiss="modal">확인</button>
	                    </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModal19" tabindex="-1" role="dialog" aria-labelledby="myModalLabel18" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title text-align-center fw-bold mt" id="myModalLabel18">코스 검색</h4>
                    </div>
                    <div class="modal-body bg-gray-lighter">
						<div class="form-group">
		                    <label class="control-label col-sm-2 col-xs-4" for="number">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;코스 시작일</label>
		                    <div class="col-sm-8 col-xs-8 bg-gray-lighter">
		                    	<input id="cs-date" type="text" class="form-control" required="required" placeholder="ex) 2016-01-01">
                            </div>
                            <div class="btn-group col-sm-2 col-xs-4">
						        <button id=chkCs2 class="btn btn-primary btn-block mb-sm" role="button" type="button"><!-- 클릭하면 모달뜸 -->
								코스 검색
								</button>
					        </div>
                        </div>
                        <div id = "searchResult"></div>
                        <div class="modal-footer form-actions bg-gray-lighter">
                        	<br />
                        	<button type="button" class="btn btn-gray btn-md" data-dismiss="modal">취    소</button>
                    	</div>	                    
                    </div>
              	</div>
           </div>
       	</div>
    </main>
</div>
<!-- The Loader. Is shown when pjax happens -->
<div class="loader-wrap hiding hide">
    <i class="fa fa-circle-o-notch fa-spin-fast"></i>
</div>

<!-- common libraries. required for every page-->
<script src="vendor/jquery/dist/jquery.min.js"></script>
<script src="vendor/jquery-pjax/jquery.pjax.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/transition.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/collapse.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/dropdown.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/button.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/tooltip.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/alert.js"></script>
<script src="vendor/slimScroll/jquery.slimscroll.min.js"></script>
<script src="vendor/widgster/widgster.js"></script>

<!-- common app js -->
<script src="js/settings.js"></script>
<script src="js/app.js"></script>
<script type = "text/javascript">
	$(document).ready(function(){
		var didChk = 1;
	    $('#chkId').on('click', function(){
	    	var id = $('#user_id').val();
	    	if (id == '') {
	    		alert('아이디를 입력해주세요');
	    	} else {
	    		$.ajax({
	    			url: './home_membership_chkId_ok.do',
					type: 'post',
					data: {
						id: id
					},
					dataType: 'json',
					success: function(json) {
						console.log(json.flag);
						if (json.flag == 0) {
							$("center").html('사용 가능한 아이디입니다');
        					didchk = 0;
        					$('#myModal18').modal('show');
      				  } else if (json.flag==1) {
      						$("center").html('동일한 아이디가 존재합니다');
        					$('#user_id').val('');
        					didchk = 1;
        					$('#myModal18').modal('show');
      				  } else {
      						$('#chkIdText').html('오류가 발생하였습니다');
      						$('#myModal18').modal('show');
      				  }
					},
					error: function(xhr, status, error) {
						alert('에러 : ' + status + '\n\n' + error);
					}
				});
	    	}	
	    });
	    
	    $('#chkCs').on('click', function(){
	    	$('#searchResult').empty();
	    	$('#cs-date').val('');
			$('#myModal19').modal('show');
	    });
	    
	    $('#chkCs2').on('click', function() {
	    	var startDate = $('#cs-date').val();
	    	console.log(startDate)
	    	if (startDate == '') {
	    		alert('코스 시작일을 입력해주세요');
	    	} else {
	    		$.ajax({
	    			url: './home_membership_chkCs_ok.do',
	    			type: 'post',
	    			data: {
	    				startDate: startDate
	    			},
	    			dataType: 'json',
	    			success: function(json) {
	    				$('#searchResult').empty();
	    				var result = '';
	    				$.each(json, function(index, value) {
	    					result += '<div class="form-group">';
	    					result += '<label class="control-label col-sm-2 col-xs-4"></label>';
    						result += '	<div class="col-sm-9">';
    						result += '		<label class="form-control mb-sm bg-gray-lighter" for="course" id="' + value.seq + '" name="' + value.c_name + '">[ ' + value.loc + ' ]  ' + value.c_name + '</label>';
    						result += ' </div>';
    						result += '</div>';

	    				});
    						$('#searchResult').append(result);

    					    $('label[for="course"]').on('click', function(e) {
    							$('#course_name').attr('value', $(this).attr('name'));
    							$('#course_seq').attr('value', e.target.id);
    							$('#myModal19').modal('hide');
    						});
	    			},
	    			error: function(xhr, status, error) {
	    				alert('에러 : ' + status + '\n\n' + error);
	    			}
	    		});
	    	}
	    });
	});
</script>

<!-- page specific libs -->
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/tooltip.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/modal.js"></script>
<script src="vendor/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
<script src="vendor/jquery-autosize/jquery.autosize.min.js"></script>
<script src="vendor/bootstrap3-wysihtml5/lib/js/wysihtml5-0.3.0.min.js"></script>
<script src="vendor/bootstrap3-wysihtml5/src/bootstrap3-wysihtml5.js"></script>
<script src="vendor/select2/select2.min.js"></script>
<script src="vendor/switchery/dist/switchery.min.js"></script>
<script src="vendor/moment/min/moment.min.js"></script>
<script src="vendor/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<script src="vendor/mjolnic-bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
<script src="vendor/jasny-bootstrap/js/inputmask.js"></script>
<script src="vendor/jasny-bootstrap/js/fileinput.js"></script>
<script src="vendor/holderjs/holder.js"></script>
<script src="vendor/dropzone/dist/min/dropzone.min.js"></script>
<script src="vendor/markdown/lib/markdown.js"></script>
<script src="vendor/bootstrap-markdown/js/bootstrap-markdown.js"></script>
<script src="vendor/seiyria-bootstrap-slider/dist/bootstrap-slider.min.js"></script>
<script src="vendor/parsleyjs/dist/parsley.js"></script>

<!-- page specific js -->
<script src="js/home_membership.js"></script>
</body>
</html>