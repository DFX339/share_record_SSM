<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%  
   String path = request.getContextPath();  
   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
 %>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>MEETING管理</title>
 <link href="<%=basePath %>/static/jquery-easyui-1.5/themes/default/easyui.css" rel="stylesheet" />
 <link href="<%=basePath %>/static/jquery-easyui-1.5/themes/icon.css" rel="stylesheet" />
 <script src="<%=basePath %>/static/jquery-easyui-1.5/jquery.min.js"></script>
 <script src="<%=basePath %>/static/jquery-easyui-1.5/jquery.easyui.min.js"></script>
 <link rel="stylesheet" href="<%=basePath %>/CSS/header.css">	
 <link rel="stylesheet" href="<%=basePath %>/CSS/meeting.css">	
 <link rel="stylesheet" href="<%=basePath %>/CSS/footer.css">	
<style>
	
.top{
		width:100%;
		height:32px;
	}
    .top>button{
		width:100%;
		height:32px;
		background-color:red;
		border:2px solid white;
		border-radius:6px;
		color:white;
		font-family:'楷体';
		font-size:22px;
		font-weight:blod;
    }
	
	.bottom{
		display:block;
		margin-top:-50px;
		width:1088px;
	}
	.bottom>.eachmeeting{
		margin-top:110px;
		margin-left:136px;
		width:1048px;
		height:auto;
	}
	.bottom>.eachmeeting>.showUsername{
		float:left;
		font-size:22px;
		font-weight:bold;
		font-family:'楷体';
		margin-left:2px;
	}
	.bottom>.eachmeeting>.showCreatetime{
		font-size:12px;
		float:left;
		margin-left:12px;
		margin-top:5px;
	}
	.bottom>.eachmeeting>.showTitle{
		font-size:20px;
		color:black;
		margin:1px;
		float:left;
		margin-left:3px;
	}
	.bottom>.eachmeeting>.meetingHref{
		float:right;
		width:200px;
	}
	.bottom>.eachmeeting>.meetingHref>.showNoteEdit{
		float:left;
		margin-left:20px;
		text-decoration:none;
	}
	.bottom>.eachmeeting>.meetingHref>.showNoteEdit>a{
		margin-left:20px;
		text-decoration:none;
	}
	.bottom>.eachmeeting>.meetingHref>.showNoteDelete{
		margin-left:20px;
	}
	.bottom>.eachmeeting>.meetingHref>.showNoteDelete>a{
		text-decoration:none;
		margin-left:20px;
	}
	
	.bottom>.eachmeeting>.showContent{
		font-size:17px;
		margin-left:2px;
		float:left;
		width:100%;
	}
	
	.bottom>.eachmeeting>.comment{
		font-size:16px;
		display:block;
	}
	.bottom>.eachmeeting>.comment>.commentOn{
		margin-left:6px;
		width:588px;
		display:block;
	}
	.bottom>.eachmeeting>.comment>.commentOn>input{
		float:left;
		width:450px;
		height:28px;
		color:black;
    	border-radius:9px;
    	border:1px solid red;
    	margin-top:5px;
	}
	.bottom>.eachmeeting>.comment>.commentOn>button{
		/* float:right; */
    	margin-right:9px;
    	margin-top:5px;
		height:28px;
		width:120px;
    	border-radius:9px;
    	border:1px solid red;
    	color:red;
	}
	.bottom>.eachmeeting>.eachComment{
		font-size:14px;
	}
	.bottom>.eachmeeting>.comment>.eachComment>.commentPerson{
		float:left;
		width:80px;
	}
	.bottom>.eachmeeting>.comment>.eachComment>.commentContent{
		float:left;
		margin-left:3px;
		font-size:14px;
		width:580px;
	}
	.bottom>.eachmeeting>.comment>.eachComment>.commentTime{
		float:right;
		margin-right:10px;
		font-size:10px;
	}
	.bottom>.eachmeeting>.comment>.eachComment>.deleteComment{
		margin-right:50px;
	}
	.bottom>.eachmeeting>.comment>.eachComment>.deleteComment>a{
		text-decoration:none;
		float:right;
		margin-right:100px;
	}
	
	/*添加会议内容的弹窗*/
	.addMeeting{
		margin-left:116px;
		margin-top:20px;
		font-size:18px;
		font-family:'楷体';
	}
	.addMeeting>label{
		margin-top:12px;
		width:200px;
	}
	.addMeeting>input{
		margin-top:12px;
		width:460px;
		margin-left:10px;
		height:28px;
	}
	
	.addMeeting>textarea{
		margin-top:6px;
		margin-left:116px;
	}
	
	.addMeeting>.addmeeting_button{
		margin-left:3px;
		margin-top:8px;
	}
	.addMeeting>.addmeeting_button>button{
		border-width:3px;
		margin-left:94px;
		height:36px;
		width:220px;
		background-color: #32CD32;
		color:white;
		border-style:solid;
		border-color:#F0F0F0;
		border-radius:12px;
	}
	.addMeeting>.addmeeting_button>a{
		border-width:3px;
		margin-left:38px;
		width:200px;
		height:29px;
		background-color: #32CD32;
		border-style:solid;
		border-color:#F0F0F0;
		border-radius:12px;
	}
</style>

<script type="text/javascript">
	//弹出添加笔记的窗口
	function addMeeting(){
		$("#win_addMeeting").window("open");
	}
	
	//退出添加会议内容页面
	function exit_addmeeting(){
		$("#win_addMeeting").window("close");
	}
	
	function addmeeting_submit(){
		var title = $("#addTitle").val();
		var content = $("#addContent").val();
		if(title.length == 0){
			$.messager.alert("警示","笔记标题不能为空！");
		}else{
			if(content.length == 0){
				$.messager.alert("警示","笔记内容不能为空！");
			}else{
				if($("#addMeeting").form('validate')){
					$.messager.confirm('确认','确定发送?',function(r){
						 if (r){
						    $("#addMeeting").submit();
						    $("#win_addMeeting").window('close');
						  }
					});
				}
			}
		}
	}
	
	
	//编辑会议内容
	function editMeeting(meetingid){
		$("#win_editMeeting").window('open');
		/*   ajax处理录*/
		$.ajax({
        url: "<%=request.getContextPath() %>/meeting/toEditMeeting.do?meetingid="+meetingid,
        type: "POST",
        success: function (msg) {
            if (msg != "error") {
   	            var meeting = JSON.parse(msg); //將json字符串轉換為對象輸出  json-transfer to js
             		$('#editMeetingid').val(meeting[0].id);
             		$('#editTitle').val(meeting[0].title);
					$("#editContent").val(meeting[0].content)
                	return true;
            }
        }
    })
		/*ajax结束  */
	}
	
	//删除会议内容
	function deleteMeeting(meetingid){
		window.location.href="<%=request.getContextPath() %>/meeting/deleteMeeting.do?id="+meetingid;
	}
	
	//删除会议评论内容
	function deleteNoteComment(meetingid){
		window.location.href="<%=request.getContextPath() %>/meeting/deleteMeetingComment.do?id="+meetingid;
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
		</div>
		
		<div class="meeting"><!-- 会议记录最大的div start -->
			<div class="top">
				<button onclick="addMeeting()">+添加会议记录</button>
			</div>
			<div class="bottom">
				<c:forEach var="meeting" items="${allMeetings }">
					<div class="eachmeeting">
						<div class="showUsername">
							<c:forEach var="person" items="${allPerson }">
								<c:if test="${person.id ==  note.userid }">
									${person.username }
								</c:if>
							</c:forEach>
						</div>
						
						<div class="showCreatetime"><fmt:formatDate value="${meeting.createtime }" pattern="yyyy年MM月dd日   HH：mm：ss"/></div><br>
						<div class="showTitle"><strong>《${meeting.title }》</strong></div>
						<div class="meetingHref">
						<div class="showNoteEdit"><a href="javascript:void(0);"  onclick="editMeeting(${meeting.id })">编辑</a></div>
						<div class="showNoteDelete"><a href="javascript:void(0);" onclick="deleteMeeting(${meeting.id })" >删除</a></div>
						</div>
						<div class="showContent"><pre-line>${meeting.content }</pre-line></div>
						
						<div class="comment">
						<form action="<%=request.getContextPath() %>/meeting/addMeetingComment.do?meetingid=${meeting.id }" method="post" class="commentOn" id="commentForm">
			  	  			<input type="text" name="commentContent" id="commentContent" />
			  	  			<button onclick="commentMeeting(${meeting.id })">评论</button>
			  	  		</form>
							
						<c:forEach var="meetingComment" items="${meetingComments }">
						<c:forEach var="comment" items="${meetingComment }">
						<c:if test="${meeting.id == comment.meetingid }">
							<div class="eachComment">
								<div class="commentPerson">匿名</div>
								<div class="commentContent">${comment.content }</div>
								<div class="commentTime"><fmt:formatDate value="${comment.createtime }" pattern="yyyy年MM月dd日   HH：mm：ss"/></div>
								<div class="deleteComment"><a href="javascript:void(0);" onclick="deleteNoteComment(${comment.id })" >删除</a></div>
							</div>
						</c:if>
						</c:forEach>
						</c:forEach>
						</div>
						
					</div>
						<br><br>
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
		
		</div><!-- 会议记录最大的div end -->
		
	<!-- 添加会议内容的弹窗 -->
	<div id="win_addMeeting" name="win" class="easyui-window" closed="true" title="添加会议内容" 
   	iconCls="icon-add" data-options="iconCls:'icon-save',modal:true" 
   	style="overflow-y:hidden;width:892px;height:518px;overflow-x:hidden;top:52px;left:259px;" > <!--class="registdiv"  -->
   	<form action="<%=request.getContextPath() %>/meeting/addMeeting.do" method="post"  class="addMeeting" id="addMeeting">
   		<label>会议主题：</label><input type="text" name="addTitle"  id="addTitle"><br>
   		<label style="float:left;margin-top:10px;">会议内容：</label><textarea id="addContent"  name="addContent" rows="20" cols="64"  style="float:left;margin-left:-102px;margin-top:12"></textarea>
   		<div class="addmeeting_button">
			<button class="butn" onclick="addmeeting_submit()" style="font-size:18px;margin-top:20px;">发送</button>
   			<a href="javascript:void(0);" plain="true" class="easyui-linkbutton" iconCls="icon-cancel" onclick="exit_addmeeting();" ><span style="font-size:20px;color:white;">退出</span></a>
		</div>
   	</form>
   </div>
   
	<!-- 修改会议内容的弹窗 -->
	<div id="win_editMeeting" name="win" class="easyui-window" closed="true" title="添加会议内容" 
   	iconCls="icon-add" data-options="iconCls:'icon-save',modal:true" 
   	style="overflow-y:hidden;width:892px;height:518px;overflow-x:hidden;top:52px;left:259px;" > <!--class="registdiv"  -->
   	<form action="<%=request.getContextPath() %>/meeting/editMeeting.do" method="post"  class="addMeeting" id="editMeeting">
   		<input type="text" name="editMeetingid"  id="editMeetingid" hidden="true" >
   		<label>会议主题：</label><input type="text" name="editTitle"  id="editTitle"><br>
   		<label style="float:left;margin-top:10px;">会议内容：</label><textarea id="editContent"  name="editContent" rows="20" cols="64"  style="float:left;margin-left:-102px;margin-top:12"></textarea>
   		<div class="addmeeting_button">
			<button class="butn" onclick="editmeeting_submit()" style="font-size:18px;margin-top:20px;">发送</button>
   			<a href="javascript:void(0);" plain="true" class="easyui-linkbutton" iconCls="icon-cancel" onclick="exit_addmeeting();" ><span style="font-size:20px;color:white;">退出</span></a>
		</div>
   	</form>
   </div>
   
   
	
		
</body>
</html>