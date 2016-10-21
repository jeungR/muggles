<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Hello, Muggles!</title>
    <link href="css/application.min.css" rel="stylesheet">
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
</head>
<body class="login-page">

<div class="container">
    <main id="content" class="widget-login-container" role="main">
        <div class="row">
            <div class="col-lg-4 col-sm-6 col-xs-10 col-lg-offset-4 col-sm-offset-3 col-xs-offset-1">
                <h4 class="widget-login-logo animated fadeInUp">
                    <i class="fa fa-circle text-gray"></i>
                    Muggle
                    <i class="fa fa-circle text-warning"></i>
                </h4>
                <section class="widget widget-login animated fadeInUp">
                    <header>
                        <h3>환영합니다, Muggles!</h3>
                    </header>
                    <div class="widget-body">
                        <p class="widget-login-info">
                            에이콘 아카데미 수강생들을 위한 공간입니다.
                        </p>
                        <p class="widget-login-info">
                            계정이 없으시다구요? 지금 빨리 가입하세요!
                        </p>
                        <form action="home_login_ok.do" class="login-form mt-lg" id="login-form">
                            <div class="form-group">
                                <input type="text" class="form-control" id="userId" name="userId" placeholder="UserID">
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" id="userPw" name="userPw" placeholder="Password">
                            </div>
                            <div class="clearfix">
		                            <div class="checkbox widget-login-info pull-left ml-n-lg">
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <input type="checkbox" id="checkbox1" value="1">
                                            <label for="checkbox1">로그인 상태 유지</label>
                                    </div>
                                <div class="btn-toolbar pull-right">
                                    <a type="button" class="btn btn-default btn-sm" id="btn-register">회원 가입</a>
                                    <a class="btn btn-inverse btn-sm" href="#" id="btn-login">로그인</a>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6 col-sm-push-6">
                                    
                                </div>

                                <div class="col-sm-6 col-sm-pull-6">
                                    <a class="mr-n-lg" href="#">비밀번호가 뭐였지?</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </section>
            </div>
        </div>
    </main>
    <footer class="page-footer">
        2016 &copy; Muggles. Admin Dashboard Template.
    </footer>
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
	    $('#btn-login').on('click', function(){
	    	var id = $('#userId').val().trim();
	    	var pw = $('#userPw').val().trim();
	    	console.log("Haha");
	    	if (id == '') {
	    		alert('아이디를 입력해주세요');
	    	} else if (pw == '') {
	    		alert('비밀번호를 입력해주세요');
	    	} else {
				$('#login-form').submit();    		
	    	}
	    });
	    
	    $('#btn-register').on('click', function() {
	    	location.href = "./home_membership.do";
	    });
	    
	    $('#checkId').on('click', function(){
	    	console.log($('#id').val());
	    	if ($('#id').val().trim() == '') {
	    		alert('아이디를 입력해주세요');
	    	} else {
	    		$.ajax({
	                url : './checkId.do',
	                type : 'post',
	                data : {
	              	  id: $('#id').val()
	                },
	                dataType : 'json',
	                success : function(json){
	              	  if (json.flag == 0) {
	        					alert('중복되는 아이디가 없습니다');
	        					chkId = 0;
	      				  } else if (json.flag==1) {
	        					alert('동일한 아이디가 존재합니다');
	        					$('#id').val('');
	      				  } else {
	      					  	alert('오류 발생');
	      				  }
	                },
	                error : function(xhr, status, error) {
	      			 alert('에러 : ' + status + '\n\n' + error);
	                }
	         	});
	    	}
	    });
	});
</script>
<!-- page specific libs -->
<!-- page specific js -->
</body>
</html>