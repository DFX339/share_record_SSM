<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
   String path = request.getContextPath();  
   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
 %>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>HEADER模板管理</title>
 <link href="<%=basePath %>/static/jquery-easyui-1.5/themes/default/easyui.css" rel="stylesheet" />
 <link href="<%=basePath %>/static/jquery-easyui-1.5/themes/icon.css" rel="stylesheet" />
 <script src="<%=basePath %>/static/jquery-easyui-1.5/jquery.min.js"></script>
 <script src="<%=basePath %>/static/jquery-easyui-1.5/jquery.easyui.min.js"></script>
 <link rel="stylesheet" href="header.css">
<script type="text/javascript">

</script>

</head>

<body>
	
	<div class="mail"><!-- 最大的div开头 -->
		<div class="header">
			<!-- <div style="margin-left:5px;float:left;margin-top:18px;">
			</div> -->
			<div class="header_left">
				<img src="images/header_logo1.png">
				<span id="header_login" onclick="toLogin()" style="padding:0;width:30px;color:red;">登錄</span>
			</div>
			
			<div class="header_center">
				<ul>
					<li><a href="<%=request.getContextPath() %>/index.jsp">首页</a></li>
					<li><a href="person/toNote.do">笔记共享</a></li>
					<li><a href="person/toMeeting.do">会议记录</a></li>
					<li><a href="person/toPlan.do">每日计划</a></li>
					<li><a href="person/toMail.do">邮件</a></li>
				</ul>
			</div>
			
			<div class="header_right">
				<div class="header_right_search">
					<input name="search" class="search_text" type="text" placeholder="请输入搜索条件…">
					<button class="search_label"><img src="images/search_logo.png"></button>
					<div class="search_page"  id="search_page">
					</div>
				</div>
				<div class="header_right_wechat">
					<a href="" ><img src='images/wx_logo.png'></a>
					<div class="wechat_page"  id="wechat_page">
					</div>
				</div>
				<div class="header_right_twtieer">
					<a href="" ><img src='images/wb_logo.png'></a>
					<div class="twtieer_page"  id="twtieer_page">
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>