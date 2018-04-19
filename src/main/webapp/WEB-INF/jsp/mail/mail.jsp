<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"  contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
   String path = request.getContextPath();  
   String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
 %>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Mail管理</title>
 <link href="<%=basePath %>/static/jquery-easyui-1.5/themes/default/easyui.css" rel="stylesheet" />
 <link href="<%=basePath %>/static/jquery-easyui-1.5/themes/icon.css" rel="stylesheet" />
 <script src="<%=basePath %>/static/jquery-easyui-1.5/jquery.min.js"></script>
 <script src="<%=basePath %>/static/jquery-easyui-1.5/jquery.easyui.min.js"></script>
 <%-- <jsp:include page='${basePath }/template/header_model.jsp'/> --%>
 <link rel="stylesheet" href="<%=basePath %>/CSS/mail.css">	
 <link rel="stylesheet" href="<%=basePath %>/CSS/header.css">	
  <link rel="stylesheet" href="<%=basePath %>/CSS/footer.css">	

<style>
	.header{
		height:52px;
		color:black;
		background:url(<%=basePath %>/CSS/images/background_header.jpg);
		opacity:0.9;
	}
	
	/*添加邮件的css*/
	.addmail_div{
		margin-left:76px;
		margin-top:20px;
		font-size:18px;
		font-family:'楷体';
	}
	.addmail_div>label{
		margin-top:12px;
		width:200px;
	}
	.addmail_div>input{
		margin-top:12px;
		width:460px;
		margin-left:10px;
		height:28px;
	}
	
	.addmail_div>textarea{
		margin-top:6px;
		margin-left:116px;
	}
	.addmail_div>.addmail_button{
		margin-left:20px;
		margin-top:8px;
	}
	.addmail_div>.addmail_button>button{
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
	.addmail_div>.addmail_button>a{
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
	//转换日期格式  (使得从数据库中查询出来的时间正常显示)
	function formattime(val) {
		var year=parseInt(val.year)+1900;
		var month=(parseInt(val.month)+1);
		month=month>9?month:('0'+month);
		var date=parseInt(val.date);
		date=date>9?date:('0'+date);
		var hours=parseInt(val.hours);
		hours=hours>9?hours:('0'+hours);
		var minutes=parseInt(val.minutes);
		minutes=minutes>9?minutes:('0'+minutes);
		var seconds=parseInt(val.seconds);
		seconds=seconds>9?seconds:('0'+seconds);
		var time=year+'-'+month+'-'+date+' '+hours+':'+minutes+':'+seconds;
		    return time;
		}
	
/*recieve mails model -------------------------------------------------------*/	
$(function(){
	/*收件箱一开始就加载的信息*/
	$('#dg').datagrid({
	    url:'<%=request.getContextPath() %>/mail/goRecievemailsPage.do',
	    border:false,
	    pagination:true,
	    pageSize: 10,//每页显示的记录条数，默认为10 
   		pageList: [10,20,30],//可以设置每页记录条数的列表
	    toolbar:'#tb1',
	    fitColumns:true,
	    columns:[[
	                {field:'id',title:'ID',width:24,hidden:false,align:'center',checkbox:true,},
					{field:'sendid',title:'发件人',width:48,align:'center',
	                	formatter:function(value,row,index){
	                		<c:forEach var="user" items="${allPerson}">
								if('${user.id}' == row.sendid){
									return '${user.username}';
								}
							</c:forEach>
	                	}
					},
					{field:'recieveid',title:'收件人',width:48,align:'center',
						formatter:function(value,row,index){
							return '${person.username}';
						}	
					},
					{field:'content',title:'站内信内容',width:58,align:'center',hidden:true,
						formatter:function(value, row, index){
								var tempContent = row.content;
								if(tempContent.length>12){
									tempContent = tempContent.substring(0,12);
									return tempContent;
								}
								return tempContent;
					    }
					},
					{field:'title',title:'站内信主题',width:68,align:'center',
						formatter:function(value, row, index){
								var tempTitle = row.title;
								if(tempTitle.length>50){
									tempTitle = tempTitle.substring(0,50);
								}
								return tempTitle;
					    }
					},
					{field:'createtime',title:'站内信发送时间',width:48,align:'center',
						formatter:function(value,rec){
							return formattime(value);
						}
					},
	           ]],
	           //工具栏  
			    toolbar: [{
			    text:'查看详细',
				iconCls: 'icon-print',
				handler: function(){
					gofindDetails();
				}
				},'-',{    
				text:'未读',
				iconCls: 'icon-help',
				handler: function(){
					unreadRecieveMails();
				}
				},'-',{   
				text:'已读',
				iconCls: 'icon-ok',
				handler: function(){
					readRecieveMails();
				}
				},'-',{
				text:'删除信件',
				iconCls: 'icon-remove',
				handler: function(){
					doDelete();
				}
				},'-',{
				text:'查询信件',
				iconCls: 'icon-search',
				handler: function(){
					recieve_search();
				}
				}]
		});
	});

	
	
	/*收件箱查看已读信件*/
	function readRecieveMails(){
		$('#dg').datagrid({
		    url:'<%=request.getContextPath() %>/mail/gofindAllReadMails.do',
		    border:false,
		    pagination:true,
		    pageSize: 10,//每页显示的记录条数，默认为10 
	   		pageList: [10,20,30],//可以设置每页记录条数的列表
		    toolbar:'#tb1',
		    fitColumns:true,
		    columns:[[
		                {field:'id',title:'ID',width:24,hidden:false,align:'center',checkbox:true,},
						{field:'sendid',title:'发件人',width:48,align:'center',
		                	formatter:function(value,row,index){
		                		<c:forEach var="user" items="${allPerson}">
								if('${user.id}' == row.sendid){
									return '${user.username}';
								}
							</c:forEach>
		                	}
						},
						{field:'recieveid',title:'收件人',width:48,align:'center',
							formatter:function(value,row,index){
								return '${person.username}';
							}	
						},
						{field:'content',title:'站内信内容',width:58,align:'center',hidden:true,
							formatter:function(value, row, index){
									var tempContent = row.content;
									if(tempContent.length>12){
										tempContent = tempContent.substring(0,12);
										return tempContent;
									}
									return tempContent;
						    }
						},
						{field:'title',title:'站内信主题',width:68,align:'center',
							formatter:function(value, row, index){
									var tempTitle = row.title;
									if(tempTitle.length>50){
										tempTitle = tempTitle.substring(0,50);
									}
									return tempTitle;
						    }
						},
						{field:'createtime',title:'站内信发送时间',width:48,align:'center',
							formatter:function(value,rec){
								return formattime(value);
							}
						},
						]],
						 //工具栏  
					    toolbar: [{
					    text:'查看详细',
						iconCls: 'icon-print',
						handler: function(){
							gofindDetails();
						}
						},'-',{    
						text:'未读',
						iconCls: 'icon-help',
						handler: function(){
							unreadRecieveMails();
						}
						},'-',{   
						text:'已读',
						iconCls: 'icon-ok',
						handler: function(){
							readRecieveMails();
						}
						},'-',{
						text:'删除信件',
						iconCls: 'icon-remove',
						handler: function(){
							doDelete();
						}
						},'-',{
						text:'查询信件',
						iconCls: 'icon-search',
						handler: function(){
							recieve_search();
						}
						}]
		});
	}
	
	/*收件箱查看未读信件*/
	function unreadRecieveMails(){
		$('#dg').datagrid({
		    url:'<%=request.getContextPath() %>/mail/gofindAllUnreadMails.do',
		    border:false,
		    pagination:true,
		    pageSize: 10,//每页显示的记录条数，默认为10 
	   		pageList: [10,20,30],//可以设置每页记录条数的列表
		    toolbar:'#tb1',
		    fitColumns:true,
		    columns:[[
		                {field:'id',title:'ID',width:24,hidden:false,align:'center',checkbox:true,},
						{field:'sendid',title:'发件人',width:48,align:'center',
		                	formatter:function(value,row,index){
		                		<c:forEach var="user" items="${allPerson}">
								if('${user.id}' == row.sendid){
									return '${user.username}';
								}
							</c:forEach>
		                	}
						},
						{field:'recieveid',title:'收件人',width:48,align:'center',
							formatter:function(value,row,index){
								return '${person.username}';
							}	
						},
						{field:'content',title:'站内信内容',width:58,align:'center',hidden:true,
							formatter:function(value, row, index){
									var tempContent = row.content;
									if(tempContent.length>12){
										tempContent = tempContent.substring(0,12);
										return tempContent;
									}
									return tempContent;
						    }
						},
						{field:'title',title:'站内信主题',width:68,align:'center',
							formatter:function(value, row, index){
									var tempTitle = row.title;
									if(tempTitle.length>50){
										tempTitle = tempTitle.substring(0,50);
									}
									return tempTitle;
						    }
						},
						{field:'createtime',title:'站内信发送时间',width:48,align:'center',
							formatter:function(value,rec){
								return formattime(value);
							}
						},
						]],
						 //工具栏  
					    toolbar: [{
					    text:'查看详细',
						iconCls: 'icon-print',
						handler: function(){
							gofindDetails();
						}
						},'-',{    
						text:'未读',
						iconCls: 'icon-help',
						handler: function(){
							unreadRecieveMails();
						}
						},'-',{   
						text:'已读',
						iconCls: 'icon-ok',
						handler: function(){
							readRecieveMails();
						}
						},'-',{
						text:'删除信件',
						iconCls: 'icon-remove',
						handler: function(){
							doDelete();
						}
						},'-',{
						text:'查询信件',
						iconCls: 'icon-search',
						handler: function(){
							recieve_search();
						}
						}]
		});
	}
	
	/*recieve  显示出收件箱查询收件的div */
	function recieve_search(){
		$("#searchForm").show();
	}
	
	/*recieve 收件箱查看信件詳細內容的js  recieve*/
	function gofindDetails(){
		
		var selectRow = $('#dg').datagrid('getSelected');
		if(selectRow==null){
			$.messager.alert('警告','请先选中一行！');
			return;
		}
		$("#win_detailmail").window('open');
		/* 查看信件詳細內容  ajax处理登录*/
		$.ajax({
	        url: "<%=request.getContextPath() %>/mail/findById.do?id="+selectRow.id,
	        type: "POST",
	        success: function (mail1) {
	            if (mail1 != "") {/*  登录成功的页面 修改主页的css*/
	            var mail = JSON.parse(mail1); //將json字符串轉換為對象輸出  json-transfer to js
              		$('#recievers_detail').val(mail[0].recieveid);
					$("#title_detail").val(mail[0].title)
                    $('#content_detail').val(mail[0].content);
	                return true;
	            } 
	        }
	    })
		/*ajax查看收件箱詳細內容结束  */
	}
	
	/*雙擊 double click watch the recieve detail*/
	$(function(){
	$('#dg').datagrid({
		onDblClickRow : function(rowIndex,rowData){
			$("#win_detailmail").window('open');
			/* 查看信件詳細內容  ajax处理登录*/
			$.ajax({
		        url: "<%=request.getContextPath() %>/mail/findById.do?id="+rowData.id,
		        type: "POST",
		        success: function (mail1) {
		            if (mail1 != "") {/*  登录成功的页面 修改主页的css*/
		            var mail = JSON.parse(mail1); //將json字符串轉換為對象輸出  json-transfer to js
	              		$('#recievers_detail').val(mail[0].recieveid);
						$("#title_detail").val(mail[0].title)
	                    $('#content_detail').val(mail[0].content);
		                return true;
		            } 
		        }
		    })
		}
	});
	});//雙擊查看結束 double click recieve
	
	/*刪除 recieve mail*/
	function doDelete(){
		var selectRows = $('#dg').datagrid('getSelections');
		if(selectRows.length < 1){
			$.messager.alert('警告','请至少选中一行！');
			return;
		}
		var mailIds =[];
		for(var i=0;i<selectRows.length;i++ ){
			mailIds[i] = selectRows[i].id;
		}
		$.messager.confirm('确认','确认删除该内容吗?', function(r) {
			if (r) {
				window.location.href ="<%=request.getContextPath() %>/mail/goDelete.do?id="+mailIds;
			}
		})
	
	}/*刪除 recieve mail end*/
	
	/*recieve 收件箱模糊查询*/
	function searchFormQuery(){
		$('#dg').datagrid({
		    url:'<%=request.getContextPath() %>/mail/findRecieveByCondition.do',
		    queryParams:{ 
	   			/* id: $("#search_id").val(), */
	   			/* recieveid:$("#search_recieveid").val(), */
	   			content:$("#search_content").val(),
	   			title:$("#search_title").val(),  
	   		},
		    border:false,
		    pagination:true,
		    pageSize: 10,//每页显示的记录条数，默认为10 
	   		pageList: [10,20,30],//可以设置每页记录条数的列表
		    toolbar:'#tb1',
		    fitColumns:true,
		    columns:[[
		                {field:'id',title:'ID',width:24,hidden:false,align:'center',checkbox:true,},
						{field:'sendid',title:'发件人',width:48,align:'center',
		                	formatter:function(value,row,index){
		                		return '${person.username}';
		                	}
						},
						{field:'recieveid',title:'收件人',width:48,align:'center',
							formatter:function(value,row,index){
								<c:forEach var="user" items="${allPerson}">
									if('${user.id}' == row.recieveid){
										return '${user.username}';
									}
								</c:forEach>
							}	
						},
						{field:'content',title:'站内信内容',width:58,align:'center',hidden:true,
							formatter:function(value, row, index){
									var tempContent = row.content;
									if(tempContent.length>12){
										tempContent = tempContent.substring(0,12);
									}
									return tempContent;
						    }
						},
						{field:'title',title:'站内信主题',width:68,align:'center',
							formatter:function(value, row, index){
									var tempTitle = row.title;
									if(tempTitle.length>50){
										tempTitle = tempTitle.substring(0,50);
									}
									return tempTitle;
						    }
						},
						{field:'createtime',title:'站内信发送时间',width:48,align:'center',
							formatter:function(value,rec){
								return formattime(value);
							}
						},
						]],
						 //工具栏  
					    toolbar: [{
					    text:'查看详细',
						iconCls: 'icon-print',
						handler: function(){
							gofindDetails();
						}
						},'-',{    
						text:'未读',
						iconCls: 'icon-help',
						handler: function(){
							unreadRecieveMails();
						}
						},'-',{   
						text:'已读',
						iconCls: 'icon-ok',
						handler: function(){
							readRecieveMails();
						}
						},'-',{
						text:'删除信件',
						iconCls: 'icon-remove',
						handler: function(){
							doDelete();
						}
						},'-',{
						text:'查询信件',
						iconCls: 'icon-search',
						handler: function(){
							recieve_search();
						}
						}]
		});
	}
	
	/*查詢重置*/
	function searchFormReset(){
		$("#searchForm input").each(function(){
			$(this).val("");
		});
	}
	
	
	
/*send mails model-----------------------------------------------------------*/	
	
	$(function(){
	/*发件箱一开始就加载的信息*/
	$('#dg1').datagrid({
	    url:'<%=request.getContextPath() %>/mail/goSendmailsPage.do',
	    border:false,
	    pagination:true,
	    pageSize: 10,//每页显示的记录条数，默认为10 
   		pageList: [10,20,30],//可以设置每页记录条数的列表
	    toolbar:'#tb1',
	    fitColumns:true,
	    columns:[[
	                {field:'id',title:'ID',width:24,hidden:false,align:'center',checkbox:true,},
					{field:'sendid',title:'发件人',width:48,align:'center',
	                	formatter:function(value,row,index){
	                		return '${person.username}';
	                	}
					},
					{field:'recieveid',title:'收件人',width:48,align:'center',
						formatter:function(value,row,index){
							<c:forEach var="user" items="${allPerson}">
								if('${user.id}' == row.recieveid){
									return '${user.username}';
								}
							</c:forEach>
						}	
					},
					{field:'content',title:'站内信内容',width:58,align:'center',hidden:true,
						formatter:function(value, row, index){
								var tempContent = row.content;
								if(tempContent.length>12){
									tempContent = tempContent.substring(0,12);
								}
								return tempContent;
					    }
					},
					{field:'title',title:'站内信主题',width:68,align:'center',
						 formatter:function(value, row, index){
								var tempTitle = row.title;
								if(tempTitle.length>50){
									tempTitle = tempTitle.substring(0,50);
								}
								return tempTitle;
					    } 
					},
					{field:'createtime',title:'站内信发送时间',width:48,align:'center',
						formatter:function(value,rec){
							return formattime(value);
						}
					},
	           ]],
	    	
					 //工具栏 
				    toolbar: [{
				    text:'添加信件',
					iconCls: 'icon-add',
					handler: function(){
						goAdd1();
					}
					},'-',{
					text:'删除信件',
					iconCls: 'icon-remove',
					handler: function(){
						doDelete1();
					}
					},'-',{
					text:'查询信件',
					iconCls: 'icon-search',
					handler: function(){
						send_search1();
					}
					},'-',{
					text:'查看明细',
					iconCls: 'icon-print',
					handler: function(){
						gofindDetails1();
					}
					}]

	});
});
	/*添加站内信*/
	function goAdd1(){
		$("#searchForm1").hide();
		$("#win_addmail").window('open');//显示隐藏的添加页面
	}
	
	
	/* 显示出發件箱查询收件的div */
	function send_search1(){
		$("#searchForm1").show();
	}
	
	/*send 發件箱查看信件詳細內容的js  send*/
	function gofindDetails1(){
		
		var selectRow = $('#dg1').datagrid('getSelected');
		if(selectRow==null){
			$.messager.alert('警告','请先选中一行！');
			return;
		}
		$("#win_detailmail").window('open');
		/* 查看信件詳細內容  ajax处理登录*/
		$.ajax({
	        url: "<%=request.getContextPath() %>/mail/findById.do?id="+selectRow.id,
	        type: "POST",
	        success: function (mail1) {
	            if (mail1 != "") {/*  登录成功的页面 修改主页的css*/
	            var mail = JSON.parse(mail1); //將json字符串轉換為對象輸出  json-transfer to js
              		$('#recievers_detail').val(mail[0].recieveid);
					$("#title_detail").val(mail[0].title)
                    $('#content_detail').val(mail[0].content);
	                return true;
	            } 
	        }
	    })
		/*ajax查看發件箱詳細內容结束  */
	}
	
	/*雙擊 double click watch the send detail*/
	$(function(){
	$('#dg1').datagrid({
		onDblClickRow : function(rowIndex,rowData){
			$("#win_detailmail").window('open');
			/* 查看信件詳細內容  ajax处理登录*/
			$.ajax({
		        url: "<%=request.getContextPath() %>/mail/findById.do?id="+rowData.id,
		        type: "POST",
		        success: function (mail1) {
		            if (mail1 != "") {/*  登录成功的页面 修改主页的css*/
		            var mail = JSON.parse(mail1); //將json字符串轉換為對象輸出  json-transfer to js
	              		$('#recievers_detail').val(mail[0].recieveid);
						$("#title_detail").val(mail[0].title)
	                    $('#content_detail').val(mail[0].content);
		                return true;
		            } 
		        }
		    })
		}
	});
	});//雙擊查看結束 double click
	
	/*刪除 send mail*/
	function doDelete1(){
		var selectRows = $('#dg1').datagrid('getSelections');
		if(selectRows.length < 1){
			$.messager.alert('警告','请至少选中一行！');
			return;
		}
		var mailIds =[];
		for(var i=0;i<selectRows.length;i++ ){
			mailIds[i] = selectRows[i].id;
		}
		$.messager.confirm('确认','确认删除该内容吗?', function(r) {
			if (r) {
				window.location.href ="<%=request.getContextPath() %>/mail/goDelete.do?id="+mailIds;
			}
		})
	}/*刪除 send mail end*/
	
	searchFormReset
	
	/*查詢重置*/
	function searchFormReset1(){
		$("#searchForm1 input").each(function(){
			$(this).val("");
		});
	}
	
	

	/* send  處理模糊查詢信件*/
	function searchFormQuery1(){
	      	/*查询信件 send*/
	        $('#dg1').datagrid({
	   	    url:'<%=request.getContextPath() %>/mail/findSendByCondition.do',
	   		queryParams:{ 
	   			/* id: $("#search_id1").val(), */
	   			/* recieveid:$("#search_recieveid1").val(), */
	   			content:$("#search_content1").val(),
	   			title:$("#search_title1").val(),  
	   		},
	   	    border:false,
	   	    pagination:true,
	   	    pageSize: 10,//每页显示的记录条数，默认为10 
	   		pageList: [10,20,30],//可以设置每页记录条数的列表
	   	    toolbar:'#tb1',
	   	    fitColumns:true,
	   	    columns:[[
	   	                {field:'id',title:'ID',width:24,hidden:false,align:'center',checkbox:true,},
	   					{field:'sendid',title:'发件人',width:48,align:'center',
	   	                	formatter:function(value,row,index){
	   	                		return '${person.username}';
	   	                	}
	   					},
	   					{field:'recieveid',title:'收件人',width:48,align:'center',
	   						formatter:function(value,row,index){
	   							<c:forEach var="user" items="${allPerson}">
	   								if('${user.id}' == row.recieveid){
	   									return '${user.username}';
	   								}
	   							</c:forEach>
	   						}	
	   					},
	   					{field:'content',title:'站内信内容',width:58,align:'center',hidden:true,
	   						formatter:function(value, row, index){
	   								var tempContent = row.content;
	   								if(tempContent.length>12){
	   									tempContent = tempContent.substring(0,12);
	   									return tempContent;
	   								}
	   								return tempContent;
	   					    }
	   					},
	   					{field:'title',title:'站内信主题',width:68,align:'center',
	   						formatter:function(value, row, index){
	   								var tempTitle = row.title;
	   								if(tempTitle.length>50){
	   									tempTitle = tempTitle.substring(0,50);
	   								}
	   								return tempTitle;
	   					    }
	   					},
	   					{field:'createtime',title:'站内信发送时间',width:48,align:'center',
	   						formatter:function(value,rec){
	   							return formattime(value);
	   						}
	   					},
	   	           ]],
	   	    	
	   					 //工具栏 
	   				    toolbar: [{
	   				    text:'添加信件',
	   					iconCls: 'icon-add',
	   					handler: function(){
	   						goAdd1();
	   					}
	   					},'-',{
	   					text:'删除信件',
	   					iconCls: 'icon-remove',
	   					handler: function(){
	   						doDelete1();
	   					}
	   					},'-',{
	   					text:'查询信件',
	   					iconCls: 'icon-search',
	   					handler: function(){
	   						send_search1();
	   					}
	   					},'-',{
	   					text:'查看明细',
	   					iconCls: 'icon-print',
	   					handler: function(){
	   						gofindDetails1();
	   					}
	   					}]

	   	});
		
	}
	
	
</script>
</script>
</head>

<body>
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
		
		
	<div id="mail" class="easyui-tabs" data-options="justified:'true',pill:'true',narrow:'false',tabHeight:38,fit:'true'">
	<!-- 发件箱（已发送的邮件）send start -->
    <div title="<span style='color:black;font-size:18px;'>发件箱</span>">
        <div class="page1"  style="position:aboslute;background-color:#F0F0F0;">
		<div id="tb1">
			<div class="hea">
				<h3>【发件箱】已发送的站内信[${sendTotal }]：</h3>
			</div>
			<div id="searchForm1" class="search_div">
				<div id="searchForm1_next" width="100%" cellspacing="0" cellpadding="0" style="margin-left:10px;">
						<!-- <span>站内信ID:</span>
						<input type="text" id="search_id1" /> -->
						<!-- <span style="margin-left:20px;">发件人ID:</span>
						<input type="text" id="search_recieveid1" /> -->
						<span style="margin-left:320px;">主题:</span>
						<input type="text" id="search_title1" /> 
						<span style="margin-left:30px;">内容:</span>
						<input type="text" id="search_content1" />
						
						<button  onclick="searchFormQuery1()" value="查询" style="width:56px;height:28px;margin-left:24px;border:3px solid white;border-radius:8px;background-color:#0099FF;color:white;">查詢</button>	
						<button  onclick="searchFormReset1()" value="重置" style="width:56px;height:28px;margin-left:24px;border:3px solid white;border-radius:8px;background-color:#0099FF;color:white;">重置</button>	
				</div> 
				
			</div><!-- search_div的结束 -->
		</div><!-- tb1的idv结束 -->
		<table id="dg1" class="easyui-datagrid"></table>
		
    </div><!-- page1的div结束 -->
    </div> <!-- 发件箱结尾  send end-->
    
    <!-- 收件箱（已接收到的邮件） recieve start-->
     <div title="<span style='color:black;font-size:18px;'>收件箱</span>">
     <div class="page"  style="position:aboslute;background-color:#F0F0F0;"> 
		
		<div id="tb">
			<div class="hea">
				<h3>【收件箱】已接收的站内信[
				<a href="javascript:void(0);" plain="true" class="easyui-linkbutton"  onclick="allRecieveMails();" style="font-size:16px;color:red;">${recieveTotal }</a>]：
				</h3>
			</div>
			
			<div id="searchForm" class="search_div" >
				 <div id="searchForm_next" width="100%" cellspacing="0" cellpadding="0" style="margin-left:10px;" >
						<!-- <span>站内信ID:</span>
						<input type="text" id="search_id" />
						<span style="margin-left:20px;">发件人ID:</span>
						<input type="text" id="search_sendid" /> -->
						<span style="margin-left:320px;">主题:</span>
						<input type="text" id="search_title" /> 
						<span style="margin-left:30px;">内容:</span>
						<input type="text" id="search_content" />
						
						<button  onclick="searchFormQuery()" style="width:56px;height:28px;margin-left:24px;border:3px solid white;border-radius:8px;background-color:#F80000;color:white;">查询</button>	
						<button  onclick="searchFormReset()" style="width:56px;height:28px;margin-left:24px;border:3px solid white;border-radius:8px;background-color:#F80000;color:white;">重置</button>	
				</div> 
			</div><!-- search_div的结束 -->
			<table id="dg" class="easyui-datagrid"></table>
		</div> <!-- tb的div结束 -->
		</div> <!-- page的div结尾 -->
    </div><!-- 收件箱的结尾 recieve end -->
    
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
    
    </div><!-- mail的div结束 -->
	
	<!-- 添加站内信的script -->
	<script>
		/*退出添加站内信*/
		function exit_addmail(){
			$("#win_addmail").window('close');//隐藏添加页面
		}
		
		/*确定发送邮件*/
		function addmail_submit(){
			var recieveId = $("#recievers").val() ;//获取当前recieveId的value值
			var title = $("#title").val();
			var content = $("#content").val();
				if(recieveId.length != 0){
					if(title.length != 0){
						if(content.length != 0 ){
							if($("#addmail_form").form('validate')){
								$.messager.confirm('确认','确定发送?',function(r){
									 if (r){
									    $("#addmail_form").submit();
									    $("#win_addmail").window('close');
									  }
								});
							}
						
						}else{
							$.messager.alert("警告","站内信内容不能为空");
							return;
						}
					}else{
						$.messager.alert("警告","站内信主题不能为空");
						return;
					}
				}else{
					$.messager.alert("警告","收件人信息不能为空");
					return;
				}
		}

		
		/*选择收件人*/
		function chooseRecievers(){
			$("#chooseRecievers_win").window('open');//显示添加页面
			//加载系统所有人(刚点进来 没有查询条件时)
			$('#showUser').datagrid({
				pagination:true, 
				width:650,
			    url:'<%=request.getContextPath() %>/mail/findAllPerson.do',
			    pageSize: 10,//每页显示的记录条数，默认为10 
				pageList: [10,20],//可以设置每页记录条数的列表
			    columns:[[
			        {field:'ID',title:'复选框',align:'center',width:45,checkbox:true,},
					{field:'id',title:'收件人ID',align:'center',width:65},
			        {field:'username',title:'收件人昵称',align:'center',width:180},
			        {field:'usernum',title:'收件人账号',align:'center',width:180},
			        {field:'companynum',title:'公司编号',align:'center',width:180},
			        ]],	
			});
			
		}
		
		/*选择收件人的页面 模糊查询收件人*/
		function chooseQuery(){
			$('#showUser').datagrid({
				pagination:true, 
				width:650,
			    url:'<%=request.getContextPath() %>/mail/findAllPerson.do',
			    queryParams:{ 
		   			id:$("#search_recid").val(),
		   			usernum:$("#search_recusernum").val(),
		   			username:$("#search_recusername").val(), 
		   			companynum:$("#search_reccompanynum").val(),  
		   		},
			    pageSize: 10,//每页显示的记录条数，默认为10 
				pageList: [10,20],//可以设置每页记录条数的列表
			    columns:[[
			        {field:'ID',title:'复选框',align:'center',width:45,checkbox:true,},
					{field:'id',title:'收件人ID',align:'center',width:65},
			        {field:'username',title:'收件人昵称',align:'center',width:180},
			        {field:'usernum',title:'收件人账号',align:'center',width:180},
			        {field:'companynum',title:'公司编号',align:'center',width:180},
			        ]],	
			});
		}
		
		/*模糊查询收件人时的重置*/
		function chooseReset(){
			$("#find_reciever_table input").each(function(){
				$(this).val("");
			});
		}
		
		$(function(){
			$('#showUser').datagrid({
				//选中一行记录的事件
				onSelect : function(rowIndex,rowData){
					if($("table tr[id="+rowData.id+"]").length <=  0){
						var tr =  "<tr id="+rowData.id+"><td>"+rowData.id+"_"+rowData.username+"("+rowData.usernum+")"+";"+"</td></tr>";
						$("#recTb").append(tr);
						
						//为选中的行添加双击击事件（单双击击后将当前元素从显示收件人信息table中移除，并且在左侧datagrid表格中取消选中）
						$("table tr[id="+rowData.id+"]").bind("dblclick",function(){
							$("#"+rowData.id).remove();
						})  
					}
					
				},
				
				//取消选中一行记录的事件 
				onUnselect : function(rowIndex,rowData){
					$("#"+rowData.id).remove();
					   
				},
				
				//全部选中的事件
				onSelectAll :function(rows){
					for(var i=0;i<rows.length;i++){
						if($("table tr[id="+rows[i].id+"]").length <=  0){
							var tr =  "<tr id="+rows[i].id+"><td>"+rows[i].id+"_"+rows[i].username+"("+rows[i].usernum+")"+";"+"</td></tr>";
							$("#recTb").append(tr);
							//为选中的行添加双击事件（双击击后将当前元素从显示收件人信息table中移除，并且在左侧datagrid表格中取消选中）
							$("table tr[id="+rows[i].id+"]").bind("dblclick",function(){
								$(this).remove();
							}); 
							
						}
					}
				}, 
				
				//全部取消选中事件
				onUnselectAll :function(rows){
					for(var i=0;i<rows.length;i++){
						$("#"+rows[i].id).remove();
					}
				},
				
			});
			
		});
		
		
		
		<!--弹出小窗口确认收件人的事件-->
		function confirmChoose(){
			var recievers = "" ;
			//获取接收收件人信息的表格中的所有收件人信息，连接成字符串
			$("#recTb td").each(function(){
				recievers = recievers +this.innerHTML;
			}) 
			
			var oldRecievers = $("#recievers").val();
			if(recievers.length > 0){
				if(oldRecievers.length > 0){
					var oldarr = oldRecievers.split(";");//得到原有的字符串，并且以分号切割 
					var newarr = recievers.split(";");//得到新选中的字符串，切割为数组
					
					var oldlen = oldarr.length;//得到原有的字符串数组的长度
					var newlen = newarr.length;//得到新的字符串数组的长度
					
					//判断两个数组中是否有相同的元素，有相同的元素时移除旧的字符串数组中的元素
					for(var n=0;n<newlen-1;n++){
						for(var j=0;j<oldlen-1;j++){
							if(newarr[n] == oldarr[j]){
								oldRecievers = oldRecievers.replace(oldarr[j]+";","");
							}
						}
					}
					recievers = oldRecievers +recievers;
				}
				$("#recievers").val(recievers);
				$("#chooseRecievers_win").window("close");
			}else{
				$.messager.alert("警告","请至少选中一个收件人")
			}
			
		}
		
		<!--弹出小窗口取消确认收件人的事件-->
		function cancleChoose(){
			$.messager.confirm('确认','确认退出吗?', function(r) {
				if (r) {
					$("#chooseRecievers_win").window("close");
				}
			});
		}
		
	</script>
	<!-- 添加站内信 -->
    <div id="win_addmail" name="win" class="easyui-window" closed="true" title="添加信件" 
    	iconCls="icon-add" data-options="iconCls:'icon-save',modal:true" 
    	style="overflow-y:hidden;width:892px;height:518px;overflow-x:hidden;top:52px;left:259px;" > <!--class="registdiv"  -->
    	<form action="<%=request.getContextPath() %>/mail/send.do" method="post" class="addmail_div" id="addmail_form" >
    		<label>收件人信息：</label><input id="recievers" name="recievers" type="text" placeholder="请点击右侧按钮添加收件人..." readonly="true" >
    		<a href="javascript:void(0);" plain="true" class="easyui-linkbutton" iconCls="icon-add" onclick="chooseRecievers();" style="background-color:#AFEEEE;"><span style="font-size:20px;">添加收件人</span></a><br>
    		<label>邮件的主题：</label><input id="title" name="title" type="text" placeholder="请输入邮件主题..." ><br>
    		<label style="float:left;margin-top:10px;">邮件的内容：</label><textarea id="content" name="content"  placeholder="请输入邮件内容..." rows="20" cols="64" style="float:left;margin-left:-82px;margin-top:12" ></textarea><br>
    		<div class="addmail_button">
				<button class="butn" onclick="addmail_submit()" style="font-size:18px;margin-top:20px;">发送</button>
    			<a href="javascript:void(0);" plain="true" class="easyui-linkbutton" iconCls="icon-cancel" onclick="exit_addmail();" ><span style="font-size:20px;color:white;">退出</span></a>
			</div>
    	</form>
    </div>
    <!-- 添加邮件结束标签 -->
    
    <!-- 弹出选择收件人的窗口 -->
	 <div id="chooseRecievers_win" name="win" class="easyui-window" closed="true" title="选择收件人" style="width:1102px;height:520px;overflow-x:hidden;"  iconCls="icon-add"
		 data-options="iconCls:'icon-save',modal:true"> 
				<br></br>
	<!-- 用户模糊查询收件人的table -->
	<table width="100%" cellspacing="0" cellpadding="0" style="margin-left:1px;" id="find_reciever_table">
		<tr>
			<td><span>收件人ID:</span></td>
			<td><input type="text" id="search_recid" /></td>
			<td><span>账号:</span></td>
			<td><input type="text" id="search_recusernum"  /></td>
			<td><span>昵称:</span></td>
			<td><input type="text" id="search_recusername" /></td>
			<td><span>公司编号:</span></td>
			<td><input type="text" id="search_reccompanynum" /></td>
		</tr>
		<tr>
			<td colspan="4" >
				<a href="javascript:void(0);" class="easyui-linkbutton" onclick="chooseQuery()" style="margin-left:300px;margin-top:6px;width:98px;background-color:3399CC;float:left">查询</a>
				<a href="javascript:void(0);" class="easyui-linkbutton" onclick="chooseReset()" style="float:left;margin-left:110px;margin-top:3px;width:98px;background-color:3399CC;">重置</a>
			</td>
		</tr>
	</table>
	
	 <br></br>
	 <div class="show" style="float:left">
	 	 <!-- 显示查询出来的收件人信息的table -->
	 	 <div style="float:left;width:680px;height:360px;overflow-y:hidden;overflow-x:hidden;margin-left:49px;">
			 <table id="showUser" class="easyui-datagrid"  style="height:350px;overflow-y:auto;overflow-x:hidden;" ></table> 
		 </div>
	 	 <div style="float:right;margin-right:15px;width:300px;height:350px;">
		 <!-- 显示用户选择的收件人的信息框 -->
		 	<table id="recTb" border="1px" height="300px" width="300px"></table>
		</div>
	</div>
			
	<div style="padding:6px;position:absolute;right:125px;bottom:26px;margin-right:10px;">
        <a href="#" class="easyui-linkbutton" icon="icon-ok" onclick="confirmChoose()" style="margin-right:30px;background-color:3399CC;">确定</a>
        <a href="#" class="easyui-linkbutton" icon="icon-cancel" onclick="cancleChoose()" style="background-color:3399CC;">取消</a>
	</div>
						
   </div><!-- 添加收件人結束窗口 -->
   
   <!-- 退出查看郵件明細的方法 -->
   <script>
   	function exit_detailmail(){
   		$("#win_detailmail").window('close');
   	}
   </script>
   <!-- 查看郵件明細的窗口 查看詳細信息 detail mail  -->
    <div id="win_detailmail" name="win" class="easyui-window" closed="true" title="信件詳情" 
    	iconCls="icon-add" data-options="iconCls:'icon-save',modal:true" 
    	style="overflow-y:hidden;width:892px;height:518px;overflow-x:hidden;top:52px;left:259px;" > <!--class="registdiv"  -->
    	<form action="<%=request.getContextPath() %>/mail/findById.do" method="post" class="addmail_div" style="margin-left:108px;" >
    		<label>收件人信息：</label><input id="recievers_detail" name="recievers_detail" type="text" readonly="true"><br>
    		<label>邮件的主题：</label><input id="title_detail" name="title_detail" type="text" readonly="true"><br>
    		<label>邮件的内容：<br></label><textarea id="content_detail" name="content_detail" rows="20" cols="86" readonly="true"></textarea><br>
    		<div class="addmail_button">
				<input type="button" value="退出" class="butn" onclick="exit_detailmail()" style="font-size:18px;">
			</div>
    	</form>
    </div>
	<!-- 查看郵件明細的窗口 查看詳細信息 detail mail end -->
</body>
</html>