package cn.dfx.share_record_SSM.dsum.mail.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import cn.dfx.share_record_SSM.dsum.base.pojo.Person;
import cn.dfx.share_record_SSM.dsum.mail.pojo.Mail;
import cn.dfx.share_record_SSM.dsum.mail.service.MailService;
import net.sf.json.JSONArray;

/***
 * 邮件的前端控制器类
 * @author Administrator
 *
 */

@Controller
@RequestMapping("/mail")
public class MailController {
	
	@Autowired
	private MailService mailService;
	
	//进入邮件的主页面（显示所有的已接收的邮件）
	@RequestMapping(value="/goMain",produces="text/html;charset=UTF-8")
	public String goMain(HttpServletRequest request){
		//得到当前登录用户的id
		Person person = (Person)request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
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
		System.out.println("已读邮件的数目"+readTotal+"----"+readMails);
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
	
	//进入发送邮件（显示所有的已发送的邮件）
	@RequestMapping(value="/goSendmailsPage",produces="application/json;charset=UTF-8")
	@ResponseBody
	public String findAllSendMails(HttpServletRequest request){
		Person person = (Person)request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "error";
		}
		int sendid = person.getId();
		
		//查询出所有的用户
		List<Person> allPerson = mailService.findAllPerson(new Person());
		request.setAttribute("allPerson", allPerson);
		request.setAttribute("person", person);
		
		List<Mail> sendMails = mailService.findAllSendMails(sendid);
		request.setAttribute( "sendMails", sendMails);
		int sendTotal = sendMails.size();
		request.setAttribute( "sendTotal", sendTotal);
		JSONArray json = JSONArray.fromObject(sendMails); 
        return json.toString();
	}
	
	//进入接收邮件（显示所有的已接收的邮件）
	@RequestMapping(value="/goRecievemailsPage",produces="application/json;charset=UTF-8")
	@ResponseBody
	public String findAllRecieveMails(HttpServletRequest request){
		Person person = (Person)request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "error";
		}
		int sendid = person.getId();
		
		//查询出所有的用户
		List<Person> allPerson = mailService.findAllPerson(new Person());
		request.setAttribute("allPerson", allPerson);
		request.setAttribute("person", person);
		
		List<Mail> recieveMails = mailService.findAllRecieveMails(sendid);
		request.setAttribute( "recieveMails", recieveMails);
		int recieveTotal = recieveMails.size();
		request.setAttribute( "recieveTotal", recieveTotal);
		
		JSONArray json = JSONArray.fromObject(recieveMails); 
        return json.toString();
	}
	
	//进入接收邮件 已读（显示所有的已读的邮件）
	@RequestMapping(value="/gofindAllReadMails",produces="application/json;charset=UTF-8")
	@ResponseBody
	public String findAllReadMails(HttpServletRequest request){
		Person person = (Person)request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "error";
		}
		int recieveid = person.getId();
		
		//查询出所有的用户
		List<Person> allPerson = mailService.findAllPerson(new Person());
		request.setAttribute("allPerson", allPerson);
		request.setAttribute("person", person);
		
		//根据条件查询出用户已读的邮件（1，收件人为当前用户，2邮件状态为已读 state=1）
		Mail  mail = new Mail();
		mail.setRecieveid(recieveid);
		mail.setState(1);
		List<Mail> readMails = mailService.findByCondition(mail);
		request.setAttribute( "readMails", readMails);
		int readTotal = readMails.size();
		request.setAttribute( "readTotal", readTotal);
		
		JSONArray json = JSONArray.fromObject(readMails); 
		return json.toString();
	}
	
	//进入接收邮件 未读（显示所有的未读的邮件）（1，收件人为当前用户，2邮件状态为未读 state=2）
	@RequestMapping(value="/gofindAllUnreadMails",produces="application/json;charset=UTF-8")
	@ResponseBody
	public String findAllUnreadMails(HttpServletRequest request){
		Person person = (Person)request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "error";
		}
		int recieveid = person.getId();
		
		//查询出所有的用户
		List<Person> allPerson = mailService.findAllPerson(new Person());
		request.setAttribute("allPerson", allPerson);
		request.setAttribute("person", person);
		
		//根据条件查询出用户已读的邮件（1，收件人为当前用户，2邮件状态为已读 state=1）
		Mail  mail = new Mail();
		mail.setRecieveid(recieveid);
		mail.setState(2);
		List<Mail> unreadMails = mailService.findByCondition(mail);
		request.setAttribute( "unreadMails", unreadMails);
		int unreadTotal = unreadMails.size();
		request.setAttribute( "unreadTotal", unreadTotal);
		
		JSONArray json = JSONArray.fromObject(unreadMails); 
		return json.toString();
	}
	
	
	//查看邮件具体信息
	@RequestMapping(value="/findById",produces="application/json;charset=UTF-8")
	@ResponseBody
	public String findMailById(int id,HttpServletRequest request){
		Person person = (Person)request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "error";
		}
		int recieveid = person.getId();
		
		System.out.println("查看信件詳細內容----mail  detail");
		Mail mail = mailService.findMailById(id);
		//判断当前查看的邮件是否为收到的邮件，如果是就修改邮件状态 state：1表示已读，2表示未读
		if(mail.getRecieveid() == recieveid){
			int state = mail.getState();
			if(state > 1){
				state=state-1;
			}
			mail.setState(state);
			mailService.editState(mail);//修改邮件状态
		}
		JSONArray json = JSONArray.fromObject(mail); 
		System.out.println("查看信件詳細內容----mail  detail--"+json.toString());
		return json.toString();
	}
	
	//编辑并且重发邮件
	@RequestMapping(value="/editAndSend",produces="text/html;charset=UTF-8")
	public String editAndSend(Mail mail,HttpServletRequest request){
		Mail mail1 = mailService.findMailById(mail.getId());
		Date createtime = new Date();
		mail1.setCreatetime(createtime);
		mailService.add(mail1);
		return goMain(request);
	}
	
	//删除邮件
	@RequestMapping(value="/goDelete",produces="text/html;charset=UTF-8")
	public String delete(String id,HttpServletRequest request){
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		String[] ids = id.split(",");
		for(int i=0;i<ids.length;i++){
			mailService.delete(new Integer(ids[i]));
		}
		return goMain(request);
	}
	
	//发送邮件
	@RequestMapping(value="/send",produces="text/html;charset=UTF-8")
	public String sendMail(Mail mail,HttpServletRequest request){
		//得到当前登录用户的id，作为发送站内信的sendId
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		mail.setSendid(person.getId());
		
		//得到页面的收件人信息参数值
		String recieveIDS = request.getParameter("recievers");
		String[] recieveIds = recieveIDS.split(";");//切割字符串 ，以；分隔
			/**
			 * 根据收件人的人数，循环取出收件人id，并且设定state,
			 * 发送站内信
			 */
			for(int i =0;i<recieveIds.length;i++){
				//截取出字符串的id字段，_之前的数据
				int index = recieveIds[i].indexOf("_");
				recieveIds[i] = recieveIds[i].substring(0, index);
				//判断收件人和发件人是否为同一个人
				if(new Long(recieveIds[i]) != person.getId()){
					mail.setState(2);
					mail.setRecieveid(new Integer(recieveIds[i]));
					mailService.add(mail);
				}
			}
			
		return goMain(request);
	}
	
	//模糊查询所发送的邮件
	@RequestMapping(value="/findSendByCondition",produces="application/json;charset=UTF-8")
	@ResponseBody
	public String findSendByCondition(Mail mail,HttpServletRequest request){
		System.out.println("進入 帶參數的查詢信件信息"+mail.getContent()+mail.getId()+mail.getTitle());
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "error";
		}
		//查询出所有用户，并将用户存储到request中
		List<Person> allPerson = mailService.findAllPerson(new Person());
		request.setAttribute("allPerson",allPerson);
		request.setAttribute("person",person);
		
		mail.setSendid(person.getId());
		List<Mail> mailList = mailService.findByCondition(mail);
		request.setAttribute("mailList", mailList);
		JSONArray json = JSONArray.fromObject(mailList); 
        return json.toString();
	}
	
	//模糊查询所发送的邮件  解决返回json数据中文乱码问题  在RequestMapping中配置 produces="application/json;charset=UTF-8"
	@RequestMapping(value="/findRecieveByCondition",produces="application/json;charset=UTF-8")
	@ResponseBody
	public String findRecieveByCondition(Mail mail,HttpServletRequest request){
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "error";
		}
		//查询出所有用户，并将用户存储到request中
		List<Person> allPerson = mailService.findAllPerson(person);
		request.setAttribute("allPerson",allPerson);
		request.setAttribute("person",person);
		
		mail.setRecieveid(person.getId());
		List<Mail> mailList = mailService.findByCondition(mail);
		request.setAttribute("mailList", mailList);
		System.out.println("進入 帶參數的查詢信件信息"+mail.getContent());
		JSONArray json = JSONArray.fromObject(mailList); 
		return json.toString();
	}
	
	//查询出所有用户信息，存储到request中
	@RequestMapping(value="/findAllPerson")
	@ResponseBody
	public  String  findAllPerson(Person person,HttpServletRequest request){
		System.out.println("********************------"+person);
		List<Person> allPerson =null;
		Person person1 = (Person) request.getSession().getAttribute("person");
		if(person1 == null){
			request.setAttribute("error", "非法用户");
			return "error";
		}
		if(person == null || person.equals("")){
			allPerson = mailService.findAllPerson(new Person());
		}else{
			allPerson = mailService.findAllPerson(person);
		}
		request.setAttribute("allPerson",allPerson);
		System.out.println("查询所有用户 按照条件查询--"+person.getId()+"--"+person.getUsername()+"--"+person.getCompanynum()+"-"+person.getUsernum());
		System.out.println("查询所有用户结束---被调用allPerson.size()="+allPerson.size());
		JSONArray json = JSONArray.fromObject(allPerson); 
		System.out.println("查询所有用户结束---被调用allPerson="+json.toString());
        return json.toString();
	}

}
