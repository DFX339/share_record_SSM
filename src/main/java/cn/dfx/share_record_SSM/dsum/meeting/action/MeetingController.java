package cn.dfx.share_record_SSM.dsum.meeting.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.dfx.share_record_SSM.dsum.base.pojo.Person;
import cn.dfx.share_record_SSM.dsum.mail.service.MailService;
import cn.dfx.share_record_SSM.dsum.meeting.pojo.Meeting;
import cn.dfx.share_record_SSM.dsum.meeting.pojo.MeetingComment;
import cn.dfx.share_record_SSM.dsum.meeting.service.MeetingService;
import cn.dfx.share_record_SSM.dsum.note.pojo.Note;
import net.sf.json.JSONArray;

/**
 * 会议内容及会议评论的前端控制器类
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/meeting")
public class MeetingController {
	
	@Autowired
	private MeetingService meetingService;
	@Autowired
	private MailService mailService;
	
	/*
	 * 会议页面的主方法
	 * 查询出本公司所有的会议内容
	 * 以及每条会议内容下的评论内容 显示在meeting.jsp
	 * */
	@RequestMapping(value="/goMain")
	public  String goMain(HttpServletRequest request){
		System.out.println("进入企业用户的会议记录页面！！！");
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		int identity = person.getIdentity();
		if( identity != 2){
			request.setAttribute("error", "非企业用户");
			return "error";
		}
		List<Meeting> allMeetings = meetingService.findAllMeetings(person.getCompanynum());
		request.setAttribute("allMeetings", allMeetings);
		
		List meetingComments = new ArrayList();
		for(int i=0;i<allMeetings.size();i++){
			int meetingid = allMeetings.get(i).getId();
			List<MeetingComment> meetingComment = meetingService.findMeetingCommentByMeetingId(meetingid);
			meetingComments.add(meetingComment);
		}
		System.out.println("进入企业用户的会议记录页面！！！-------------"+allMeetings.size());
		request.setAttribute("meetingComments", meetingComments);
		return "meeting/meeting";
	}
	
	/**
	 * 添加会议内容
	 * @param addTitle 会议主题
	 * @param addContent 会议内容
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/addMeeting")
	public String addMeeting(String addTitle,String addContent,HttpServletRequest request){
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		int identity = person.getIdentity();
		if( identity != 2){
			request.setAttribute("error", "非企业用户");
			return "redirect:index.jsp";
		}
		Meeting meeting = new Meeting();
		meeting.setTitle(addTitle);
		meeting.setContent(addContent);
		meeting.setCompanynum(person.getCompanynum());
		meeting.setUserid(person.getId());
		
		meetingService.add(meeting);
		return goMain(request);
	}
	
	/*修改会议内容请求的需要数据  数据回显*/
	@ResponseBody
	@RequestMapping(value="/toEditMeeting")
	public String toEditMeeting(int meetingid,HttpServletRequest request){
		System.out.println("进入编辑会议内容页面");
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "error";
		}
		Meeting meeting = new Meeting();
		meeting.setId(meetingid);
		List<Meeting> meetings = meetingService.findMeetingByCondition(meeting);
		if(meetings.size() == 1){
			request.setAttribute("meeting", meetings.get(0));
			JSONArray json = JSONArray.fromObject(meetings.get(0)); 
			System.out.println("进入编辑会议内容页面"+json);
	        return json.toString();
		}
		return "error";
	}
	
	
	
	
	/**
	 * 修改会议记录
	 * @param editTitle 修改后的会议主题
	 * @param editContent 修改后的会议内容
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/editMeeting")
	public String editMeeting(int editMeetingid,String editTitle,String editContent,HttpServletRequest request){
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		int identity = person.getIdentity();
		if( identity != 2){
			request.setAttribute("error", "非企业用户");
			return "redirect:index.jsp";
		}
		
		Meeting meeting1 = new Meeting();
		meeting1.setId(editMeetingid);
		List<Meeting> meetings = meetingService.findMeetingByCondition(meeting1);
		if(meetings.size() == 1){
			Meeting meeting = meetings.get(0);
			meeting.setTitle(editTitle);
			meeting.setContent(editContent);
			meetingService.edit(meeting);
		}
		
		return goMain(request);
	}
	
	/*删除会议内容*/
	@RequestMapping(value="/deleteMeeting")
	public String deleteMeeting(int id,HttpServletRequest request){
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		int identity = person.getIdentity();
		if( identity != 2){
			request.setAttribute("error", "非企业用户");
			return "redirect:index.jsp";
		}
		
		//删除会议评论内容
		List<MeetingComment> meetingComments = meetingService.findMeetingCommentByMeetingId(id);
		for(int i=0;i<meetingComments.size();i++){
			meetingService.deleteComment(meetingComments.get(i).getId());
		}
		
		//删除会议内容
		meetingService.delete(id);
		return goMain(request);
	}
	
	/**
	 * 添加会议评论内容
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/addMeetingComment")
	public String addComment(int meetingid,String commentContent,HttpServletRequest request){
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		int identity = person.getIdentity();
		if( identity != 2){
			request.setAttribute("error", "非企业用户");
			return "redirect:index.jsp";
		}
		//根据会议id查询出会议内容，取出会议的编写者id  userid
		Meeting meeting = new Meeting();
		meeting.setId(meetingid);
		List<Meeting> meetingComments = meetingService.findMeetingByCondition(meeting);
		int meetinguserid = meetingComments.get(0).getUserid();
		
		//创建评论对象，会议id，会议内容，评论者id以及会议发布者id存入该对象
		MeetingComment meetingComment = new MeetingComment();
		meetingComment.setMeetingid(meetingid);
		meetingComment.setContent(commentContent);
		meetingComment.setCommentid(person.getId());
		meetingComment.setMeetinguserid(meetinguserid);
		meetingService.addComment(meetingComment);
		
		return goMain(request);
		
	}
	
	
	//删除会议评论内容
	@RequestMapping(value="/deleteMeetingComment")
	public String deleteMeetingComment(int id,HttpServletRequest request){
		System.out.println("进入删除会议内容页面");
		meetingService.deleteComment(id);
		return goMain(request);
	}
	
}
