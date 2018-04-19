package cn.dfx.share_record_SSM.dsum.base.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.dfx.share_record_SSM.dsum.admin.pojo.Notice;
import cn.dfx.share_record_SSM.dsum.admin.service.NoticeService;
import cn.dfx.share_record_SSM.dsum.base.pojo.Person;
import cn.dfx.share_record_SSM.dsum.base.service.PersonService;
import cn.dfx.share_record_SSM.dsum.mail.action.MailController;
import cn.dfx.share_record_SSM.dsum.mail.pojo.Mail;
import cn.dfx.share_record_SSM.dsum.mail.service.MailService;
import cn.dfx.share_record_SSM.dsum.meeting.pojo.Meeting;
import cn.dfx.share_record_SSM.dsum.meeting.pojo.MeetingComment;
import cn.dfx.share_record_SSM.dsum.meeting.service.MeetingService;
import cn.dfx.share_record_SSM.dsum.note.pojo.Note;
import cn.dfx.share_record_SSM.dsum.note.pojo.NoteComment;
import cn.dfx.share_record_SSM.dsum.note.service.NoteService;
import cn.dfx.share_record_SSM.dsum.plan.pojo.Plan;
import cn.dfx.share_record_SSM.dsum.plan.service.PlanService;

/**
 * 用户登录注册的控制类
 * @author Administrator
 *
 */
@Controller
//@RequestMapping(value="/person")
public class PersonController {

	@Autowired
	private PersonService personService;
	@Autowired
	private MailService mailService;
	@Autowired
	private PlanService planService;
	@Autowired
	private NoteService noteService;
	@Autowired
	private MeetingService meetingService;
	@Autowired
	private NoticeService noticeService;
	
	/**
	 * 跳转到管理管理用户以及发布公告页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/toAdmin")
	public String toAdmin(HttpServletRequest request){
		//判断用户是否处于登录状态
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			return "redirect:index.jsp";
		}
		//先判断用户是否为管理员身份
		String admin = (String) request.getSession().getAttribute("admin");
		if(admin == null){
			return "redirect:index.jsp";
		}
		
		//新建空的Notice对象，无条件查询出所有的Notice
		Notice notice = new Notice();
		List<Notice> allNotice = noticeService.findByCondition(notice);
		request.setAttribute("allNotice", allNotice);
		return "base/admin";
	}
	
	/**
	 * 跳转到index.jsp
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/toIndex")
	public String toIndex(HttpServletRequest request){
		System.out.println("进入最index方法，查找最新的笔记和通告");
		//查询出最新的三条通告
		List<Notice> lastestNotice = noticeService.findHotNotice();
		request.getSession().setAttribute("lastestNotice", lastestNotice);
		//查询出最新的三条笔记
		List<Note> lastestNote = noteService.findHotNote();
		request.getSession().setAttribute("lastestNote", lastestNote);
		//查询出最新注册的用户
		List<Person> lastestPerson = mailService.findHotPerson();
		request.getSession().setAttribute("lastestPerson", lastestPerson);
		
		System.out.println("进入最index方法，查找最新的笔记和通告,用户 notice="+lastestNotice.size()+",note="+lastestNote.size()+",person="+lastestPerson.size());
		
		return "redirect: index.jsp";
	}
	
	
	//登录
	@RequestMapping(value="/person/goLogin",produces="text/html;charset=UTF-8")
	@ResponseBody//使用ajax完成登录，返回字符串
	public String login(String usernumm,String passwordd,int identityy,HttpServletRequest request){
		//将以往的session对象销毁，清除重新登录前的session信息
		HttpSession session = request.getSession(); 
		session.invalidate();
		
		//得到新的session对象，用来存储当前用户的数据
		session = request.getSession();
		
		Person person = personService.login(usernumm, passwordd, identityy);
		System.out.println("用户的身份是："+identityy+"账号为："+usernumm+",密码为："+passwordd);
		if(person == null){
			request.setAttribute("error", "用户名和密码以及身份不匹配");
			return "error";
		}else{
			//用户登录成功后跳转到主页面，并将用户信息存储到session内置对象里面
			session.setAttribute("person", person);
			
			//如果登录的用户为管理员，则单独保存管理员验证信息
			if(identityy == 3){
				request.getSession().setAttribute("admin", "admin");
			}
			return person.getUsername();
		}
	}
	
	
	//用户注册(先判断用户是否已经存在，存在返回error,注册失败，不存在返回correct 注册成功)
	@RequestMapping(value="/person/goRegist",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String regist(Person person,HttpServletRequest request){
		String usernum = person.getUsernum();
		String password = person.getPassword();
		int identity = person.getIdentity();
		Person person1 = personService.login(usernum, password, identity);
		if(person1 == null){
			personService.regist(person);
			return "correct";
		}
		return "error";
	}
	
	//转到mail.jsp
	@RequestMapping(value="/toMail",produces="text/html;charset=UTF-8")
	public String toMail(HttpServletRequest request){
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		
		//得到当前登录用户的id
		int recieveid = person.getId();
		
		//查询出所有的用户
		List<Person> allPerson = mailService.findAllPerson(new Person());
		request.setAttribute("allPerson", allPerson);
		request.setAttribute("person", person);
		
		//查询出用户所有的接收的邮件
		List<Mail> sendMails = mailService.findAllSendMails(recieveid);
		request.setAttribute( "sendMails", sendMails);
		int sendTotal = sendMails.size();
		request.setAttribute( "sendTotal", sendTotal);
		
		//将当前用户的所收到的邮件查询出来，存入request内置对象中
		List<Mail> recieveMails = mailService.findAllRecieveMails(recieveid);
		request.setAttribute( "recieveMails", recieveMails);
		int recieveTotal = recieveMails.size();
		request.setAttribute( "recieveTotal", recieveTotal);
		
		//查询出已读的邮件（当前用户已读---state=1）
		Mail mail1 = new Mail();
		mail1.setState(1);
		mail1.setRecieveid(recieveid);
		List<Mail> readMails = mailService.findByCondition(mail1);
		int readTotal = readMails.size();
		request.setAttribute( "readMails", readMails);
		request.setAttribute( "readTotal", readTotal);
		
		//查询出未读的邮件（当前用户未读---state=2）
		Mail mail2 = new Mail();
		mail2.setState(2);
		mail2.setRecieveid(recieveid);
		List<Mail> unreadMails = mailService.findByCondition(mail2);
		int unreadTotal = unreadMails.size();
		request.setAttribute( "unreadMails", unreadMails);
		request.setAttribute( "unreadTotal", unreadTotal);
		
		return "mail/mail";
	}
	
	//转到note.jsp
	@RequestMapping(value="/toNote",produces="text/html;charset=UTF-8")
	public String toNote(HttpServletRequest request){
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		
		//查询出所有的用户
		List<Person> allPerson = mailService.findAllPerson(new Person());
		request.setAttribute("allPerson", allPerson);
		
		//查询出所有公开的笔记以及当前用户的所有笔记
		Note note = new Note();
		note.setUserid(person.getId());
		note.setState("public");
		List<Note> allNotes = noteService.findAllNote(note);
		request.setAttribute("allNotes", allNotes);
		
		//根据笔记id查询出所有的笔记评论，将所有评论存入list集合
		List noteComments = new ArrayList();
		for(int i=0;i<allNotes.size();i++){
			int noteid = allNotes.get(i).getId();
			List<NoteComment> noteComment = noteService.findNoteCommentsByNoteId(noteid);
			noteComments.add(noteComment);
		}
		request.setAttribute("noteComments", noteComments);
		return "note/note";
	}
	
	//转到meeting.jsp
	@RequestMapping(value="/toMeeting",produces="text/html;charset=UTF-8")
	public String toMeeting(HttpServletRequest request){
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
			return "redirect:index.jsp";
		}
		
		//查询出当前用户所属公司的所有会议内容
		List<Meeting> allMeetings = meetingService.findAllMeetings(person.getCompanynum());
		request.setAttribute("allMeetings", allMeetings);
		
		//根据会议内容主键查询出对应的会议评论内容
		List meetingComments = new ArrayList();
		for(int i=0;i<allMeetings.size();i++){
			int meetingid = allMeetings.get(i).getId();
			List<MeetingComment> meetingComment = meetingService.findMeetingCommentByMeetingId(meetingid);
			meetingComments.add(meetingComment);
		}
		request.setAttribute("meetingComments", meetingComments);
		
		System.out.println("进入企业用户的会议记录页面！！！-------------"+allMeetings.size());
		return "meeting/meeting";
	}
	
	//转到plan.jsp
	@RequestMapping(value="/toPlan",produces="text/html;charset=UTF-8")
	public String toPlan(HttpServletRequest request){
		System.out.println("进入查询出所有的计划，person--plan");
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		
		//根据当前登录的用户查询出该用户的所有每日计划
		int userid = person.getId();
		List<Plan> allPlan = planService.findAllPlan(userid);
		request.setAttribute("allPlan", allPlan);
		
		return "plan/plan";
	}
	
}
