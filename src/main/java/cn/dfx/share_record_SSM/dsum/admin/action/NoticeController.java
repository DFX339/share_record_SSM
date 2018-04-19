package cn.dfx.share_record_SSM.dsum.admin.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.dfx.share_record_SSM.dsum.admin.pojo.Notice;
import cn.dfx.share_record_SSM.dsum.admin.service.NoticeService;
import cn.dfx.share_record_SSM.dsum.base.pojo.Person;
import cn.dfx.share_record_SSM.dsum.mail.service.MailService;
import net.sf.json.JSONArray;

/**
 * 通告的前端控制器类
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/notice")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	@Autowired
	private MailService mailService;
	
	/**
	 * 进到管理用户的主页面，显示用户信息
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/toAdmin")
	public String toNotice(HttpServletRequest request){
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
	 * 添加通告请求
	 * @param content
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(method=RequestMethod.GET,value="/addNotice",produces="text/html;charset=UTF-8")
	public String addNotice(String content,HttpServletRequest request) {
		content = request.getParameter("content");
		try {
			content = URLDecoder.decode(content,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			System.out.println("添加通告内容--Get请求编码异常，无法正常切换为中文字符");
		}
		System.out.println("进入添加通告的controller----"+content);
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
		
		int userid = person.getId();
		Notice notice = new Notice();
		notice.setContent(content);
		notice.setCreateid(userid);
		noticeService.addNotice(notice);
		System.out.println("进入添加通告的controller---通告添加成功");
		return toNotice(request);
	}
	
	/**
	 * 删除通告
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/deleteNotice")
	public String deleteNotice(int id,HttpServletRequest request){
		System.out.println("进入删除通告的controller");
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
		
		noticeService.deleteNotice(id);
		return toNotice(request);
	}
	
	/**
	 * 用户管理
	 * @param request
	 * @return
	 */
	//@ResponseBody
	@RequestMapping(value="/toUsers")
	public String toUsers(HttpServletRequest request){
		//判断用户是否处于登录状态
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			return "error";
		}
		//先判断用户是否为管理员身份
		String admin = (String) request.getSession().getAttribute("admin");
		if(admin == null){
			return "error";
		}
		
		//查询出所有的用户
		List<Person> allPerson = mailService.findAllPerson(new Person());
		request.setAttribute("allPerson", allPerson);
		return "base/admin";
	}
	
	@RequestMapping(value="/deleteUser")
	public String deleteUser(int id,HttpServletRequest request){
		//判断用户是否处于登录状态
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			return "error";
		}
		//先判断用户是否为管理员身份
		String admin = (String) request.getSession().getAttribute("admin");
		if(admin == null){
			return "error";
		}
		
		mailService.deletePerson(id);
		return toUsers(request);
	}
}
