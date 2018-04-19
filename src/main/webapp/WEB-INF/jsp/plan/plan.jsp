<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html; charset=utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  

<%  
   String path = request.getContextPath();  
   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
 %>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>PLAN管理</title>
 <link href="<%=basePath %>/static/jquery-easyui-1.5/themes/default/easyui.css" rel="stylesheet" />
 <link href="<%=basePath %>/static/jquery-easyui-1.5/themes/icon.css" rel="stylesheet" />
 <script src="<%=basePath %>/static/jquery-easyui-1.5/jquery.min.js"></script>
 <script src="<%=basePath %>/static/jquery-easyui-1.5/jquery.easyui.min.js"></script>
 <link rel="stylesheet" href="<%=basePath %>/CSS/header.css">	
 <link rel="stylesheet" href="<%=basePath %>/CSS/plan.css">	
 <link rel="stylesheet" href="<%=basePath %>/CSS/footer.css">	
 <style>
 	/*修改今日计划的弹窗CSS*/
 	.editplan{
 		padding:20px;
 		font-size:18px;
 		font-family:"楷体"
 	}
 	.editplan>label{
 		font-size:22px;
 		margin-left:320px;
 	}
 	.editplan>textarea{
 		margin-top:10px;
 		margin-left:15px;
 		font-size:16px;
 	}
 	.editplan>button{
 		margin-top:5px;
 		border:;3px solid red;
 		border-radius:10px;
 		width:220px;
 		height:32px;
 		color:white;
 		margin-left:265px;
 		background-color:red;
 		font-size:17px;
 	}
 </style>
<script type="text/javascript">
	/*添加今日计划  */
	function addPlan(){
		var con = $("#content").val();
		if(con.length == 0){
			$.messager.alert("警示","计划内容不能为空");
			return;
		}
		/*   ajax处理添加计划*/
		$.ajax({
        url: "<%=request.getContextPath() %>/plan/addPlan.do?",
        type: "POST",
        data: {
        	content: $("#content").val(),
        },
        success: function (msg) {
            if (msg == "ok") {/*  登录成功的页面 修改主页的css*/
            	$.messager.confirm('Confirm','添加成功！',function(r){
				    if(r){
				    	window.location.href ="<%=request.getContextPath() %>/plan/goMain.do?";
				    }
				})
            } 
        }
    })
		/*ajax处理添加计划结束  */
	}
	
	/* 删除今日计划 */
	function deletePlan(id){
   	    $.messager.confirm('Confirm','确定删除？',function(r){
   	    	if(r){
   	    		window.location.href="<%=request.getContextPath() %>/plan/deletePlan.do?id="+id;
   	    	}
   	    })
	}
	
	/*修改今日计划  弹出新窗口 修改*/
	function editPlan(plan_id){
		$("#win_editPlan").window("open");
   		$("#editid").val(plan_id); 
   		/*ajax处理根据id查询计划请求*/
   		$.ajax({
   			contentType: 'application/json',
   			scriptCharset : 'utf-8',
   			contentType : 'application/x-www-form-urlencoded;',
   	        url: '<%=request.getContextPath() %>/plan/findById.do?',
   	        type: 'POST',
   	        data: {
   	        	id: plan_id,
   	        },
   	        success: function (msg) {
   				$("#editcontent").text(msg);
   	        }
   	    })
   			/*ajax处理添加计划结束  */
	}
	
	/*确认修改*/
	function confirmEdit(){
   		
	$.ajax({
        url: "<%=request.getContextPath() %>/plan/editPlan.do?",
        type: "POST",
        data: {
        	editid: $("#editid").val(),
        	editcontent:$("#editcontent").val(),
        }
	     
	})
   	    	
	}
</script>
</head>

<body>
	<div class="header">
			<!-- <div style="margin-left:5px;float:left;margin-top:18px;">
			</div> -->
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
		</div><!-- 导航条div结束 -->
		
		<div class="plan"><!--计划最大的div start plan -->
			<div  class="addPlan">
				<div class="planContent">
					<textarea id="content" cols="113" rows="8" placeholder="#请在这里输入您的今日计划，点击右侧的按钮完成发布#"></textarea>
				</div>
				<div class="planButton">
					<button onclick="addPlan()">发布计划</button>
				</div>
			</div>
			
			<div class="showPlan">
				<hr>
				<c:forEach var="plan" items="${allPlan }">
				<div class="eachPlan">
					<div class="showUsername">${person.username }</div>
					<div class="showCreatetiem"> <fmt:formatDate value="${plan.createtime }" pattern="yyyy年MM月dd日   HH：mm：ss"/></div><br>
					<div class="showContent"><pre-line>${plan.content }</pre-line></div>
					<div class="showEdit"><a href="javascript:void(0);"  onclick="editPlan(${plan.id })">编辑</a></div>
					<div class="showDelete"><a href="javascript:void(0);" onclick="deletePlan(${plan.id })" >删除</a></div><br>
				</div>
				</c:forEach>
				
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
		</div><!--计划最大的div end plan -->
		
		<!-- 修改今日计划的弹窗 -->
		 <div id="win_editPlan" name="win" class="easyui-window" closed="true" title="修改今日计划" 
    	iconCls="icon-add" data-options="iconCls:'icon-save',modal:true" 
    	style="overflow-y:hidden;width:792px;height:438px;overflow-x:hidden;top:62px;left:309px;" > <!--class="registdiv"  -->
    	<form action="<%=request.getContextPath() %>/plan/editPlan.do" method="post"  class="editplan" id="editplan">
    		<input type="text" name="editid" hidden="true" id="editid" >
    		<label>计划内容</label><textarea id="editcontent" name="editcontent" cols="86" rows="17" style="font-size:16px;margin-top:8px;margin-left:16px;"></textarea>
    		<button onclick="confirmEdit()">确认修改</button>
    	</form>
    </div>
</body>
</html>