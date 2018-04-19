<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%  
   String path = request.getContextPath();  
   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
 %>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>INDEX-/share_record_SSM</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Bootstrap -->
<script src="http://code.jquery.com/jquery.js"></script>
<link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="static/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="static/jquery-easyui-1.5/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="static/jquery-easyui-1.5/themes/icon.css">
<script type="text/javascript" src="static/jquery-easyui-1.5/jquery.min.js"></script>
<script type="text/javascript" src="static/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<link rel="stylesheet" href="CSS/index.css">	
<style>
*{
	margin:0;
	padding:0;
}
/*登录弹窗的css样式*/
.form{
	margin-left:76px;
	margin-top:41px;
}
.form>label{
	font-size:16px;
	color:black;
	font-family:"楷体";
	margin-top:10px;
	margin-left:20px;
}

.form>input{
	margin-left:18px;
	font-size: 16px;
	border-radius:8px;
	font-family:"楷体";
}

.form>.login_button>.butn{
	width:232px;
	height:32px;
	background-color:#3366FF;
	color:white;
	margin-left:46px;
	margin-top:10px;
	text-align:center;
	border-radius:5px;
}

.login_to_regist{
	margin-top:46px;
	font-size:14px;
	color:white;
	height:40px;
	background-color:#D0D0D0;
	overflow-y:hidden;
	font-family:"楷体";
}
.login_to_regist>hr{
	height:1px;
	margin-top:0px;
	background-color:gray;
	font-size:15px;
}
.login_to_regist>.login_bottom_left{
	float:left;
	margin-top:-10px;
}
.login_to_regist>.login_bottom_left>button{
	font-size:18px;
	height:26px;
	width:80px;
	color:white;
	background-color:#3366FF;
	border-radius:5px;
	margin-bottom:2px;
}

.login_to_regist>.login_bottom_right{
	float:right;
	margin-right:10px;
	margin-top:-10px;
}
.login_to_regist>.login_bottom_right>a{
	font-size:18px;
}
.login_to_regist>.login_bottom_right>a:hover{
	color:red;
}

/*注册弹窗的css样式*/

.regist_form{
	margin-left:76px;
	margin-top:45px;
}
.regist_form>label{
	font-size:16px;
	color:black;
	font-family:"楷体";
	margin-top:10px;
	margin-left:20px;
}

.regist_form>input{
	margin-left:18px;
	font-size: 16px;
	border-radius:8px;
	font-family:"楷体";
	width:200px;
}

.regist_form>.regist_button>.butn{
	width:252px;
	height:32px;
	background-color:#3366FF;
	color:white;
	margin-left:36px;
	margin-top:10px;
	text-align:center;
	border-radius:5px;
}

.regist_to_login{
	margin-top:46px;
	font-size:14px;
	color:white;
	height:42px;
	background-color:#D0D0D0;
	overflow-y:hidden;
	font-family:"楷体";
}
.regist_to_login>hr{
	height:1px;
	margin-top:0px;
	background-color:gray;
	font-size:15px;
}
.regist_to_login>.login_bottom_left{
	float:left;
	margin-top:-10px;
}
.regist_to_login>.login_bottom_left>button{
	font-size:18px;
	height:26px;
	width:80px;
	color:white;
	background-color:#3366FF;
	border-radius:5px;
	margin-bottom:2px;
}

.regist_to_login>.login_bottom_right{
	float:right;
	margin-right:10px;
	margin-top:-10px;
}
.regist_to_login>.login_bottom_right>a{
	font-size:18px;
}
.regist_to_login>.login_bottom_right>a:hover{
	color:red;
}
</style>
	
	<script>
	
	$(function() {
		$.ajax({
			url: "<c:url value="toIndex.do"/>",
            type: "POST",
		})
	});
	
	/*设置一启动就开启轮播图，并且每3秒钟换一张图片*/
	$(document).ready(function() {
	    $('#myCarousel').carousel({
	     interval:3000
	    })
	});
		
	</script>
  </head>
  
  <body>
	<div class="index"><!-- 最大的div开头 -->
		<div class="header">
			<!-- <div style="margin-left:5px;float:left;margin-top:18px;">
			</div> -->
			<div class="header_left">
				<img src="images/header_logo1.png">
				<span id="header_login" onclick="toLogin()" style="padding:0;width:30px;color:red;">
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
					<!-- <li><a href="<%=request.getContextPath() %>/index.jsp">首页</a></li> -->
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

		<div class="lunbo">
			<!-- 调用bootstrap的轮播图 -->
			<div id="myCarousel"  class="carousel slide" data-ride="carousel"  >
		      <ol class="carousel-indicators">
		        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		        <li data-target="#myCarousel" data-slide-to="1"></li>
		        <li data-target="#myCarousel" data-slide-to="2"></li>
		      </ol>
		      <!-- Carousel items -->
		      <div class="carousel-inner">
		       	 <div class="item active">
					 <img src="images/lunbo.jpg" alt="" style="width:100%;height:100%;" />
					 <div class="carousel-caption lunbo_text" >贵在坚持</div>      
				 </div>     
		       	 <div class="item">
					 <img src="images/lunbo1.jpg" alt="" style="width:100%;height:100%;" />
					 <div class="carousel-caption lunbo_text">乐观上进</div>      
				 </div>     
		       	 <div class="item">
					 <img src="images/lunbo2.jpg" alt="" style="width:100%;height:100%;" />  
					 <div class="carousel-caption lunbo_text">学无止境</div>    
				 </div>     
		      </div>
		      <!-- Carousel nav -->
		      <a class="carousel-control left" href="#myCarousel" data-slide="prev"><label>&lsaquo;</label></a>
		      <a class="carousel-control right" href="#myCarousel" data-slide="next"><label>&rsaquo;</label></a>
		    </div>
		    
		    <!-- 在轮播图上显示的内容 -->
		   <div class="lunbo_content">
		   		<div class="content_top"><img src="images/lunbo_note.jpg"></div>
		     	 <div class="content_center"><button class="content_button">DOWNLOAD</button></div>
		    	<div class="content_bottom">最新PC版本.</div>
		    </div> 
		</div>
		
		<div class="center">
			<div class="center_left">
				<div class="center_left_one">
					<label>最新公告</label>
					<a href="<%=request.getContextPath() %>/toAdmin.do">更多>></a><hr>
					<table>
					 <c:forEach var="notice" items="${lastestNotice }" > 
						<tr>
							<td>
								<a href="javascript:void(0);" title="${notice.content}" style="margin-left:2px;font-size:16px;">
		       						<c:choose>
										<c:when test="${fn:length(notice.content) le 30}">
											${notice.content }</td>
										</c:when>
										<c:otherwise>
											${fn:substring(notice.content, 0, 30)   }...
										</c:otherwise>
									</c:choose>
		       					</a>
							</td>
							<td><fmt:formatDate value="${notice.createtime }" pattern="yyyy年MM月dd日   HH：mm：ss"/></td>
						</tr>
					 </c:forEach> 
					</table>
				</div>
				
				<div class="center_left_one">
					<label>新鲜笔记</label>
					<a href="<%=request.getContextPath() %>/toNote.do">更多>></a><hr>
					<table>
					<c:forEach var="note" items="${lastestNote }" >
						<tr>
							<td>${note.title }</td>
							<td>
							<a href="javascript:void(0);" title="${note.content}" style="font-size:16px;">
							<c:choose>
								<c:when test="${fn:length(note.content) le 18}">
									${note.content }</td>
								</c:when>
								<c:otherwise>
									${fn:substring(note.content, 0, 18)   }...
								</c:otherwise>
							</c:choose>
							</a>
							<td><fmt:formatDate value="${note.createtime }" pattern="yyyy年MM月dd日   HH：mm：ss"/></td>
						</tr>
					</c:forEach>
						
					</table>
				</div>
			</div> 
			
			<div class="center_right" style="float:right;margin-right:151px;">
				<div class="center_right_top">
					<label style="font-family:楷体;">登录笔记共享与会议记录系统 可以享受无限的乐趣 并且无限发布笔记内容 评论他人笔记 以及制定每日计划 通过邮件和系统其他已注册人员通信等</label>
					<!-- <button id="login" onclick="toLogin()">用户登录</button> -->
					<input type="button" id="toLogin" onclick="toLogin()" value="用户登录" style="height:32px;width:81px;margin-top:-1px;text-algin:center;margin-left:115px;border-width:2px;border-style:solid;border-color:white;border-radius:8px;color:white;background-color:red;">
				</div>
				<div class="center_right_bottom">
					<div class="center_right_bottom_title">
						<label>鲜肉笔者</label>
						<a href="">更多>></a><hr>
						<table>
						<c:forEach var="newperson" items="${lastestPerson }" >
							<tr>
								<td>${newperson.usernum }</td>
								<td>${newperson.username }</td>
							</tr>
						</c:forEach>
						</table>
					</div>
				</div>
			</div>
			
		</div>
    	
    	<!-- 脚注 -->
		<div class="footer">
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
		</div>
	</div><!-- 最大的div end -->
	
	<script>
	
	/*登录按钮点击 提交给表单*/
	function login_submit(){
		var usernum = $("#usernumm").val();
		if(usernum.length == 0){
			$.messager.alert("警示","账号不能为空");
			return;
		}else{
			var password = $("#passwordd").val();
			if(password.length == 0){
				$.messager.alert("警示","密码不能为空");
				return;
			} else{
				
				/* document.getElementById("login_form").submit();  ajax处理登录*/
				$.ajax({
                url: "<c:url value="person/goLogin.do"/>",
                type: "POST",
                data: {
                	usernumm: $("#usernumm").val(),
                	passwordd:  $("#passwordd").val(),
                	identityy:  $("input[name='identityy']:checked").val(),
                },
                success: function (msg) {
                    if (msg != "error") {/*  登录成功的页面 修改主页的css*/
                    	$.messager.confirm('Confirm','恭喜您，登錄成功！',function(r){
						    if (r){
                       			 $('#login_error').html('');
								$("#win_login").window("close");
		                        $('#toLogin').val(msg);
		                        $('#header_login').html(msg);
						    }
						});
                        return true;
                    } else {
                        $('#login_error').html('登录失败,用户名或密码错误');
                        $('#login_error').css({'margin-left':'10px;','color':'red'});
                        $("#login_error").show();
                        return false;
                    }
                }
            })
				/*ajax登录结束  */
			}
		}
	}
	
	/*跳转到注册页面*/
	function toRegist(){
		$('#login_error').html('');//跳转时清空错误提示信息
		$('#show_regist').show(); // open the regist window
		$("#win_login").window("close");
		$("#win_regist").window("open");
	}
	
	
	/*注册按钮点击 提交给表单*/
	function regist_submit(){
		var usernum = $("#usernum").val();
		if(usernum.length < 3){
			$.messager.alert("警示","账号长度不能小于3");
			return;
		}else{
			var username = $("#username").val();
			if(username.length < 3){
				$.messager.alert("警示","昵称长度不能小于3");
				return;
			} else{
				var password = $("#password").val();
				if(password.length < 3){
					$.messager.alert("警示","密码长度不能小于3");
					return;
				}else{
					var identity = $("input[name='identity']:checked").val();
					var companynum = $("#companynum").val();
					if(identity == 1){
						if(companynum.length == 0){
							
							/* 注册的ajax  document.getElementById("regist_form").submit(); */
							$.ajax({
				                url: "<c:url value="person/goRegist.do"/>",
				                type: "POST",
				                data: {
				                	usernum: $("#usernum").val(),
				                	username: $("#username").val(),
				                	password:  $("#password").val(),
				                	identity:  $("input[name='identity']:checked").val(),
				                	companynum:  $("#companynum").val(),
				                },
				                success: function (msg) {
				                    if (msg == "correct") {
				                    	$.messager.confirm('Confirm','注册成功，转到登录?',function(r){
										    if (r){
												$("#win_regist").window("close");
												$("#win_login").window("open");
										    }
										});
				                        return true;
				                    } else {
				                        $('#regist_error').html('注册失败，请重新注册');
				                        $('#regist_error').css({'margin-left':'10px;','color':'red'});
				                        $("#regist_error").show();
				                        return false;
				                    }
				                }
				            })
							/*  注册的ajax结尾*/
						}else{
							$.messager.alert("警示","非企业用户不能填写公司编号");
							return;
						}
					}else{
						if(companynum.length > 0){
							
							
							/* 注册的ajax  document.getElementById("regist_form").submit(); */
							$.ajax({
				                url: "<c:url value="person/goRegist.do"/>",
				                type: "POST",
				                data: {
				                	usernum: $("#usernum").val(),
				                	username: $("#username").val(),
				                	password:  $("#password").val(),
				                	identity:  $("input[name='identity']:checked").val(),
				                	companynum:  $("#companynum").val(),
				                },
				                success: function (msg) {
				                    if (msg == "correct") {
				                    	$.messager.confirm('Confirm','注册成功，转到登录?',function(r){
										    if (r){
												$("#win_regist").window("close");
												$("#win_login").window("open");
										    }
										});
				                        return true;
				                    } else {
				                        $('#regist_error').html('注册失败，账号已存在，请重新注册');
				                        $('#regist_error').css({'margin-left':'10px;','color':'red'});
				                        $("#regist_error").show();
				                        return false;
				                    }
				                }
				            })
							/*  注册的ajax结尾*/
							
						}else{
							$.messager.alert("警示","企业用户必须填写公司编号");
							return;
						}
					}
				}
			}
		}
	}
    
	/*跳转到用户登录*/
	function toLogin(){
		/* window.location.href ="/person/toLogin.do";  */
		$('#regist_error').html('');//跳转时清空错误提示信息
		$('#show_login').show(); // open the login window
		$("#win_regist").window("close");
		$("#win_login").window("open");
	}

	</script>
	<!-- 弹出登录的小窗口 <a onclick="document.getElementById('form1').submit();">提交</a> -->
	<div id="show_login" style="display:none;" >
    <div id="win_login" name="win" class="easyui-window"  title="登录"  closed="true"
    	iconCls="icon-add " data-options="iconCls:'icon-save',modal:true" 
    	style="overflow-y:hidden;width:502px;height:333px;overflow-x:hidden;top:202px;left:399px;"  > 
    	<form action="person/goLogin.do" method="post" name="login" class="form" id="login_form">
    		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    		<span id="login_error" class="display:none;height:30px;color:red;margin-left:36px;" ></span><br>
    		<label>账号：</label><input id="usernumm" name="usernumm" type="text" placeholder="请输入账号…"><br>
    		<label>密码：</label><input id="passwordd" name="passwordd" type="password" placeholder="请输入密码…"><br>
    		<label>身份：</label>
    		<input type="radio" name="identityy" value="1" checked> 普通用户
			<input type="radio" name="identityy" value="2"> 企业用户
			<input type="radio" name="identityy" value="3"> 管理员<br> 
			<div class="login_button">
				<input type="button" value="登录" class="butn" onclick="login_submit()" >
			</div>
    	</form>
    	<div class="login_to_regist">
    		<hr>
			<div class="login_bottom_left">还没账号？马上<button  onclick="toRegist()">注册</button></div>
			<div class="login_bottom_right">忘记密码？点击<a href="">这里</a></div>
       	</div>	
    </div>
   </div>
    
	<!-- 弹出注册的小窗口 -->
	<div id="show_regist" style="display:none;">
    <div id="win_regist" name="win" class="easyui-window" closed="true" title="注册" 
    	iconCls="icon-add" data-options="iconCls:'icon-save',modal:true" 
    	style="overflow-y:hidden;width:502px;height:418px;overflow-x:hidden;top:162px;left:389px;" > <!--class="registdiv"  -->
    	<form action="person/goRegist.do" method="post" class="regist_form" id="regist_form">
    		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    		<span id="regist_error" class="display:none;height:30px;color:red;margin-left:36px;" ></span><br>
    		<label>账号：</label><input id="usernum" name="usernum" type="text" placeholder="请输入账号…（用于登录）" ><br>
    		<label>昵称：</label><input id="username" name="username" type="text" placeholder="请输入昵称…" ><br>
    		<label>密码：</label><input id="password" name="password" type="password" placeholder="请输入密码…" ><br>
    		<label>身份：</label>
    		<input type="radio" id="identity1" name="identity" value="1" style="width:38px;" checked> 普通用户
			<input type="radio" id="identity2" name="identity" value="2" style="width:28px;"> 企业用户<br>
			<label>公司编号：</label><input id="companynum" name="companynum" type="text" placeholder="非企业用户请勿填写"><br>
    		<div class="regist_button">
				<input type="button" value="注册" class="butn" onclick="regist_submit()">
			</div>
    	</form>
    	<div class="regist_to_login">
    		<hr>
			<div class="login_bottom_left">已有账号？马上<button  onclick="toLogin()">登录</button></div>
			<div class="login_bottom_right">忘记密码？点击<a href="">这里</a></div>
       	</div>	
    </div>
    </div>
  </body>
</html>
