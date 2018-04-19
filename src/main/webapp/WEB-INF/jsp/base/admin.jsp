<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%  
   String path = request.getContextPath();  
   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ADMIN PAGE</title>

<link href="<%=basePath %>/static/jquery-easyui-1.5/themes/default/easyui.css" rel="stylesheet" />
<link href="<%=basePath %>/static/jquery-easyui-1.5/themes/icon.css" rel="stylesheet" />
<script src="<%=basePath %>/static/jquery-easyui-1.5/jquery.min.js"></script>
<script src="<%=basePath %>/static/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<link rel="stylesheet" href="<%=basePath %>/CSS/header.css">
 <link rel="stylesheet" href="<%=basePath %>/CSS/footer.css">	
 
 <style>
 	*{margin:0;padding:0;}
 	
 	.left{
 		height:600px;
 		width:180px;
 		float:left;
 		background-color:red;
 	}
 	.left>ul{
 		margin-left:45px;
 		margin-top:120px;
 		list-style-type:none;
 	}
 	.left>ul>li{
 		margin-top:25px;
 	}
 	.left>ul>li>a{
 		width:108px;
 		text-decoration:none;
 		color:white;
 		border:2px solid white;
 		border-radius:5px;
 		font-family:'楷体';
 		font-size:20px;
 	}
 	
 	.right{
 		height:auto;
 	}
 	.right>.notice{
 	}
 	.right>.notice>.notice_header{
 		float:left;
 	}
 	.right>.notice>.notice_header>textarea{
 		margin:0;
 		float:left;
 		overflow-y:auto;
 		border:1px solid blue;
 		border-radius:3px;
 		font-size:16px;
 	}
 	.right>.notice>.notice_header>a{
 		float:left;
 		width:135px;
	 	text-decoration:none;
		color: black;
		font-weight:blod;
		padding-top:3px;
		border-radius:8px;
		border-style:solid;
		border-color:gray;
		background-color:#ff8080;
		display:block;
		text-align:center;
		margin-top:36px;
		margin-left:6px;
 	}
 	.right>.notice>.notice_content{
 		margin-top:20px;
 		padding:0;
 	}
 	.right>.notice>.notice_content>table{
 		border-collapse:collapse;
 		width:1100px;
 		margin-top:20px;
 	}
 	.right>.notice>.notice_content>table tr{
 		padding-top:5px;
 	}
 	.right>.notice>.notice_content>table tr td{
 		border-bottom:1px solid #dedede;
 		margin-top:5px;
 	}
 	
 	.right>.notice>.notice_content>table tr td a{
 		text-decoration:none;
	 	margin-left:10px;
	} 	
 	
 	.user{
 		margin-top:20px;
 		font-size:18px;
 	}
 	.user>.showAlluser{
 		height:auto;
 	}
 	.user>.showAlluser>table{
 		width:1000px;
 		text-align:center;
 		border-collapse:collapse;
 		
 	}
 	.user>.showAlluser>table tr td{
 		border-bottom:1px solid #dedede;
 	}
 	
 </style>
 
 <script>
 	
 	/* 添加通告 ：由于是get请求，需要额外处理编码， request以及spring的编码只对post请求有效*/
<%--  window.location.href="<%=request.getContextPath() %>/notice/addNotice.do?content="+encodeURI(encodeURI(content)); --%>
 	 function addNotice(){
 		var content=$("#notice_content_input").val();
 		alert(content);
 		if(content.length == 0){
 			alert("警示,内容不能为空");
 		}else{
		  window.location.href="<%=request.getContextPath() %>/notice/addNotice.do?content="+encodeURI(encodeURI(content)); 
 		}
 	 } 
 	
 	
 	/* 删除通告 */
 	function deleteNotice(noteid){
		window.location.href="<%=request.getContextPath() %>/notice/deleteNotice.do?id="+noteid;
 	}
 	
 	/*通告管理的JS*/
 	function NoticeManager(){
 		$("#usercss").css('display','none'); 
 		$("#noticecss").css('display','block'); 
 	}
 	
 	
 	/*用户管理的JS  */
 	function UserManager(){
 		$("#noticecss").css('display','none'); 
 		$("#usercss").css('display','block'); 
 	}
 	
 </script>
</head>
<body>
	<div class="admin"><!-- 最大的div开头 -->
		<!-- 头部信息 导航条 -->  
	<div class="header">
			<div class="header_left">
				<img src="<%=request.getContextPath() %>/CSS/images/header_logo1.png">
				<span id="header_login" onclick="toLogin()" style="padding:0;width:30px;color:red;margin-top:-5px;">
				<c:choose>
					<c:when test="${person.username == '' || person.username == null }">
						登錄
					</c:when>
					<c:otherwise>
						${person.username }	
					</c:otherwise>
				</c:choose>
				</span>
			</div>
			
			<div class="header_center">
				<ul>
					<li><a href="<%=request.getContextPath() %>/toIndex.do">首页</a></li>
					<li><a href="<%=request.getContextPath() %>/toNote.do">笔记共享</a></li>
					<li><a href="<%=request.getContextPath() %>/toMeeting.do">会议记录</a></li>
					<li><a href="<%=request.getContextPath() %>/toPlan.do">每日计划</a></li>
					<li><a href="<%=request.getContextPath() %>/toMail.do">邮件</a></li>
					<c:if test="${admin!=null }">
						<li><a href="<%=request.getContextPath() %>/toAdmin.do">用户管理</a></li>
					</c:if>
				</ul>
			</div>
			
			<div class="header_right">
				<div class="header_right_search">
					<input name="search" class="search_text" type="text" placeholder="请输入搜索条件…">
					<button class="search_label"><img src="<%=request.getContextPath() %>/CSS/images/search_logo.png"></button>
					<div class="search_page"  id="search_page">
					</div>
				</div>
				<div class="header_right_wechat">
					<a href="" ><img src='<%=request.getContextPath() %>/CSS/images/wx_logo.png'></a>
					<div class="wechat_page"  id="wechat_page">
					</div>
				</div>
				<div class="header_right_twtieer">
					<a href="" ><img src='<%=request.getContextPath() %>/CSS/images/wb_logo.png'></a>
					<div class="twtieer_page"  id="twtieer_page">
					</div>
				</div>
			</div>
		</div>
		<!-- 头部信息结尾 导航条结束 -->
		
		<!-- 左侧显示条目，右侧显示条目对应的信息  用户管理和通告管理 -->
		<div class="left">
			<ul>
				<li><a href="<%=request.getContextPath() %>/notice/toAdmin.do" onclick="NoticeManager()">通告管理</a></li>
				<li><a href="<%=request.getContextPath() %>/notice/toUsers.do" onclick="UserManager()">用户管理</a></li>
			</ul>
		</div>
		
		<!-- 这里显示条目对应的详情 -->
		<div class="right">
			<!-- 通告管理的详情 -->
			<div class="notice" id="noticecss" >
				
		       <div class="notice_header">
		       		
		       		  <textarea rows="6" cols="118" id="notice_content_input"></textarea>
		       		  <a href="javascript:void(0);" onclick="addNotice()">发布新通告</a>
		       </div>
		       <br><br>
		       <div class="notice_content" >
		       <br><br>
		       		<table>
		       		<c:forEach var="notice" items="${allNotice }">
		       			<tr>
		       				<td width="60%"  >
		       					<a href="javascript:void(0);" title="${notice.content}" style="margin-left:20px;">
		       						<c:choose>
										<c:when test="${fn:length(notice.content) le 60}">
											${notice.content }</td>
										</c:when>
										<c:otherwise>
											${fn:substring(notice.content, 0, 60)   }...
										</c:otherwise>
									</c:choose>
		       					</a>
		       				</td>
		       				<td width="28%" ><fmt:formatDate value="${notice.createtime }" pattern="yyyy年MM月dd日   HH：mm：ss"/></td>
		       				<td width="12%" >
		       					<%-- <a href="javascript:void(0);" onclick="editNotice(${notice.id})" >修改</a> --%>
		       		  			<a href="javascript:void(0);" onclick="deleteNotice(${notice.id})">删除</a>
		       		  		</td>
		       			</tr>
		       		</c:forEach>
		       			
		       		</table>
		       </div>     
		       
		       <!-- 用户管理的详情 -->
			<div class="user"  id="usercss">
				<div class="showAlluser">
					<table>
						<tr>
							<th width="20%">用户账号</th>
							<th width="20%">用户昵称</th>
							<th width="20%">用户密码</th>
							<th width="20%">用户身份</th>
							<th width="20%">操作</th>
						</tr>
						
						<c:forEach var="person" items="${allPerson }">
						<tr>
							<td id="usernum" width="20%">${person.usernum }</td>
							<td id="username" width="20%">${person.username }</td>
							<td id="userpassword" width="20%">${person.password }</td>
							<td id="useridentity" width="20%">
								<c:if test="${person.identity == 1 }"> 
									普通用户
								</c:if>
								<c:if test="${person.identity == 2 }"> 
									企业用户
								</c:if>
								<c:if test="${person.identity == 3 }"> 
									系统管理员
								</c:if>
							</td>
							<td><a href="<%=request.getContextPath() %>/notice/deleteUser.do?id=${person.id }" width="20%">删除</a></td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
			</div>
			
			<!-- 用户管理的详情 -->
			<div class="user" style="display:none;" id="usercss">
				<div class="showAlluser">
					<table>
						<tr>
							<th>用户账号</th>
							<th>用户昵称</th>
							<th>用户密码</th>
							<th>用户身份</th>
							<th>操作</th>
						</tr>
						
						<c:forEach var="person" items="${allPerson }">
						<tr>
							<td id="usernum">${person.usernum }</td>
							<td id="username">${person.username }</td>
							<td id="userpassword">${person.password }</td>
							<td id="useridentity">
								<c:if test="${person.identity == 1 }"> 
									普通用户
								</c:if>
								<c:if test="${person.identity == 2 }"> 
									企业用户
								</c:if>
								<c:if test="${person.identity == 3 }"> 
									系统管理员
								</c:if>
							</td>
							<td><a href="" >删除</a></td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		
		<!-- 脚注 -->
		<!-- <div class="footer">
			<hr>
			<ul>
				<li><a href="">网站声明</a></li>
				<li><a href="">服务网点</a></li>
				<li><a href="">网站地图</a></li>
				<li><a href="">联系我司</a></li>
				<li>服务热线8008088020</li>
			</ul>
			<img src="images/footer.jpg" alt="">
			<span>笔记分享会议记录系统版权所有 联系站点100201 </span>
		</div> -->
</div><!-- 最大的div end -->

<%-- <!-- 添加新通告的弹窗 -->
<div id="win_addNotice" name="win" class="easyui-window" closed="true" title="添加新通告" 
   	iconCls="icon-add" data-options="iconCls:'icon-save',modal:true" 
   	style="overflow-y:hidden;width:892px;height:518px;overflow-x:hidden;top:52px;left:259px;" > 
   	<form action="<%=request.getContextPath() %>/notice/addNotice.do" method="post"  class="addNoticeForm" id="addNoticeForm">
   		<label style="float:left;margin-top:10px;">笔记内容：</label><textarea id="addContent"  name="addContent" rows="20" cols="64"  style="float:left;margin-left:-102px;margin-top:12"></textarea>
   		<div class="addnote_button">
			<button class="butn" onclick="addnote_submit()" style="font-size:18px;margin-top:20px;">发送</button>
   			<a href="javascript:void(0);" plain="true" class="easyui-linkbutton" iconCls="icon-cancel" onclick="exit_addnote();" ><span style="font-size:20px;color:white;">退出</span></a>
		</div>
   	</form>
   </div> --%>
</body>
</html>