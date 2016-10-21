<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.Iterator" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="model1.MemberTO" %>
<%@ page import="org.json.simple.JSONObject" %>

<%
	MemberTO to_log = (MemberTO)request.getAttribute("to_log");
	String id = (String)session.getAttribute("sessionId");
	
	String name = to_log.getUser_name();

	int level = to_log.getUser_level();
	String user_level = "";
	switch (level) {
	case 0 : user_level = "회원"; break;
	case 1 : user_level = "중간"; break;
	case 2 : user_level = "관리자"; break;
	default : user_level = "회원"; break;
	}
	
	String photo = to_log.getUser_photo();
	String last_logout = to_log.getUser_last_logout();
	
%>
<!DOCTYPE html>
<html>
<head>
    <title>Muggles</title>
    <link href="./css/application.css" rel="stylesheet">
    <!-- as of IE9 cannot parse css files with more that 4K classes separating in two files -->
    <!--[if IE 9]>
        <link href="./css/application-ie9-part2.css" rel="stylesheet">
    <![endif]-->
    <link rel="shortcut icon" href="./img/favicon.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="this it acon academy community site">
    <meta name="author" content="Glasses Team">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script>
        /* yeah we need this empty stylesheet here. It's cool chrome & chromium fix
         chrome fix https://code.google.com/p/chromium/issues/detail?id=167083
         https://code.google.com/p/chromium/issues/detail?id=332189
         */
    </script>
</head>
<body>
<!------------------------------왼쪽 슬라이드 바------------------------------------------->
<nav id="sidebar" class="sidebar" role="navigation">
    <!-- need this .js class to initiate slimscroll -->
    <div class="js-sidebar-content">
        <header class="logo hidden-xs">
            <a href="./home_main.do">Muggles</a>
        </header>
        <!-- 슬라이드바에 유저 정보 -->
        <div class="sidebar-status visible-xs">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <span class="thumb-sm avatar pull-right">
                    <img class="img-circle" src="./demo/img/people/a5.jpg" alt="..">
                </span>
                <!-- 안 읽은 공지 숫자 넣는곳 -->
                <span class="circle bg-warning fw-bold text-gray-dark">
                    13
                </span>
                <!-- 사람 이름 넣는 곳 -->
                &nbsp;
          	    <strong><%= user_level %></strong> <%= name %>
                <b class="caret"></b>
            </a>
            <!--  로그인 안했을 경우 위에 a태그 지우고 버튼만
            <a href="login.html" class="btn btn-inverse mb-xs" style="width:100%" role="button">
                <span class="circle bg-white">
                    <i class="fa fa-sign-in text-gray"></i>
                </span>
                Log In
            </a>
            -->            
            <!-- 로그아웃 버튼 -->
            <form action="/home_logout.do">
            <button class="btn btn-inverse mb-xs" style="width:100%" role="button" id="logOut" type="submit">
                <span class="circle bg-white">
                    <i class="fa fa-sign-out text-gray"></i>
                </span>
                log out
            </button>
            </form>
            <!-- #notifications-dropdown-menu goes here when screen collapsed to xs or sm -->
        </div>
        <!-- 사이드바 내용 -->
        <ul class="sidebar-nav">
	        <!-- 토글 사이드바 목록 -->
            <li class="active">
                <a class="collapsed" href="#sidebar-my" data-toggle="collapse" data-parent="#sidebar">
                    <span class="icon">
                        <i class="fa fa-desktop"></i>
                    </span>
                    My Account
                    <i class="toggle fa fa-angle-down"></i>
                </a>
                <ul id="sidebar-my" class="collapse">
                    <li><a href="./my_writing.do">내가 쓴 글</a></li>
                    <li><a href="./my_study.do">참여 스터디</a></li>
                    <li><a href="./my_account.do">정보 수정</a></li>
                </ul>
            </li>
        </ul>
        <!-- 공개게시판 사이드바 -->
        <h5 class="sidebar-nav-title">Open Board <a class="action-link" href="#"><i class="glyphicon glyphicon-refresh"></i></a></h5>
        <ul class="sidebar-nav">
        	<!-- 사이드바 목록 1개-->
            <li>
                <a href="./open_calendar.do">
                    <span class="icon">
                        <i class="fa fa-calendar"></i>
                    </span>
                              달력
                </a>
            </li>
            <li>
                <a href="./open_map.do">
                    <span class="icon">
                        <i class="glyphicon glyphicon-map-marker"></i>
                    </span>
                              오늘머먹지
                </a>
            </li>
            <li>
                <a href="./open_free.do">
                    <span class="icon">
                        <i class="fa fa-quote-left"></i>
                    </span>
                              자유게시판
                </a>
            </li>
            <li>
                <a href="./open_study.do">
                    <span class="icon">
                        <i class="fa fa-users"></i>
                    </span>
                              스터디모집
                </a>
            </li>
            <li>
                <a href="./open_recommend.do">
                    <span class="icon">
                        <i class="glyphicon glyphicon-th-list"></i>
                    </span>
                              추천사이트
                </a>
            </li>
            <li>
              	<a href="./open_qna.do">
                    <span class="icon">
                        <i class="fa fa-question"></i>
                    </span>
                              질문게시판
                </a>
            </li>
        </ul>
        <!-- 비공개 게시판 사이드바 -->
        <h5 class="sidebar-nav-title">private board <a class="action-link" href="#"><i class="glyphicon glyphicon-plus"></i></a></h5>
        <ul class="sidebar-nav">
            <li>
                <a class="collapsed" href="#sidebar-class1" data-toggle="collapse" data-parent="#sidebar">
                    <span class="icon">
                        <i class="fa fa-table"></i>
                    </span>
                              반별게시판 1
                    <i class="toggle fa fa-angle-down"></i>
                </a>
                <ul id="sidebar-class1" class="collapse">
                    <li><a href="./priv_review.do">복습 게시판</a></li>
                    <li><a href="./priv_qna.do">질문 게시판</a></li>
                    <li><a href="./priv_talk.do">수다 게시판</a></li>
                </ul>
            </li>
            <!-- 수강클래스가 많은 학생은 개시판  더 생김 -->
            <li>
                <a class="collapsed" href="#sidebar-class2" data-toggle="collapse" data-parent="#sidebar">
                    <span class="icon">
                        <i class="fa fa-table"></i>
                    </span>
                              반별게시판 2
                    <i class="toggle fa fa-angle-down"></i>
                </a>
                <ul id="sidebar-class2" class="collapse">
                    <li><a href="#">복습 게시판</a></li>
                    <li><a href="#">질문 게시판</a></li>
                    <li><a href="#">수다 게시판</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
<!-------------------------------- 상단 네비게이션 바 --------------------------------------->
<nav class="page-controls navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <!------- 상단바 왼쪽 ------->
            <ul class="nav navbar-nav">
                <li>
                    <!-- 큰화면에서 사이드바 고정 버튼 -->
                    <a class="hidden-sm hidden-xs" id="nav-state-toggle" href="#" title="Turn on/off sidebar collapsing" data-placement="bottom">
                        <i class="fa fa-bars fa-lg"></i>
                    </a>
                    <!-- 작은화면에서 사이드바 열기 버튼-->
                    <a class="visible-sm visible-xs" id="nav-collapse-toggle" href="#" title="Show/hide sidebar" data-placement="bottom">
                        <span class="rounded rounded-lg bg-gray text-white visible-xs"><i class="fa fa-bars fa-lg"></i></span>
                        <i class="fa fa-bars fa-lg hidden-xs"></i>
                    </a>
                </li>
                <!-- 새로고침 버튼 큰화면에서 -->
                <li class="ml-sm mr-n-xs hidden-xs"><a href="#"><i class="fa fa-refresh fa-lg"></i></a></li>
            </ul>
            <!------- 상단바 오른쪽 ------->
            <ul class="nav navbar-nav navbar-right visible-xs">
                <li>
                    <!-- 채팅 토글 -->
                    <a href="#" data-toggle="chat-sidebar">
                        <span class="rounded rounded-lg bg-gray text-white"><i class="fa fa-globe fa-lg"></i></span>
                    </a>
                </li>
            </ul>
            <!-- 작은화면일때 홈피 로고 -->
            <a class="navbar-brand visible-xs" href="index.html">
                <i class="fa fa-circle text-gray mr-n-sm"></i>
                <i class="fa fa-circle text-warning"></i>
                &nbsp;
                Muggle
                &nbsp;
                <i class="fa fa-circle text-warning mr-n-sm"></i>
                <i class="fa fa-circle text-gray"></i>
            </a>
        </div>

        <div class="collapse navbar-collapse">
            <!-- 큰화면일 때 검색 -->
            <form class="navbar-form navbar-left" role="search">
                <div class="form-group">
                    <div class="input-group input-group-no-border">
                    <span class="input-group-addon">
                        <i class="fa fa-search"></i>
                    </span>
                        <input class="form-control" type="text" placeholder="Search Dashboard">
                    </div>
                </div>
            </form>
            <!-------- 유저 알람 드롭다운 --------->
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle dropdown-toggle-notifications" id="notifications-dropdown-toggle" data-toggle="dropdown" 
                    						   data-ajax-trigger="click"
                                               data-ajax-load="./demo/ajax/notifications.html"
                                               data-ajax-target="#notifications-list">
                        <span class="thumb-sm avatar pull-left">
                            <img class="img-circle" src="./demo/img/people/juhwan.gif" alt="..">
                        </span>
                        <!-- 사람 이름 넣는 곳 -->
		               	&nbsp;
		         	    <strong><%= user_level %></strong> <%= name %>
                        &nbsp;
                        <!-- 안 읽은 공지 숫자 넣는곳 -->
                        <span class="circle bg-warning fw-bold">
                            13
                        </span>
                        <b class="caret"></b></a>
                    <!-- ready to use notifications dropdown.  inspired by smartadmin template.
                         consists of three components:
                         notifications, messages, progress. leave or add what's important for you.
                         uses Sing's ajax-load plugin for async content loading. See #load-notifications-btn -->
                    <div class="dropdown-menu animated fadeInUp" id="notifications-dropdown-menu">
                        <section class="panel notifications">
                            <header class="panel-heading">
                                <!-- 알림제목 -->
                                <div class="text-align-center mb-sm">
                                    <strong>새로운 알림이  13개 있습니다.</strong>
                                </div>
                                <div class="btn-group btn-group-sm btn-group-justified" id="notifications-toggle" data-toggle="buttons">
                                    <!-- 버튼 누르면 알림 ajax 데이터 가져옴 -->
                                    <label class="btn btn-default active">
                                        <!-- ajax-load plugin in action. setting data-ajax-load & data-ajax-target is the
                                             only requirement for async reloading -->
                                        <input type="radio" checked
                                               data-ajax-trigger="change"
                                               data-ajax-load="./demo/ajax/notifications.html"
                                               data-ajax-target="#notifications-list"> Notifications
                                    </label>
                                    <label class="btn btn-default">
                                        <input type="radio"
                                               data-ajax-trigger="change"
                                               data-ajax-load="./demo/ajax/messages.html"
                                               data-ajax-target="#notifications-list"> Messages
                                    </label>
                                    <label class="btn btn-default">
                                        <input type="radio"
                                               data-ajax-trigger="change"
                                               data-ajax-load="./demo/ajax/progress.html"
                                               data-ajax-target="#notifications-list"> Progress
                                    </label>
                                </div>
                            </header>
                            <!-- notification list with .thin-scroll which styles scrollbar for webkit -->
                            <div id="notifications-list" class="list-group thin-scroll">
                                <!-- 공지 ajax로 들어가는 곳 -->
                            </div>
                            <footer class="panel-footer text-sm">
                                <!-- 동기화 버튼 -->
                                <button class="btn btn-xs btn-link pull-right"
                                        id="load-notifications-btn"
                                        data-ajax-load="./demo/ajax/notifications.html"
                                        data-ajax-target="#notifications-list"
                                        data-loading-text="<i class='fa fa-refresh fa-spin mr-xs'></i> Loading..">
                                    <i class="fa fa-refresh"></i>
                                </button>
                                <span class="fs-mini">마지막 로그아웃 시간 : <%= last_logout %></span>
                            </footer>
                        </section>
                    </div>
                </li>
                <li>
                	<!-- 로그인 안 했을때 밑에 로그아웃 버튼 대신 씀
                    <a href="login.html" class="dropdown-toggle" data-toggle="dropdown">
                        <i class="fa fa-sign-in"></i>&nbsp; Log In
                    </a> -->
                	<!-- 로그아웃 -->
                	<a href="./home_logout.do" class="dropdown-toggle" data-toggle="dropdown" onclick="location.href=this.href" return false;>
                        <i class="fa fa-sign-out"></i>&nbsp; Log Out
                    </a>
                </li>
                <li>
                	<!-- 채팅 토글 버튼 -->
                    <a href="#" data-toggle="chat-sidebar">
                        <i class="fa fa-globe fa-lg"></i>
                    </a>
                    <!-- 채팅 알림 -->
                    <div id="chat-notification" class="chat-notification hide">
                        <div class="chat-notification-inner">
                            <h6 class="title">
                                <span class="thumb-xs">
                                    <img src="./demo/img/people/a6.jpg" class="img-circle mr-xs pull-left">
                                </span>
                                                이기용
                            </h6>
                            <p class="text">주환아 머하냐?</p>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!------------------------------ 채팅 사이드바 ----------------------------------------->
<div class="chat-sidebar" id="chat">
    <div class="chat-sidebar-content">
        <header class="chat-sidebar-header">
            <h4 class="chat-sidebar-title">Contacts</h4>
            <div class="form-group no-margin">
                <div class="input-group input-group-dark">
                    <input class="form-control fs-mini" id="chat-sidebar-search" type="text" placeholder="Search..">
                    <span class="input-group-addon">
                        <i class="fa fa-search"></i>
                    </span>
                </div>
            </div>
        </header>
        <div class="chat-sidebar-contacts chat-sidebar-panel open">
            <!-- 오늘온 채팅 -->
            
            <h5 class="sidebar-nav-title">List</h5>
            
            
        <%
            StringBuffer result = new StringBuffer();
            StringBuffer result2 = new StringBuffer();
            
        	JSONArray datas = (JSONArray)request.getAttribute("datas");

        	
        	for (Object obj : datas) {
        		
        		JSONObject jobj = (JSONObject)obj;
        		
        		String user_id = jobj.get("user_id").toString();
        		String user_name = jobj.get("user_name").toString();
        		String user_photo = jobj.get("user_photo").toString();
        		
        		result.append("<div class=\"list-group chat-sidebar-user-group\">");
        		result.append("<a class=\"list-group-item\" href=\"#" + user_id + "\">");
        		
        		/* href="#chat-sidebar-user-1" */
        		
        		/* 여기에 if문으로 내용 걸러줄 것 (채팅 가능 초록불 여부 결정) */
        		result.append("<i class=\"fa fa-circle text-success pull-right\"></i>"); /* 접속해 있으면 초록색 text-success */

        		result.append("<span class=\"thumb-sm pull-left mr\">");
        		result.append("<img class=\"img-circle\" src=" + user_photo + " alt=\"..\">");
        		result.append("</span>");
        		result.append("<h5 class=\"message-sender\">" + user_name + "</h5>");
        		result.append("<p class=\"message-preview\">...</p>");
        		result.append("</a>");
        		result.append("</div>");
  
        		result2.append("<div class=\"chat-sidebar-chat chat-sidebar-panel\" id=\"" + user_id + "\">");
        		result2.append("<h5 class=\"title\">");
        		result2.append("    <a class=\"js-back\" href=\"#\">");
        		result2.append("        <i class=\"fa fa-angle-left mr-xs\"></i>");
        		result2.append(				user_name);
        		result2.append("    </a>");
        		result2.append("</h5>");
        		result2.append("<ul class=\"message-list\">");
        		
        		/* 실제 메시지 내용을 뿌려줘야하는 부분 */
        		
        		result2.append("</ul>");
        		result2.append("</div>");       		
        	}
        	
        %>
        <%= result %>
        </div>

		<!-- 채팅목록 클릭시 채팅창 -->
        <%= result2 %>
<!--            <li class="message">
                    <span class="thumb-sm">
                        <img class="img-circle" src="./demo/img/people/a2.jpg" alt="..">
                    </span>
                    <div class="message-body">
                        Hey! What's up?
                    </div>
                </li>
--!>                

        <!-- 채팅 입력 input -->
        <footer class="chat-sidebar-footer form-group">
            <input class="form-control input-dark fs-mini" id="chat-sidebar-input" type="text"  placeholder="Type your message">
        </footer>
    </div>
</div>

<!-------------------------------- 매인 창 ------------------------------------>
<div class="content-wrap">
    <!-- main page content. the place to put widgets in. usually consists of .row > .col-md-* > .widget.  -->
    <main id="content" class="content" role="main">
        <ol class="breadcrumb">
            <li>YOU ARE HERE</li>
            <li class="active">수다게시판</li>
        </ol>
        <h1 class="page-title">Closed - <span class="fw-semi-bold">Talk</span></h1>
        <div class="clearfix">
        <div class="btn-group pull-right">
            <button class="btn btn-default width-100 mb mt-n-lg" role="button" data-toggle="modal" data-target="#close-talk-write"><!-- 클릭하면 모달뜸 -->
			    <span class="circle bg-white">
			        <i class="glyphicon glyphicon-pencil text-gray"></i>
			    </span>
			    글쓰기
			</button>
        </div>
        </div>
        <ul class="timeline">
          	<!-- 수다 1개 영역 --> 
            <li class="on-left">
                <!-- 시간 중간선 -->
                <time class="event-time" datetime="2016-10-02 8:03">
                    <span class="date">today</span>
                    <span class="time">8:03 <span class="fw-semi-bold">pm</span></span>
                </time>
                <span class="event-icon event-icon-success">
                    <i class="glyphicon glyphicon-map-marker"></i>
                </span>
                <!-- 수다 본문 -->
                <section class="event">
                    <!-- 머리말 -->
                    <span class="thumb-sm avatar pull-left mr-sm">
                        <img class="img-circle" src="demo/img/people/a2.jpg" alt="...">
                    </span>
                    <h4 class="event-heading"><a href="#">박주환</a> <small>@얼짱</small></h4>
                    <p class="fs-sm text-muted">8:03 am</p>
                    <!-- 중간 -->
                    <p class="fs-mini">
                        	점심 순대국밥 먹자<br />
                        	나 잘생김 ㅇㅈ?
                    </p>
                    <div class="event-image">
                        <a href="demo/img/pictures/9.jpg">
                            <img src="demo/img/pictures/9.jpg">
                        </a>
                    </div>
                    <!-- 꼬릿말 -->
                    <footer>
                        <ul class="post-links">
                            <li><a href="#"><span class="text-danger"><i class="fa fa-heart"></i> Like</span></a></li>
                            <li><a href="#">댓글 2</a></li>
                        </ul>
                        <!-- 댓글 -->
                        <ul class="post-comments">
                            <li>
                                <span class="thumb-xs avatar pull-left mr-sm">
                                    <img class="img-circle" src="demo/img/people/a4.jpg" alt="...">
                                </span>
                                <div class="comment-body">
                                    <h6 class="author fw-semi-bold">이기용 <small>10 mins ago</small></h6>
                                    <p>ㅇㅈ</p>
                                </div>
                            </li>
                            <li>
                                <span class="thumb-xs avatar pull-left mr-sm">
                                    <img class="img-circle" src="demo/img/people/a2.jpg" alt="...">
                                </span>
                                <div class="comment-body">
                                    <h6 class="author fw-semi-bold">박주환 <small>7 mins ago</small></h6>
                                    <p>ㄳ</p>
                                </div>
                            </li>
                            <li>
                                <span class="thumb-xs avatar pull-left mr-sm">
                                    <img class="img-circle" src="img/avatar.png" alt="...">
                                </span>
                                <div class="comment-body">
                                    <input class="form-control input-sm" type="text" placeholder="댓글을 적어주세요...">
                                </div>
                            </li>
                        </ul>
                    </footer>
                </section>
            </li>
            <!--  -->
            <li>
                <time class="event-time" datetime="2016-10-01 9:41">
                    <span class="date">yesterday</span>
                    <span class="time">9:41 <span class="fw-semi-bold">pm</span></span>
                </time>
                <span class="event-icon event-icon-primary">
                    <i class="glyphicon glyphicon-comment"></i>
                </span>
                <section class="event">
                    <span class="thumb-sm avatar pull-left mr-sm">
                        <img class="img-circle" src="demo/img/people/a5.jpg" alt="...">
                    </span>
                    <h4 class="event-heading"><a href="#">송정훈</a> <small><a href="#">@짱</a></small></h4>
                    <p class="fs-sm text-muted">2016.10.01 9:41 PM</p>
                    <p class="fs-mini">
                        	주환이형 프로젝트 어디까지 했음?
                    </p>
                    <footer>
                        <ul class="post-links">
                            <li><a href="#"><span class="text-danger"><i class="fa fa-heart"></i> Like</span></a></li>
                            <li><a href="#">댓글 0</a></li>
                        </ul>
                        <ul class="post-comments">
                            <li>
                                <span class="thumb-xs avatar pull-left mr-sm">
                                    <img class="img-circle" src="img/avatar.png" alt="...">
                                </span>
                                <div class="comment-body">
                                    <input class="form-control input-sm" type="text" placeholder="댓글을 적어주세요...">
                                </div>
                            </li>
                        </ul>
                    </footer>
                </section>
            </li>
        </ul>
        <!-- 모달 -->
		<div class="modal fade" id="close-talk-write" tabindex="-1" role="dialog" aria-labelledby="close-talk-write" aria-hidden="true">
		    <div class="modal-dialog modal-lg">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title text-align-center fw-bold mt" id="myModalLabel18">수다게시판 글쓰기</h4>
		                <p class="text-align-center fs-mini text-muted mt-sm">
		                    	수다게시판입니다. 반친구와 간단한 대화를 나눠보세요
		                </p>
		            </div>
		            <div class="modal-body bg-gray-lighter">
		                    <div class="row">
		                    <form id="validation-form" class="form-label-left mt" method="post"
		                      data-parsley-priority-enabled="false"
		                      novalidate="novalidate">
		                         <fieldset>
			                         <div class="form-group">    
				                          <div class="col-md-12">
				                              <textarea rows="6" id="wysiwyg-study" name="content" class="form-control" 
				                                  data-parsley-trigger="change"
				                                  data-parsley-minlength="20"
				                                  required="required"></textarea>
				                          </div>
			                         </div>
			                         <!-- 이미지 -->
			                         <div class="form-group">
			                             <label class="control-label col-sm-3 mt" for="fileupload1">
			                                 	이미지 업로드
			                             </label>
			                             <div class="col-sm-9">
			                                 <div class="fileinput fileinput-new input-group mt" data-provides="fileinput">
	                                            <div class="form-control" data-trigger="fileinput">
	                                                <i class="glyphicon glyphicon-file fileinput-exists"></i>
	                                                <span class="fileinput-filename"></span>
	                                            </div>
	                                            <span class="input-group-addon btn btn-default btn-file">
	                                                <span class="fileinput-new">Select file</span>
	                                                <span class="fileinput-exists">Change</span>
	                                                <input id="fileupload1" type="file">
	                                            </span>
	                                            <a href="#" class="input-group-addon btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>
	                                        </div>
			                             </div>
			                         </div>
		                        </fieldset>
		                        <fieldset class="mt">
		                         <legend>
		                             	사용자 정보
		                         </legend>
		                             <div class="form-group">
		                                 <label class="control-label col-sm-3" for="title">작성자</label>
		                                 <div class="col-sm-9">
		                                     <input type="text" id="title" name="title" class="form-control"
		                                            placeholder="작성자" required="required">
		                                 </div>
		                             </div>
		                             <div class="form-group">
		                                 <label class="control-label col-sm-3" for="password">
		                                     Password
		                                 </label>
		                                 <div class="col-sm-5">
		                                     <input type="password" id="password" name="password" class="form-control mb-sm"
		                                            data-parsley-trigger="change"
		                                            data-parsley-minlength="6"
		                                            placeholder="비밀번호"
		                                            required="required">
		                                 </div>
		                                 <div class="col-sm-4">
		                                     <input type="password" id="password-r" name="password-r" class="form-control"
		                                            data-parsley-trigger="change"
		                                            data-parsley-minlength="6"
		                                            data-parsley-equalto="#password"
		                                            placeholder="비밀번호 확인"
		                                            required="required">
		                                 </div>
		                             </div>
		                     </fieldset>
		                     <div class="modal-footer form-actions">
				                   <button type="button" class="btn btn-gray" data-dismiss="modal">Close</button>
				                   <button type="submit" class="btn btn-success">Save changes</button>
				             </div>
		                     </form>
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
<script src="vendor/pace.js/pace.min.js"></script>
<script src="vendor/jquery-touchswipe/jquery.touchSwipe.js"></script>

<!-- common app js -->
<script src="js/settings.js"></script>
<script src="js/app.js"></script>

<!-- page specific libs -->
<script src="vendor/magnific-popup/dist/jquery.magnific-popup.min.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/modal.js"></script>
<script src="vendor/jasny-bootstrap/js/fileinput.js"></script>

<!-- page specific js -->
<script src="js/priv_talk.js"></script>
</body>
</html>