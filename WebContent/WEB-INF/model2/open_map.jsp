<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <li class="active">오늘 머먹지</li>
        </ol>
        <h1 class="page-title">Food - <span class="fw-semi-bold">MatZip</span></h1>
        <div class="row">
    	    <!--------- 맛집 본문 ------------->
	        <div class="col-md-8">
                <section class="widget widget-chart-stats-simple">
                    <header>
                        <div class="row">
                            <div class="col-xs-6 col-sm-3">
                                <h4>
                                                    맛집
                                </h4>
                                <p class="value3">
                                                    세븐트레인
                                </p>
                            </div>
                            <div class="col-xs-3  col-sm-3">
                                <h4>
                                    <small>등록일</small>
                                </h4>
                                <p class="value5">
                                    2016.09.28
                                </p>
                            </div>
                        </div>
                        <div class="widget-controls">
                            <a href="#"><i class="glyphicon glyphicon-cog"></i></a>
                            <a href="#" data-widgster="close"><i class="glyphicon glyphicon-remove"></i></a>
                        </div>
                    </header>
                    <div class="widget-body">
                        <!-- 구글맵 -->
						<div style="height: 500px; position:ralative;">
				        	<div id="gmap" class="content-map">
			       		 	</div>
				        </div>
				        <!-- 맛집 등록 -->
				        <div class="chart-stats mt-sm">
                            <p class="text-muted fs-mini mt-xs">
                                <i class="fa fa-map-marker fa-5x pull-left"></i>
                                <span class="fw-semi-bold text-gray-dark">맛집등록:</span> 학원 근처의 새로운 맛집을 등록해주세요! 맛집 등록은 재학생만 가능합니다.
                            </p>
                            <div class="btn-toolbar">
                                <a class="btn btn-xs btn-success" href="open_map_write.do">맛집 등록하기</a>
                                <button class="btn btn-xs btn-default">정보수정</button>
                            </div>
                        </div>
                        <!-- 맛집 내용 -->
                        <div>
	                        <p class="fs-mini m">“죄송해요 엄마, 엄마가 끓여주신 것 보다 훨씬 맛있어요” 이 한 마디 평에 모든 것이 정리되는 동경 전통 육개장.
	                        		 이곳의 특징은 고사리나 숙주 없이 오직 양지와 사태 대파만 넣고 끓인 국물이다. 진한 국물의 전통 육개장은 7,000원, 갈비탕을 비롯한 다른 메뉴는 6,000원.
									국기원 사거리에서 한솥 도시락 방면으로 가다 보면 만날 수 있다. 
							</p>
	                        <div class="widget-image text-white">
	                            <img src="demo/img/pictures/19.jpg">
	                        </div>
                        </div>
                    </div>
                </section>
	        </div>
	        <!--------- 평점, 댓글 ----------->
	        <div class="col-md-4">
	          <!-- 평균 평점 -->
			  <section class="widget bg-white text-warning">
			    <div class="widget-body clearfix">
			        <div class="row">
			            <div class="col-xs-9">
			                <span class="widget-icon">
			                    <i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-half-o"></i><i class="fa fa-star-o"></i>
			                </span>
			            </div>
			            <div class="col-xs-3">
			                <h5 class="no-margin">평균</h5>
			                <p class="h2 no-margin fw-normal">3.5</p>
			            </div>
			        </div>
			    </div>
			  </section>
              <!-- 댓글 -->
	      	  <section class="widget">
	      	  	<header class="bb">
	               <h5>Table <span class="fw-semi-bold">Styles</span></h5>
	               <div class="widget-controls">
	                   <a href="#"><i class="glyphicon glyphicon-cog"></i></a>
	                   <a data-widgster="close" href="#"><i class="glyphicon glyphicon-remove"></i></a>
	               </div>
                </header>
                 <div class="widget-body">
                        <div class="widget-middle-overflow">
                            <ul class="list-group widget-chat-list-group">
                                <!-- 맛집 댓글 한개 -->
                                <li class="list-group-item">
                                <span class="thumb">
                                    <img class="img-circle" src="demo/img/people/a6.jpg" alt="...">
                                </span>
                                    <span class="starred"><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star"></i><i class="fa fa-star-o"></i></span>
                                    <time class="time">10 sec ago</time>
                                    <h5 class="sender">Chris Gray</h5>
                                    <p class="body">Hey! What's up? So much time since we saw each other there</p>
                                </li>
                                <!--  -->
                                <li class="list-group-item">
                                <span class="thumb">
                                    <img class="img-circle" src="demo/img/people/a6.jpg" alt="...">
                                </span>
                                    <time class="time">10 sec ago</time>
                                    <h5 class="sender">Chris Gray</h5>
                                    <p class="body">Hey! What's up? So much time since we saw each other there</p>
                                </li>
                                <li class="list-group-item">
                                <span class="thumb">
                                    <img class="img-circle" src="demo/img/people/a6.jpg" alt="...">
                                </span>
                                    <time class="time">10 sec ago</time>
                                    <h5 class="sender">Chris Gray</h5>
                                    <p class="body">Hey! What's up? So much time since we saw each other there</p>
                                </li>
                                <li class="list-group-item">
                                <span class="thumb">
                                    <img class="img-circle" src="demo/img/people/a6.jpg" alt="...">
                                </span>
                                    <time class="time">10 sec ago</time>
                                    <h5 class="sender">Chris Gray</h5>
                                    <p class="body">Hey! What's up? So much time since we saw each other there</p>
                                </li>
                                <li class="list-group-item">
                                <span class="thumb">
                                    <img class="img-circle" src="demo/img/people/a6.jpg" alt="...">
                                </span>
                                    <time class="time">10 sec ago</time>
                                    <h5 class="sender">Chris Gray</h5>
                                    <p class="body">Hey! What's up? So much time since we saw each other there</p>
                                </li>
                                <li class="list-group-item on-right">
                                <span class="thumb">
                                    <img class="img-circle" src="img/avatar.png" alt="...">
                                </span>
                                    <time class="time">10 sec ago</time>
                                    <h5 class="sender">John Doe</h5>
                                    <p class="body">True! Totally makes sense. But how do we find that?</p>
                                </li>
                                <li class="list-group-item">
                                <span class="thumb">
                                    <img class="img-circle" src="demo/img/people/a6.jpg" alt="...">
                                </span>
                                    <time class="time">10 sec ago</time>
                                    <h5 class="sender">Chris Gray</h5>
                                    <p class="body">OK, but so now what? What should we do now? Not sure actually.</p>
                                </li>
                                <li class="list-group-item on-right">
                                <span class="thumb">
                                    <img class="img-circle" src="img/avatar.png" alt="...">
                                </span>
                                    <time class="time">10 sec ago</time>
                                    <h5 class="sender">John Doe</h5>
                                    <p class="body">Hey guys, didn't you notice this conversation is sort of jubberish?</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <footer class="bg-body-light bt">
						<div class="input-group input-group-sm">
							<fieldset class="rating">
							    <input type="radio" id="star5" name="rating" value="5" /><label class = "full" for="star5" title="Awesome - 5 stars"></label>
							    <input type="radio" id="star4" name="rating" value="4" /><label class = "full" for="star4" title="Pretty good - 4 stars"></label>
							    <input type="radio" id="star3" name="rating" value="3" /><label class = "full" for="star3" title="Meh - 3 stars"></label>
							    <input type="radio" id="star2" name="rating" value="2" /><label class = "full" for="star2" title="Kinda bad - 2 stars"></label>
							    <input type="radio" id="star1" name="rating" value="1" /><label class = "full" for="star1" title="Sucks big time - 1 star"></label>
							</fieldset>
						</div>
                        <div class="input-group input-group-sm">
                            <textarea rows="2" class="autogrow form-control transition-height" id="elastic-textarea"
                                                  placeholder="Your Comment.."></textarea>
                            <div class="input-group-btn">
                                <button type="submit" class="btn btn-default" style="height:100%">
                                    Send
                                </button>
                            </div>
                        </div>
                    </footer>
	      	  </section>
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
<script src="vendor/jquery-autosize/jquery.autosize.min.js"></script>
<script src="vendor/slimScroll/jquery.slimscroll.min.js"></script>
<script src="vendor/widgster/widgster.js"></script>
<script src="vendor/pace.js/pace.min.js"></script>
<script src="vendor/jquery-touchswipe/jquery.touchSwipe.js"></script>

<!-- common app js -->
<script src="js/settings.js"></script>
<script src="js/app.js"></script>

<!-- page specific libs -->
<script src="http://maps.google.com/maps/api/js?key=AIzaSyBjcU7aVzQOIvfI4gamkw0ukJSlHaVMiZA"></script>
<script src="vendor/gmaps/gmaps.js"></script>

<!-- page specific js -->
<script src="js/open_map.js"></script>
</body>
</html>