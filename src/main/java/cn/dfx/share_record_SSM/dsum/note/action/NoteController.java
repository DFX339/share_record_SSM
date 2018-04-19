package cn.dfx.share_record_SSM.dsum.note.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.dfx.share_record_SSM.dsum.base.pojo.Person;
import cn.dfx.share_record_SSM.dsum.mail.service.MailService;
import cn.dfx.share_record_SSM.dsum.note.pojo.Note;
import cn.dfx.share_record_SSM.dsum.note.pojo.NoteComment;
import cn.dfx.share_record_SSM.dsum.note.service.NoteService;
import net.sf.json.JSONArray;

/**
 * 笔记内容及笔记评论的前端控制器类
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/note")
public class NoteController {

	@Autowired
	private NoteService noteService;
	@Autowired
	private MailService mailService;
	
	/**
	 * 笔记页面的主方法
	 * 查询出个人所有笔记以及系统用户所有的公开笔记
	 * 每条笔记的评论内容 显示在note.jsp页面
	 */
	@RequestMapping(value="/goMain")
	public String goMain(HttpServletRequest request){
		System.out.println("查询所有笔记");
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
	
	/**
	 * 添加笔记内容
	 * @param addTitle
	 * @param addContent
	 * @param state
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/addNote")
	public String addNote(String addTitle,String addContent,String state,HttpServletRequest request){
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		Note  note = new Note();
		note.setTitle(addTitle);
		note.setContent(addContent);
		note.setState(state);
		note.setUserid(person.getId());
		noteService.add(note);
		return goMain(request);
	}
	
	/**
	 * 添加笔记评论内容
	 * @param addTitle
	 * @param addContent
	 * @param state
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/addNoteComment")
	public String addNoteComment(String commentNoteContent,int noteid,HttpServletRequest request){
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		Note note  = new Note();
		note.setId(noteid);
		List<Note> notes =  noteService.findNoteByCondition(note);
		int noteuserid = notes.get(0).getUserid();
		System.out.println("笔记id:"+noteid+"根据笔记ID查询出来的笔记，取出笔记的userid:"+noteuserid);
		
		NoteComment noteComment = new NoteComment();
		noteComment.setCommentid(person.getId());
		noteComment.setContent(commentNoteContent);
		noteComment.setNoteid(noteid);
		noteComment.setNoteuserid(noteuserid);
		noteService.addComment(noteComment);
		
		return goMain(request);
	}
	
	/**
	 * 删除笔记评论
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/deleteComment")
	public String deleteComment(int id,HttpServletRequest request){
		System.out.println("进入删除笔记评论页面--");
		//判断当前用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		//得到当前登录用户后，判断当前用户是否是该评论的发布者或者接受者，如果是就有权限删除该条评论内容，不是则没有
		int userid = person.getId();
		//根据评论id查询出该条评论内容详细信息
		NoteComment noteCom = noteService.findNoteCommentById(id);
		int cuserid = noteCom.getNoteuserid();//得到笔记发布者的id
		int ccomid= noteCom.getCommentid();//得到笔记评论者的id
		System.out.println("进入删除笔记评论页面--，当前用户的id为:"+userid+",笔记评论的用户id为："+cuserid+",评论者的id为："+ccomid);
		if(userid == cuserid || userid == ccomid){
			noteService.deleteComment(id);
		}
			return goMain(request);
	}
	
	/**
	 * 删除笔记内容（带评论一起删除）
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/deleteNote")
	public String deleteNote(int id,HttpServletRequest request){
		System.out.println("进入删除笔记页面--");
		//判断当前用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		int userid = person.getId();
		
		//根据笔记id查询出该条笔记内容
		Note note = new Note();
		note.setId(id);
		List<Note> note1 = noteService.findNoteByCondition(note);
		int nuserid  = note1.get(0).getUserid();//得到该笔记的发布者id
		System.out.println("进入删除笔记页面--，当前用户的id为:"+userid+",笔记的用户id为："+nuserid);
		//判断笔记发布者的id是否和当前登录用户的id相同，相同则可以执行删除，不同则不能执行
		if(userid == nuserid){
			//先删除该笔记对应的笔记评论
			List<NoteComment> commentList = noteService.findNoteCommentsByNoteId(id);
			for(int i=0;i<commentList.size();i++){
				noteService.deleteComment(commentList.get(i).getId());
			}
			//删除该笔记内容
			noteService.delete(id);
		}
		return goMain(request);
	}
	
	
	/**
	 * 查看当前用户的笔记
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/findMyNotes")
	public String findMyNotes(HttpServletRequest request){
		System.out.println("查询当前用户的所有笔记");
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
		List<Note> allNotes = noteService.findNoteByCondition(note);
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
	
	
	/**
	 * 去修改笔记，跳转到修改笔记的页面
	 * @param noteid
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/toEditNote",produces = "application/json; charset=UTF-8")
	public String toEditNote(int noteid,HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=UTF-8");
		System.out.println("进入编辑笔记页面");
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "error";
		} 
		int userid = person.getId();
		
		Note note = new Note();
		note.setId(noteid);
		List<Note> notes = noteService.findNoteByCondition(note);
		if(notes.size() == 1){
			//判断当前用户是否为该笔记内容的发布者，如果是 则可以执行编辑。反之则不可以
			int nuserid = notes.get(0).getUserid();
			System.out.println("进入编辑笔记页面---当前用户的id 为："+userid+",笔记发布者的id为："+nuserid);
			if(userid == nuserid){
				request.setAttribute("note", notes.get(0));
				JSONArray json = JSONArray.fromObject(notes.get(0)); 
				System.out.println("进入编辑笔记页面"+json.toString());
		        return json.toString();
			}
		}
		return "error";
	}
	
	
	/**
	 * 实现修改笔记功能
	 * @param editNoteid
	 * @param editTitle
	 * @param editContent
	 * @param statee
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/editNote")
	public String editNote(int editNoteid,String editTitle,String editContent,String statee,HttpServletRequest request){
		System.out.println("进入编辑笔记页面");
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		Note note1 = new Note();
		note1.setId(editNoteid);
		List<Note> notes = noteService.findNoteByCondition(note1);
		if(notes.size() == 1){
			Note note = notes.get(0);
			note.setTitle(editTitle);
			note.setContent(editContent);
			note.setState(statee);
			note.setCreatetime(new Date());
			noteService.edit(note);
			return goMain(request);
		}else{
			return "redirect:index.jsp";
		}
	}
	
}
