<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%  
   String path = request.getContextPath();  
   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
 %>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>NOTE管理</title>
<link href="<%=basePath %>/static/jquery-easyui-1.5/themes/default/easyui.css" rel="stylesheet" />
 <link href="<%=basePath %>/static/jquery-easyui-1.5/themes/icon.css" rel="stylesheet" />
 <script src="<%=basePath %>/static/jquery-easyui-1.5/jquery.min.js"></script>
 <script src="<%=basePath %>/static/jquery-easyui-1.5/jquery.easyui.min.js"></script>
 <link rel="stylesheet" href="<%=basePath %>/CSS/header.css">	
 <link rel="stylesheet" href="<%=basePath %>/CSS/note.css">	
 <link rel="stylesheet" href="<%=basePath %>/CSS/footer.css">	
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>  
<style>
	.left{
		float:left;
		width:15%;
		height:100%;
		display:block;
		background-color:red;
	}
    .left>ul{
    	list-style-type:none;
		margin:0;
		padding:0;
		margin-top:16px;
    }
	.left>ul>li{
		float:left;
		margin-top:48px;
		width:88px;
		margin-left:36px;
		
	}
	.left>ul>li>a{
		text-decoration:none;
		display:block;
		width:128px;
		height:28px;
		background-color:green;
		text-align:center;
		color:white;
		border:3px solid white;
		border-radius:9px;
		font-family:'楷体';
		padding-top:6px;
	}
	
	.right{
		margin-top:1px;
		float:left;
		margin-left:66px;
		display:block;
		font-size:18px;
		width:1000px;
	}
	.right>.addNoteButton{
		width:94%;
	}
	.right>.addNoteButton>button{
		width:100%;
		height:32px;
		border:2px solid white;
		border-radius:5px;
		color:red;
		background-color:original;
		font-size:18px;
		font-family:'楷体';
		font-weight:bold;
	}
	.right>.eachNote{
		margin-top:30px;
		width:92%;
		height:auto;
		background-color:white;
		border-left:1px solid #c1b1b1;
		border-right:1px solid #c1b1b1;
		padding:10px;
	}
	.right>.eachNote>.showUsername{
		font-size:20px;
		font-weight:bold;
		font-family:'楷体';
		float:left;
	}
	.right>.eachNote>.showCreatetime{
		font-size:12px;
		float:left;
		margin-left:12px;
		margin-top:5px;
	}
	.right>.eachNote>.showTitle{
		font-size:20px;
		color:black;
		margin:1px;
		float:left;
	}
	.right>.eachNote>.showNoteEdit{
		float:left;
		margin-left:520px;
		text-decoration:none;
	}
	.right>.eachNote>.showNoteEdit>a{
		margin-left:20px;
		text-decoration:none;
	}
	.right>.eachNote>.showNoteDelete{
		margin-left:20px;
	}
	.right>.eachNote>.showNoteDelete>a{
		text-decoration:none;
		margin-left:20px;
	}
	
	.right>.eachNote>.showContent{
		font-size:17px;
		margin-left:2px;
		float:left;
		width:100%;
	}
	.right>.eachNote>.comment{
		font-size:16px;
	}
	.right>.eachNote>.comment>.commentOn{
		margin-left:6px;
		width:888px;
		display:block;
	}
	.right>.eachNote>.comment>.commentOn>input{
		float:left;
		width:450px;
		height:28px;
		color:black;
    	border-radius:9px;
    	border:1px solid red;
    	margin-top:5px;
	}
	.right>.eachNote>.comment>.commentOn>button{
    	margin-left:10px;
    	margin-top:5px;
		height:28px;
		width:120px;
    	border-radius:9px;
    	border:1px solid red;
    	color:red;
	}
	.right>.eachNote>.comment>.eachComment{
		font-size:14px;
	}
	.right>.eachNote>.comment>.eachComment>.commentPerson{
		float:left;
		width:80px;
	}
	.right>.eachNote>.comment>.eachComment>.commentPerson>a{
		text-decoration:none;
	}
	.right>.eachNote>.comment>.eachComment>.commentContent{
		float:left;
		margin-left:3px;
		font-size:14px;
		width:580px;
	}
	.right>.eachNote>.comment>.eachComment>.commentTime{
		float:right;
		margin-right:10px;
	}
	.right>.eachNote>.comment>.eachComment>.deleteComment{
		margin-right:50px;
	}
	.right>.eachNote>.comment>.eachComment>.deleteComment>a{
		text-decoration:none;
	}
	
	/*添加笔记弹窗的css*/
		
	.addNote{
		margin-left:116px;
		margin-top:20px;
		font-size:18px;
		font-family:'楷体';
	}
	.addNote>label{
		margin-top:12px;
		width:200px;
	}
	.addNote>input{
		margin-top:12px;
		width:460px;
		margin-left:10px;
		height:28px;
	}
	
	.addNote>textarea{
		margin-top:6px;
		margin-left:116px;
	}
	
	.addNote>.addnote_button{
		margin-left:10px;
		margin-top:8px;
	}
	.addNote>.addnote_button>button{
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
	.addNote>.addnote_button>a{
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
	//弹出添加笔记的弹出的方法
	function toAddNote(){
		$("#win_addNote").window("open");
	}
	
	//退出添加笔记页面
	function exit_addnote(){
		$("#win_addNote").window("close");
	}
	
	//响应发送笔记的请求
	function addnote_submit(){
		var title = $("#addTitle").val();
		var content = $("#addContent").val();
		var state = $("input[name='state']:checked").val();
		if(title.length == 0){
			$.messager.alert("警示","笔记标题不能为空！");
		}else{
			if(content.length == 0){
				$.messager.alert("警示","笔记内容不能为空！");
			}else{
				if($("#addNote").form('validate')){
					$.messager.confirm('确认','确定发送?',function(r){
						 if (r){
						    $("#addNote").submit();
						    $("#win_addNote").window('close');
						  }
					});
				}
			}
		}
	}
	
	/*  响应添加笔记评论*/
	function commentNote(noteid){
		var commentNoteContent = $("#commentNoteContent").val();
		if(commentNoteContent.length == 0){
			/* $.messager.alert("警示","评论内容不能为空!");  此语句失效 暂时不管*/
			return;
		}else{
			  document.getElementById("commentForm").submit();
		}
	 }
	
	/* 响应删除笔记评论 */
	function deleteNoteComment(noteCommentId){
		window.location.href="<%=request.getContextPath() %>/note/deleteComment.do?id="+noteCommentId;
	}
	
	/* 响应删除笔记内容 */
	function deleteNote(noteId){
		window.location.href="<%=request.getContextPath() %>/note/deleteNote.do?id="+noteId;
	}
	
	/* 响应修改笔记  跳转到修改笔记的页面*/
	function editNote(noteid){
		/* $("#win_editNote").window('open'); */
		/*   ajax处理录*/
		$.ajax({
        url: "<%=request.getContextPath() %>/note/toEditNote.do?noteid="+noteid,
        type: "POST",
        success: function (msg) {
            if (msg != "error") {
            	 $("#win_editNote").window('open');
   	               var note = JSON.parse(msg); //將json字符串轉換為對象輸出  json-transfer to js
             		$('#editNoteid').val(note[0].id);
             		$('#editTitle').val(note[0].title);
					$("#editContent").val(note[0].content)
					var state = note[0].state;
					if(state == 'public'){
						$("#state3").attr("checked",true)
					}else{
						$("#state4").attr("checked",true)
					}
                	return true;
            }
        }
    })
		/*ajax结束  */
	}
	
	/*处理修改笔记的请求*/
	function editnote_submit(){
		$.messager.alert("Confirm","确定修改？",function(r){
			if(r){
				document.getElementById("editNote").submit();
			}
		});
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
	
	<div class="note"><!-- 笔记最大的div -->
		<div class="left" style="background-color:red;">
			<ul>
				<li><a href="<%=request.getContextPath() %>/note/findMyNotes.do" >我的笔记</a></li>
				<li><a href="<%=request.getContextPath() %>/note/goMain.do" >所有笔记</a></li>
			</ul>
		</div>
		
		<div class="right">
			<div class="addNoteButton"><button onclick="toAddNote()">+点击这里发布笔记</button></div>
			<c:forEach var="note" items="${allNotes }">
			<div class="eachNote">
				<div class="showUsername">
					<c:forEach var="person" items="${allPerson }">
						<c:if test="${person.id ==  note.userid }">
							${person.username }
						</c:if>
					</c:forEach>
				</div>
				
				<div class="showCreatetime"><fmt:formatDate value="${note.createtime }" pattern="yyyy年MM月dd日   HH：mm：ss"/></div><br>
				<div class="showTitle"><strong>《${note.title }》</strong></div>
				<div class="showNoteEdit"><a href="javascript:void(0);"  onclick="editNote(${note.id })">编辑</a></div>
				<div class="showNoteDelete"><a href="javascript:void(0);" onclick="deleteNote(${note.id })" >删除</a></div>
				<div class="showContent"><pre-line>${note.content }</pre-line></div>
				
				<div class="comment">
				<form action="<%=request.getContextPath() %>/note/addNoteComment.do?noteid=${note.id }" method="post" class="commentOn" id="commentForm">
	  	  			<input type="text" name="commentNoteContent" id="commentNoteContent" />
	  	  			<button onclick="commentNote(${note.id })">评论</button>
	  	  		</form>
					
					<c:forEach var="comments" items="${noteComments }">
						<c:forEach var="comment" items="${comments }">
						<c:if test="${note.id == comment.noteid }">
								<div class="eachComment">
									<div class="commentPerson"><a href="javascript:void(0);">
										<c:forEach var="person" items="${allPerson }">
											<c:if test="${comment.commentid == person.id }">
												${person.username }
											</c:if>
										</c:forEach>
									</a></div>
									<div class="commentContent">${comment.content }</div>
									<div class="commentTime"><fmt:formatDate value="${comment.createtime }" pattern="yyyy年MM月dd日   HH：mm：ss"/></div>
									<div class="deleteComment"><a href="javascript:void(0);" onclick="deleteNoteComment(${comment.id })" >删除</a></div>
								</div>
						</c:if>
						</c:forEach>
					</c:forEach>
					
				</div>
				
			</div>
			
			<br>
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
		
	</div><!-- 笔记最大的div结束 -->


	<!-- 添加笔记的弹窗 -->
	<div id="win_addNote" name="win" class="easyui-window" closed="true" title="添加笔记" 
   	iconCls="icon-add" data-options="iconCls:'icon-save',modal:true" 
   	style="overflow-y:hidden;width:892px;height:518px;overflow-x:hidden;top:52px;left:259px;" > <!--class="registdiv"  -->
   	<form action="<%=request.getContextPath() %>/note/addNote.do" method="post"  class="addNote" id="addNote">
   		<label>笔记主题：</label><input type="text" name="addTitle"  id="addTitle"><br>
   		<label style="float:left;margin-top:10px;">笔记内容：</label><textarea id="addContent"  name="addContent" rows="20" cols="64"  style="float:left;margin-left:-102px;margin-top:12"></textarea>
   		<label style="float:left;margin-top:10px;width:500px;">笔记状态：
   		<input type="radio" id="state1" name="state" value="public" style="width:38px;font-size:12px;height:12px;margin-left:86px;" class="stateradio" checked> 公开
		<input type="radio" id="state2" name="state" value="private" style="width:28px;font-size:12px;height:12px;margin-left:66px;">私密</label><br>
   		<div class="addnote_button">
			<button class="butn" onclick="addnote_submit()" style="font-size:18px;margin-top:20px;">发送</button>
   			<a href="javascript:void(0);" plain="true" class="easyui-linkbutton" iconCls="icon-cancel" onclick="exit_addnote();" ><span style="font-size:20px;color:white;">退出</span></a>
		</div>
   	</form>
   </div>
   
   
	<!-- 修改笔记的弹窗 -->
	<div id="win_editNote" name="win" class="easyui-window" closed="true" title="修改笔记" 
   	iconCls="icon-add" data-options="iconCls:'icon-save',modal:true" 
   	style="overflow-y:hidden;width:892px;height:518px;overflow-x:hidden;top:52px;left:259px;" > <!--class="registdiv"  -->
   	<form action="<%=request.getContextPath() %>/note/editNote.do" method="post"  class="addNote" id="editNote">
   		<input type="text" name="editNoteid"  id="editNoteid" hidden="true" >
   		<label>笔记主题：</label><input type="text" name="editTitle"  id="editTitle"><br>
   		<label style="float:left;margin-top:10px;">笔记内容：</label><textarea id="editContent"  name="editContent" rows="20" cols="64"  style="float:left;margin-left:-102px;margin-top:12"></textarea>
   		<label style="float:left;margin-top:10px;width:500px;">笔记状态：
   		<input type="radio" id="state3" name="statee" value="public" style="width:38px;font-size:12px;height:12px;margin-left:86px;" class="stateradio" checked> 公开
		<input type="radio" id="state4" name="statee" value="private" style="width:28px;font-size:12px;height:12px;margin-left:66px;">私密</label><br>
   		<div class="addnote_button">
			<button class="butn" onclick="editnote_submit()" style="font-size:18px;margin-top:20px;">确定</button>
   			<a href="javascript:void(0);" plain="true" class="easyui-linkbutton" iconCls="icon-cancel" onclick="exit_addnote();" ><span style="font-size:20px;color:white;">退出</span></a>
		</div>
   	</form>
   </div>
		
</body>
</html>