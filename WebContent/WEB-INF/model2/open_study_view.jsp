<%@page import="model1.Stu_board_Dao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@  page import="model1.Stu_board_Dto"%>

<%@ page import="java.util.Iterator" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="model1.MemberTO" %>
<%@ page import="org.json.simple.JSONObject" %>

<%
	request.setCharacterEncoding("utf-8");
	Stu_board_Dto dto = (Stu_board_Dto)request.getAttribute("dto");
	
	int stu_seq =dto.getStu_seq();
	String content = dto.getStu_content();
	String title = dto.getStu_title();
	String user_name = dto.getUser_name();
	String location = dto.getStu_location();
	String user_id = dto.getUser_id();
	String stu_s_date = dto.getStu_s_date();
	String stu_e_date = dto.getStu_e_date();
	int stu_p_num = dto.getStu_p_num();
	int stu_m_num = dto.getStu_m_num();
	String user_mail = dto.getUser_mail();
	String user_phone = dto.getUser_phone();
	String stu_wdate = dto.getStu_wdate();
	String stu_selectdate = dto.getStu_select_date();
	String wuser_seq = dto.getUser_seq();
	
	System.out.println(wuser_seq);
	System.out.println(stu_seq);
%>

<%
	MemberTO to_log = (MemberTO)request.getAttribute("to_log");
	String id = (String)session.getAttribute("sessionId");
	String user_seq = to_log.getUser_seq();
	System.out.println("stu_view 유저시퀀스" + user_seq);
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
        		
        		String log_user_id = jobj.get("user_id").toString();
        		String log_user_name = jobj.get("user_name").toString();
        		String user_photo = jobj.get("user_photo").toString();
        		
        		result.append("<div class=\"list-group chat-sidebar-user-group\">");
        		result.append("<a class=\"list-group-item\" href=\"#" + log_user_id + "\">");
        		
        		/* href="#chat-sidebar-user-1" */
        		
        		/* 여기에 if문으로 내용 걸러줄 것 (채팅 가능 초록불 여부 결정) */
        		result.append("<i class=\"fa fa-circle text-success pull-right\"></i>"); /* 접속해 있으면 초록색 text-success */

        		result.append("<span class=\"thumb-sm pull-left mr\">");
        		result.append("<img class=\"img-circle\" src=" + user_photo + " alt=\"..\">");
        		result.append("</span>");
        		result.append("<h5 class=\"message-sender\">" + log_user_name + "</h5>");
        		result.append("<p class=\"message-preview\">...</p>");
        		result.append("</a>");
        		result.append("</div>");
  
        		result2.append("<div class=\"chat-sidebar-chat chat-sidebar-panel\" id=\"" + log_user_id + "\">");
        		result2.append("<h5 class=\"title\">");
        		result2.append("    <a class=\"js-back\" href=\"#\">");
        		result2.append("        <i class=\"fa fa-angle-left mr-xs\"></i>");
        		result2.append(				log_user_name);
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
   
        <ol class="breadcrumb hidden-print">
            <li>YOU ARE HERE</li>
            <li class="active">스터디 게시판</li>
        </ol>
        <h1 class="page-title hidden-print">Study - <span class="fw-semi-bold">Board</span></h1>
        <div class="row">
        	<!-- 뒤로가기 버튼 -->
        	<div class="col-md-12 hidden-print" style="height:35px;">
        		<a class="btn btn-default btn-sm width-50 pull-left" id="back-btn" href="open_study.do">
                    <i class="fa fa-angle-left fa-lg"></i>
                </a>
            </div>
            <div class="col-md-8">
            	<!-- 게시판 글 내용 (인쇄가능 영역) -->
                <section class="widget widget-invoice">
                    <header>
                        <div class="row">
                            <div class="col-sm-9 col-print-9">
                                <span class="icon fa-2x"><i class="fa fa-users"></i> </span><span class="fa-lg"><%=title %></span>
                            </div>
                            <div class="col-sm-3 col-print-3">
                                <h4 class="text-align-right">
                                    #<span class="fw-semi-bold"><%=stu_seq %></span> / <small><%=user_id %></small>
                                </h4>
                                <div class="text-muted fs-larger text-align-right">
                                    <%=stu_wdate %>
                                </div>
                            </div>
                        </div>
                    </header>
                    <div class="widget-body">
                        <!-- 스터디 정보 -->
                        <div class="row mb-lg">
                            <section class="col-sm-10 col-print-10">
                                <h4 class="text-muted no-margin mb-sm">스터디 정보</h4>
                                <address>
                                    <strong><i class="fa fa-map-marker mb-xs"></i> &nbsp; <%=location %></strong><br>
                                    <i class="glyphicon glyphicon-calendar mb-xs"></i><time><%=stu_selectdate %> / <%=stu_s_date %> - <%=stu_e_date %></time><br>
                                    <i class="glyphicon glyphicon-user mb-xs"></i>모집인원 <%=stu_p_num %>/<%=stu_m_num %></a><br>
                                    <abbr title="Work name">조장 :</abbr> <%=user_name %><br>
                                    <abbr title="Work email">e-mail:</abbr> <a href="mailto:#"><%=user_mail %></a><br>
                                    <abbr title="Work Phone">phone:</abbr> <%=user_phone %><br>
                                </address>
                            </section>
                        </div>
                        <div class="row">
                        <section>
                        	<div class="col-sm-12 col-print-12">
                                <!-- 글내용이 들어가는 부분 -->
                                <p><%=content %></p>
                            </div>
                        </section>
                        </div>
                        <br />
                        <p class="text-align-right text-gray-light mt-lg mb-xs hidden-print">
                           	  부적합한 게시물은 관리자가 삭제할 수 있습니다. 부적합 게시물을 올릴경우 제제를 받을 수 있습니다.
                        </p>
                        <div class="btn-toolbar mt-lg text-align-right hidden-print">
                            <button id="print" class="btn btn-inverse">
                                <i class="fa fa-print"></i>
                                &nbsp;&nbsp;
                                Print
                            </button>
                            <button class="btn btn-primary" data-toggle="modal" data-target="#myModal_mod"><!-- 클릭시 모달 -->
                                	글수정
                                &nbsp;
                                <span class="circle bg-white">
                                    <i class="fa fa-arrow-right text-primary"></i>
                                </span>
                            </button>
                            <button class="btn btn-danger" id="stu_delete_btn" idx="<%=stu_seq %>"><!-- 클릭시 모달 -->
                                	글삭제
                                &nbsp;
                                <input type="hidden" id="stu_wuser_seq" idx="<%=wuser_seq %>" />
                                <input type="hidden" id="stu_user_seq"idx="<%=user_seq %>" />
                                <span class="circle bg-white">
                                    <i class="fa fa-trash-o text-danger"></i>
                                </span>
                            </button>
                        </div>
                    </div>
                </section>
            </div>
            <!--------- 댓글 ----------->
	        <div class="col-md-4 hidden-print">
	      	  <section class="widget">
	      	  	<header class="bb">
	               <h5>현재 글 <span class="fw-semi-bold">댓글</span></h5>
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
                                    <time class="time">10 sec ago</time>
                                    <h5 class="sender">Chris Gray</h5>
                                    <p class="body">Hey! What's up? So much time since we saw each other there</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <footer class="bg-body-light bt">
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
        <!-- 모달 삭제 비번확인 -->
<div class="modal fade" id="myModal_del_pw" tabindex="-1" role="dialog" aria-labelledby="myModal_del_pw" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-align-center fw-bold mt" id="myModalLabel18">스터디게시판 글삭제</h4>
                <p class="text-align-center fs-mini text-muted mt-sm">
                    	비밀번호를 입력하세요
                </p>
            </div>
            <div class="modal-body bg-gray-lighter">
                    <div class="row">
                    <form id="validation-form" class="form-label-left mt" method="post"
                      data-parsley-priority-enabled="false"
                      novalidate="novalidate">
                        <fieldset class="mt-lg">
                             <div class="form-group">
                                 <label class="control-label col-sm-3" for="password">
                                     Password
                                 </label>
                                 <div class="col-sm-9">
                                     <input type="password" id="password" name="password" class="form-control mb-sm"
                                            data-parsley-trigger="change"
                                            data-parsley-minlength="6"
                                            placeholder="비밀번호"
                                            required="required">
                                 </div>
                             </div>
                     </fieldset>
                     <div class="modal-footer form-actions">
                   <button type="button" class="btn btn-gray" data-dismiss="modal">Close</button>
                   <button type="submit" class="btn btn-success">Confirm</button>
               </div>
                     </form>
                    </div>
            </div>
        </div>
    </div>
</div>
<!-- 모달 수정 비번확인 -->

<!-- 모달 -->
<div class="modal fade" id="myModal_mod" tabindex="-1" role="dialog" aria-labelledby="myModal_mod" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-align-center fw-bold mt" id="myModalLabel18">스터디게시판 글수정</h4>
                <p class="text-align-center fs-mini text-muted mt-sm">
                    	스터디 게시판입니다. 친구들과 스터디를 맺어 보세요.
                </p>
            </div>
            <div class="modal-body bg-gray-lighter">
                    <div class="row">
                    <form id="validation-form" class="form-label-left mt" method="post"
                      data-parsley-priority-enabled="false"
                      novalidate="novalidate">
                        <fieldset>
                         <div class="form-group">
                                <label class="control-label col-sm-4" for="number">
                                    	스터디 인원
                                </label>
                                <div class="col-sm-8">
                                    <input type="text" id="number" name="number" class="form-control"
                                           data-parsley-type="number"
                                           required="required">
                                </div>
                            </div>
                            <!-- 날짜 선택 -->
                         <div class="form-group">
                             <label class="control-label col-sm-4" for="datepicker2i">
                                 	스터디 시작일
                             </label>
                             <div id="datetimepicker1" class="col-sm-8">
                                 <input id="datepicker2i" type="text" class="form-control" />
                             </div>
                         </div>
                         <div class="form-group">
                             <label class="control-label col-sm-4" for="datepicker2ii">
                                 	스터디 종료일
                             </label>
                             <div id="datetimepicker2" class="col-sm-8">
                                 <input id="datepicker2ii" type="text" class="form-control" />
                             </div>
                         </div>
                        	<div class="form-group">
                        		<label class="col-sm-4 control-label" for="country-select">위치</label>
                                <div class="col-sm-8">
                                    <input type="text" id="title" name="title" class="form-control" placeholder="스터디 모임 장소를 적어주세요"
                                    	data-parsley-trigger="change"
                              	data-parsley-maxlength="35"
                                     	required="required">
                                </div>
                            </div>
                            <!-- 다중필터 -->
                            <div class="form-group">
                             <label class="col-sm-4 control-label" for="multiple-select">
                                 	모임 요일 선택
                                 <span class="help-block">해당되는 모든항목을 선택해주세요</span>
                             </label>
                             <div class="col-sm-8">
                                 <select multiple
                                         data-placeholder="Multiple countries this time"
                                         data-minimum-results-for-search="10"
                                         tabindex="-1"
                                         class="select2 form-control" id="multiple-select">
                                     <option value="월">월</option>
                                     <option value="화">화</option>
                                     <option value="수">수</option>
                                     <option value="목">목</option>
                                     <option value="금">금</option>
                                     <option value="토">토</option>
                                     <option value="일">일</option>
                                 </select>
                             </div>
                         </div>
                         </fieldset>
                         <fieldset>
                        	<div class="form-group">
                                <div class="col-sm-12">
                                    <input type="text" id="title" name="title" class="form-control"
                                           placeholder="제목" required="required">
                                </div>
                            </div>
                            <div class="form-group">    
                          <div class="col-md-12">
                              <textarea rows="20" id="wysiwyg" name="content" class="form-control" 
                                  data-parsley-trigger="change"
                                  data-parsley-minlength="20"
                                  required="required"></textarea>
                          </div>
                         </div>
                        </fieldset>
                        <fieldset class="mt-lg">
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
                            <!--  <div class="form-group">
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
                             </div> -->
                     </fieldset>
                     <div class="modal-footer form-actions">
                   <button type="button" class="btn btn-gray" data-dismiss="modal">Close</button>
                   <button type="button" class="btn btn-success">Save changes</button>
               </div>
                     </form>
                    </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

	var wuser_seq = $("#stu_wuser_seq").attr("idx");
	var user_seq = $("#stu_user_seq").attr("idx");
    	
    	$("#stu_delete_btn").on("click",function(){
			var stu_seq = $(this).attr("idx");	
	    	if(user_seq == wuser_seq){
	    	$.ajax({
				url:"./open_study_delete_ok.do",
				type:"post",
				data:{
					stu_seq:stu_seq
				},
				dataType:"json",
				success:function(json){
						console.log(json);
						alert("글삭제성공");
						location.href ="./open_study.do";
				}
    		});
	    	}else if(user_seq != wuser_seq){
				alert("작성자가 아닙니다.");
			}
    	}); 
    	
    	$("stu_modify_btn").on("click",function(){
    		
    	});
    </script>
    </main>
</div>

<!-- The Loader. Is shown when pjax happens -->
<div class="loader-wrap hiding hide">
    <i class="fa fa-circle-o-notch fa-spin-fast"></i>
</div>

<!-- common libraries. required for every page-->
<script src="vendor/jquery/dist/jquery.min.js"></script>
<script src="vendor/jquery-ui/jquery-ui.min.js"></script>
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
<script src="vendor/parsleyjs/dist/parsley.js"></script> <!-- parsley 내용 한글로 고침 -->
<script src="vendor/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
<script src="vendor/bootstrap-sass/assets/javascripts/bootstrap/modal.js"></script>
<script src="vendor/jquery-autosize/jquery.autosize.min.js"></script>
<script src="vendor/bootstrap3-wysihtml5/lib/js/wysihtml5-0.3.0.min.js"></script>
<script src="vendor/bootstrap3-wysihtml5/src/bootstrap3-wysihtml5.js"></script>
<script src="vendor/select2/select2.min.js"></script>
<script src="vendor/moment/min/moment.min.js"></script>
<script src="vendor/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<!-- page specific js -->
<script src="js/open_study_view.js"></script>
 
</body>
</html>