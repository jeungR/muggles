<%@page import="java.util.ArrayList"%>
<%@page import="model1.Class1_Question_BoardDAO"%>
<%@page import="model1.Class1_Question_BoardTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.io.File" %>

<%@ page import="java.sql.Connection" %>    
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="javax.sql.DataSource" %>

<%@ page import="java.util.Iterator" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="model1.MemberTO" %>
<%@ page import="org.json.simple.JSONObject" %>
<%


    //request.setCharacterEncoding("utf-8");
	
	
	
	//String cpage = (String)request.getAttribute("cpage");    
    Class1_Question_BoardTO to = (Class1_Question_BoardTO)request.getAttribute("to");
    
	String seq = to.getSeq();
	System.out.println("class 1view.jsp = "+ to.getSeq());
    String header1 = to.getHeader1();
    String header2 = to.getHeader2();
    String title =to.getTitle();
    String writer = to.getWriter();
    String wdate = to.getWdate();
    String password = to.getPassword();
    String hit = to.getHit();
    String content = to.getContent();
    String photo1 = to.getPhoto1();
     
    %>


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
        <ol class="breadcrumb hidden-print">
            <li>YOU ARE HERE</li>
            <li class="active">질문게시판</li>
        </ol>
        <h1 class="page-title hidden-print">Closed - <span class="fw-semi-bold">Question</span></h1>
        <div class="row">
        	<!-- 뒤로가기 버튼 -->
        	<div class="col-md-12 hidden-print" style="height:35px;">
        		<a class="btn btn-default btn-sm width-50 pull-left" id="back-btn" href="close_question.html">
                    <i class="fa fa-angle-left fa-lg"></i>
                </a>
            </div>
            <div class="col-md-8">
            	<!-- 게시판 글 내용 (인쇄가능 영역) -->
                <section class="widget widget-invoice">
                    <header>
                        <div class="row">
                            <div class="col-sm-9 col-print-9">
                                <span class="icon fa-2x"><i class="glyphicon glyphicon-th-list"></i> </span><span class="fa-lg">javascript 현재 나의 위치를 알고 싶을때 쓰는 코드를 까먹었어요</span>
                            </div>
                            <div class="col-sm-3 col-print-3">
                                <h4 class="text-align-right">
                                    #<span class="fw-semi-bold">1</span> / <small>박주환</small>
                                </h4>
                                <div class="text-muted fs-larger text-align-right">
                                    2016.09.30
                                </div>
                            </div>
                        </div>
                    </header>
                    <div class="widget-body">
                        <!-- 질문글 정보 -->
                        <div class="row mb-lg">
                            <section class="col-sm-12 col-print-12">
                                <h4 class="text-muted no-margin mb-sm">질문글 정보</h4>
                                <address>
                                    <strong><i class="glyphicon glyphicon-usd mb-xs"></i> 답변상태 : 답변완료</strong><br>
                                    <i class="glyphicon glyphicon-asterisk mb-xs"></i> 주제 : 수업<br>
                                    <i class="fa fa-language mb-xs"></i> 언어 : javascript<br>
                                    <i class="glyphicon glyphicon-paperclip"></i>첨부파일 : <a href="#">file.txt</a>
                                </address>
                            </section>
                        </div>
                        <div class="row">
                        <section>
                        	<div class="col-sm-12 col-print-12">
                                <!-- 글내용이 들어가는 부분 -->
                                <p>제곧내</p>
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
                            <button class="btn btn-danger" data-toggle="modal" data-target="#myModal_del_pw"><!-- 클릭시 모달 -->
                                	글삭제
                                &nbsp;
                                <span class="circle bg-white">
                                    <i class="fa fa-trash-o text-danger"></i>
                                </span>
                            </button>
                        </div>
                    </div>
                </section>
                <!-------- 답글쓰기 버튼 --------->
                <div class="btn-toolbar mt-lg text-align-right hidden-print">
					<button class="btn btn-success"><!-- 질문자에게만 보이게, 답변완료를 하면 버튼 사라지게 해야함 -->
                        <i class="fa fa-check"></i>
                        &nbsp;&nbsp;
                        	답변완료 전환
                    </button>
					<button class="btn btn-sm btn-inverse" data-toggle="modal" data-target="#myModal_reply"><!-- 클릭시 모달 -->
					    <i class="fa fa-check"></i>
					    &nbsp;&nbsp;
					    	답글 쓰기
					</button>
				</div>
				<!-------- 답글 --------->
                <section>
                	<div class="panel-group mb-lg" id="accordion" data-toggle="collapse">
	                    <!-- 답글 한개 시작 -->
	                    <div class="panel panel-default">
	                        <div class="panel-heading">
	                            <h5 class="panel-title">
	                                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
	                                    	내공 냠냠
	                                    <span class="label label-success">채택 됨</span>
	                                    <i class="fa fa-angle-down pull-right"></i>
	                                </a>
	                            </h5>
	                        </div>
	                        <div id="collapseOne" class="panel-collapse collapse in">
	                            <div class="panel-body bg-white">
	                                <!-- 답글 내용이 오는 부분 -->
	                                Get base styles and flexible support for collapsible components like accordions and navigation.
	                                Using the collapse plugin, we built a simple accordion by extending the panel component.
		                            
		                            <div class="btn-toolbar mt-lg text-align-right hidden-print">
			                            <button id="choosed" class="btn btn-sm btn-success"><!-- 답변완료를 하면 버튼 사라지게 해야함 -->
			                                <i class="fa fa-check"></i>
			                                &nbsp;&nbsp;
			                                	답변 채택
			                            </button>
		                            </div>
	                            </div>
	                        </div>
	                    </div>
	                    <!--  -->
	                    <div class="panel panel-default">
	                        <div class="panel-heading collapsed">
	                            <h5 class="panel-title">
	                                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
	                                    	그거 이렇게 하면됨
	                                    <i class="fa fa-angle-down pull-right"></i>
	                                </a>
	                            </h5>
	                        </div>
	                        <div id="collapseTwo" class="panel-collapse collapse">
	                            <div class="panel-body bg-white">
	                                <p>Why don't use Lore Ipsum? I think if some one says don't use lore ipsum it's very
	                                    controversial point. I think the opposite actually. Everyone knows what is lore ipsum
	                                    - it is easy to understand if text is lore ipsum. You'll automatically skip -
	                                    because you know - it's just non-informative stub. But what if there some text like
	                                    this one? You start to read it! But the goal of this text is different. The goal is
	                                    the example. So a bit of Lore Ipsum is always very good practice. Keep it in mind!</p>
	                                    
	                                <div class="btn-toolbar mt-lg text-align-right hidden-print">
			                            <button id="choosed" class="btn btn-sm btn-success"><!-- 답변완료를 하면 버튼 사라지게 해야함 -->
			                                <i class="fa fa-check"></i>
			                                &nbsp;&nbsp;
			                                	답변 채택
			                            </button>
		                            </div>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="panel panel-default">
	                        <div class="panel-heading">
	                            <h5 class="panel-title">
	                                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
	                                   	 구글한테 물어보셈 ㅋㅋㅋ
	                                    <i class="fa fa-angle-down pull-right"></i>
	                                </a>
	                            </h5>
	                        </div>
	                        <div id="collapseThree" class="panel-collapse collapse">
	                            <div class="panel-body bg-white">
	                                Why don't use Lore Ipsum? I think if some one says don't use lore ipsum it's very controversial point. I think the opposite actually.
	                                
	                                <div class="btn-toolbar mt-lg text-align-right hidden-print">
			                            <button id="choosed" class="btn btn-sm btn-success"><!-- 답변완료를 하면 버튼 사라지게 해야함 -->
			                                <i class="fa fa-check"></i>
			                                &nbsp;&nbsp;
			                                	답변 채택
			                            </button>
		                            </div>
	                            </div>
	                        </div>
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
		                <h4 class="modal-title text-align-center fw-bold mt" id="myModalLabel18">반별 질문게시판 글삭제</h4>
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
		<div class="modal fade" id="myModal_mod_pw" tabindex="-1" role="dialog" aria-labelledby="myModal_mod_pw" aria-hidden="true">
		    <div class="modal-dialog modal-sm">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title text-align-center fw-bold mt" id="myModalLabel18">반별 질문게시판 글수정</h4>
		                <p class="text-align-center fs-mini text-muted mt-sm">
		                    	비밀번호를 입력하세요
		                </p>
		            </div>
		            <div class="modal-body bg-gray-lighter">
		                    <div class="row">
		                    <form id="validation-form2" class="form-label-left mt" method="post"
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
		                   <button type="submit" class="btn btn-success" onclick="$('#myModal_mod_pw').modal('hide'); $('#myModal_mod').appendTo('main').modal('show');">Confirm</button><!-- 클릭시 모달 -->
		               </div>
		                     </form>
		                    </div>
		            </div>
		        </div>
		    </div>
		</div>
		<!-- 모달 수정 -->
		<div class="modal fade" id="myModal_mod" tabindex="-1" role="dialog" aria-labelledby="myModal_mod" aria-hidden="true">
		    <div class="modal-dialog modal-lg">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title text-align-center fw-bold mt" id="myModalLabel18">반별 질문게시판 글쓰기</h4>
		                <p class="text-align-center fs-mini text-muted mt-sm">
		                    	반별 질문게시판입니다. 수업에 관련된 질문과 반별문의사항 등을 올려주세요
		                </p>
		            </div>
		            <div class="modal-body bg-gray-lighter">
		                    <div class="row">
		                    <form id="validation-form" class="form-label-left mt" enctype="multipart/form-data" method="post"
		                      data-parsley-priority-enabled="false"
		                      novalidate="novalidate">
		                        <fieldset>
		                         <div class="form-group">
		                             <label class="col-sm-4 control-label" for="default-select">분류</label>
		                             <div class="col-sm-8">
		                                 <select data-placeholder="주제를 정해주세요"
		                                         data-width="auto"
		                                         data-minimum-results-for-search="10"
		                                         tabindex="-1"
		                                         required="required"
		                                         class="select2 form-control" id="default-select">
		                                     <option value=""></option>
		                                     <option value="수업관련">수업관련</option>
		                                   		<option value="기타">기타</option>
		                                 </select>
		                             </div>
		                         </div>
		                         <div class="form-group">
		                            <label class="col-sm-4 control-label" for="country-select"></label>
		                            <div class="col-sm-8">
		                                <select id="country-select"
		                                        data-placeholder="프로그래밍 언어를 선택해주세요"
		                                        class="select2 form-control"
		                                        tabindex="-1"
		                                        name="country">
		                                    <option value=""></option>
		                                    <option value="etc..">etc..</option>
		                                    <option value="ABAP">ABAP</option>
											<option value="ABC">ABC</option>
											<option value="ActionScript">ActionScript</option>
											<option value="Ada">Ada</option>
											<option value="Agilent%20VEE">Agilent VEE</option>
											<option value="ALGOL">Algol</option>
											<option value="Alice">Alice</option>
											<option value="Angelscript">Angelscript</option>
											<option value="Apex">Apex</option>
											<option value="APL">APL</option>
											<option value="AppleScript">AppleScript</option>
											<option value="Arc">Arc</option>
											<option value="Arduino">Arduino</option>
											<option value="ASP">ASP</option>
											<option value="AspectJ">AspectJ</option>
											<option value="Assembly_language">Assembly</option>
											<option value="ATLAS">ATLAS</option>
											<option value="Augeas">Augeas</option>
											<option value="AutoHotkey">AutoHotkey</option>
											<option value="AutoIt">AutoIt</option>
											<option value="AutoLISP">AutoLISP</option>
											<option value="Automator">Automator</option>
											<option value="Avenue">Avenue</option>
											<option value="Awk">Awk</option>
											<option value="Bash">Bash</option>
											<option value="Visual_basic">Visual_Basic</option>
											<option value="bc">bc</option>
											<option value="BCPL">BCPL</option>
											<option value="BETA">BETA</option>
											<option value="BlitzMax">BlitzMax</option>
											<option value="Boo">C#</option>
											<option value="C++">C++</option>
											<option value="C++/CLI">C++/CLI</option>
											<option value="C-Omega">C-Omega</option>
											<option value="Caml">Caml</option>
											<option value="Ceylon_Project">Ceylon</option>
											<option value="CFML">CFML</option>
											<option value="Cg">cg</option>
											<option value="Ch">Ch</option>
											<option value="CHILL">CHILL</option>
											<option value="CIL">CIL</option>
											<option value="CL">CL</option>
											<option value="Clarion">Clarion</option>
											<option value="Clean">Clean</option>
											<option value="Clipper">Clipper</option>
											<option value="Clojure">Clojure</option>
											<option value="CLU">CLU</option>
											<option value="COBOL">COBOL</option>
											<option value="Cobra">Cobra</option>
											<option value="CoffeeScript">CoffeeScript</option>
											<option value="ColdFusion">ColdFusion</option>
											<option value="COMAL">COMAL</option>
											<option value="Common%20Lisp">Common Lisp</option>
											<option value="Coq">Coq</option>
											<option value="cT">cT</option>
											<option value="Curl">Curl</option>
											<option value="D">D</option>
											<option value="Dart">Dart</option>
											<option value="DCL">DCL</option>
											<option value="DCPU-16%20ASM">DCPU-16 ASM</option>
											<option value="Object_Pascal">Object_Pascal</option>
											<option value="Dibol">DiBOL</option>
											<option value="Dylan">Dylan</option>
											<option value="E">E</option>
											<option value="eC">eC</option>
											<option value="Ecl">Ecl</option>
											<option value="ECMAScript">ECMAScript</option>
											<option value="EGL">EGL</option>
											<option value="Eiffel">Eiffel</option>
											<option value="Elixir">Elixir</option>
											<option value="Emacs%20Lisp">Emacs Lisp</option>
											<option value="Erlang">Erlang</option>
											<option value="Etoys">Etoys</option>
											<option value="Euphoria">Euphoria</option>
											<option value="EXEC">EXEC</option>
											<option value="F_Sharp">F#</option>
											<option value="Factor">Factor</option>
											<option value="Falcon">Falcon</option>
											<option value="Fancy">Fancy</option>
											<option value="Fantom">Fantom</option>
											<option value="Felix">Felix</option>
											<option value="Forth">Forth</option>
											<option value="Fortran">Fortran</option>
											<option value="Fortress">Fortress</option>
											<option value="Visual_FoxPro">Visual_FoxPro</option>
											<option value="Gambas">Gambas</option>
											<option value="GNU%20Octave">GNU Octave</option>
											<option value="Go">Go</option>
											<option value="Google_AppsScript">Google_AppsScript</option>
											<option value="Gosu">Gosu</option>
											<option value="Groovy">Groovy</option>
											<option value="Haskell">Haskell</option>
											<option value="haXe">haXe</option>
											<option value="Heron">Heron</option>
											<option value="HPL">HPL</option>
											<option value="HyperTalk">HyperTalk</option>
											<option value="Icon">Icon</option>
											<option value="IDL">IDL</option>
											<option value="Inform">Inform</option>
											<option value="Informix-4GL">Informix-4GL</option>
											<option value="INTERCAL">INTERCAL</option>
											<option value="Io">Io</option>
											<option value="Ioke">Ioke</option>
											<option value="J">J</option>
											<option value="J_Sharp">J#</option>
											<option value="JADE">JADE</option>
											<option value="Java">Java</option>
											<option value="JavaFX_Script">Java FX Script</option>
											<option value="JavaScript">JavaScript</option>
											<option value="JScript">JScript</option>
											<option value="JScript.NET">JScript.NET</option>
											<option value="Julia">Julia</option>
											<option value="Korn%20Shell">Korn Shell</option>
											<option value="Kotlin">Kotlin</option>
											<option value="LabVIEW">LabVIEW</option>
											<option value="Ladder_logic">Ladder Logic</option>
											<option value="Lasso">Lasso</option>
											<option value="Limbo">Limbo</option>
											<option value="Lingo">Lingo</option>
											<option value="Lisp">Lisp</option>
											<option value="Logo">Logo</option>
											<option value="Logtalk">Logtalk</option>
											<option value="LotusScript">LotusScript</option>
											<option value="LPC">LPC</option>
											<option value="Lua">Lua</option>
											<option value="Lustre">Lustre</option>
											<option value="M4">M4</option>
											<option value="MAD">MAD</option>
											<option value="MEDITECH">Magic</option>
											<option value="Magik">Magik</option>
											<option value="Malbolge">Malbolge</option>
											<option value="Cincom">MANTIS</option>
											<option value="Maple">Maple</option>
											<option value="Mathematica">Mathematica</option>
											<option value="MATLAB">MATLAB</option>
											<option value="Max/MSP">Max/MSP</option>
											<option value="Maxscript">MAXScript</option>
											<option value="MEL">MEL</option>
											<option value="Mercury">Mercury</option>
											<option value="Mirah">Mirah</option>
											<option value="MIVA_Script">Miva</option>
											<option value="ML">ML</option>
											<option value="Monkey">Monkey</option>
											<option value="Modula-2">Modula-2</option>
											<option value="Modula-3">Modula-3</option>
											<option value="MOO">MOO</option>
											<option value="Moto">Moto</option>
											<option value="MS-DOS_Batch">MS-DOS_Batch</option>
											<option value="MUMPS">MUMPS</option>
											<option value="NATURAL">NATURAL</option>
											<option value="Nemerle">Nemerle</option>
											<option value="Nimrod">Nimrod</option>
											<option value="NQC">NQC</option>
											<option value="NSIS">NSIS</option>
											<option value="Nu">Nu</option>
											<option value="NXT-G">NXT-G</option>
											<option value="Oberon">Oberon</option>
											<option value="Object%20Rexx">Object Rexx</option>
											<option value="Objective-C">Objective-C</option>
											<option value="Objective-J">Objective-J</option>
											<option value="OCaml">OCaml</option>
											<option value="Occam">Occam</option>
											<option value="ooc">ooc</option>
											<option value="Opa">Opa</option>
											<option value="OpenCL">OpenCL</option>
											<option value="OpenEdge%20ABL">OpenEdge ABL</option>
											<option value="OPL">OPL</option>
											<option value="Oz">Oz</option>
											<option value="Paradox">Paradox</option>
											<option value="Parrot">Parrot</option>
											<option value="Pascal">Pascal</option>
											<option value="Perl">Perl</option>
											<option value="PHP">PHP</option>
											<option value="Pike">Pike</option>
											<option value="PILOT">PILOT</option>
											<option value="PL/I">PL/I</option>
											<option value="PL/SQL">PL/SQL</option>
											<option value="Pliant">Pliant</option>
											<option value="PostScript">PostScript</option>
											<option value="POV-Ray">POV-Ray</option>
											<option value="PowerBasic">PowerBasic</option>
											<option value="PowerBuilder">PowerScript</option>
											<option value="PowerShell">PowerShell</option>
											<option value="Processing">Processing</option>
											<option value="Prolog">Prolog</option>
											<option value="Puppet">Puppet</option>
											<option value="Pure%20Data">Pure Data</option>
											<option value="Python">Python</option>
											<option value="Q">Q</option>
											<option value="R">R</option>
											<option value="Racket">Racket</option>
											<option value="REALBasic">REALBasic</option>
											<option value="REBOL">REBOL</option>
											<option value="Revolution">Revolution</option>
											<option value="REXX">REXX</option>
											<option value="IBM_RPG">RPG (OS/400)</option>
											<option value="Ruby">Ruby</option>
											<option value="Rust">Rust</option>
											<option value="S">S</option>
											<option value="S-PLUS">S-PLUS</option>
											<option value="SAS_language">SAS</option>
											<option value="Sather">Sather</option>
											<option value="Scala">Scala</option>
											<option value="Scheme">Scheme</option>
											<option value="Scilab">Scilab</option>
											<option value="Scratch">Scratch</option>
											<option value="sed">sed</option>
											<option value="Seed7">Seed7</option>
											<option value="Self">Self</option>
											<option value="Unix_shell">Shell</option>
											<option value="SIGNAL">SIGNAL</option>
											<option value="Simula">Simula</option>
											<option value="Simulink">Simulink</option>
											<option value="Slate">Slate</option>
											<option value="Smalltalk">Smalltalk</option>
											<option value="Smarty">Smarty</option>
											<option value="SPARK">SPARK</option>
											<option value="SPSS">SPSS</option>
											<option value="SQR">SQR</option>
											<option value="Squeak">Squeak</option>
											<option value="Squirrel">Squirrel</option>
											<option value="Standard%20ML">Standard ML</option>
											<option value="Suneido">Suneido</option>
											<option value="SuperCollider">SuperCollider</option>
											<option value="TACL">TACL</option>
											<option value="Tcl">Tcl</option>
											<option value="TeX">Tex</option>
											<option value="thinBasic">thinBasic</option>
											<option value="TOM">TOM</option>
											<option value="Transact-SQL">Transact-SQL</option>
											<option value="Turing">Turing</option>
											<option value="TypeScript">TypeScript</option>
											<option value="Vala">Vala</option>
											<option value="Genie">Genie</option>
											<option value="VBScript">VBScript</option>
											<option value="Verilog">Verilog</option>
											<option value="VHDL">VHDL</option>
											<option value="VimL">VimL</option>
											<option value="Visual%20Basic%20.NET">Visual Basic .NET</option>
											<option value="WebDNA">WebDNA</option>
											<option value="Whitespace">Whitespace</option>
											<option value="X10">X10</option>
											<option value="xBase">xBase</option>
											<option value="XBase++">XBase++</option>
											<option value="Xen">Xen</option>
											<option value="XPL">XPL</option>
											<option value="XSLT">XSLT</option>
											<option value="XQuery">XQuery</option>
											<option value="yacc">yacc</option>
											<option value="Yorick">Yorick</option>
											<option value="Z%20shell">Z shell</option>
		                                </select>
		                            </div>
		                        </div>
	                        	<div class="form-group">
	                                <div class="col-sm-12">
	                                    <input type="text" id="title" name="title" class="form-control"
	                                           placeholder="제목" required="required">
	                                </div>
	                            </div>
	                            <div class="form-group">    
		                          <div class="col-md-12">
		                              <textarea rows="20" id="wysiwyg-open-question" name="content" class="form-control" 
		                                  data-parsley-trigger="change"
		                                  data-parsley-minlength="20"
		                                  required="required"></textarea>
		                          </div>
	                         	</div>
		                        </fieldset>
		                        <fieldset>
			                        <legend>
			                             	파일 업로드
			                        </legend>
		                        	<div class="form-group"> 
				                        <div class="col-sm-10 col-sm-offset-1">
			                              	<div class="dropzone" action="#" id="my-awesome-dropzone">
					                            <div id="previewDiv"></div>
											    <div class="fallback">
											          <input name="file" type="file" />
											    </div>
					                            <div class="dz-message">
					                                <p class="mb-xs fw-normal">파일을 이곳에 드롭 하세요</p>
					                                <p class="text-muted fs-mini">(또는 클릭하세요)</p>
					                            </div>
				                        	</div>
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
		<!-- 모달 답글 -->
		<div class="modal fade" id="myModal_reply" tabindex="-1" role="dialog" aria-labelledby="myModal_reply" aria-hidden="true">
		    <div class="modal-dialog modal-lg">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title text-align-center fw-bold mt" id="myModalLabel18">공개 질문게시판 답글</h4>
		            </div>
		            <div class="modal-body bg-gray-lighter">
		                    <div class="row">
		                    <form id="validation-form4" class="form-label-left mt" method="post"
		                      data-parsley-priority-enabled="false"
		                      novalidate="novalidate">
		                        <fieldset>
		                        	<div class="form-group">
		                                <div class="col-sm-12">
		                                    <input type="text" id="title" name="title" class="form-control"
		                                           placeholder="제목" required="required">
		                                </div>
		                            </div>
		                            <div class="form-group">    
		                          <div class="col-md-12">
		                              <textarea rows="20" id="wysiwyg2" name="content" class="form-control" 
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
<script src="vendor/dropzone/dist/min/dropzone.min.js"></script>
<!-- page specific js -->
<script src="js/priv_qna_view.js"></script>
</body>
</html>