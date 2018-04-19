package cn.dfx.share_record_SSM.dsum.note.service;

import java.util.List;

import cn.dfx.share_record_SSM.dsum.note.pojo.Note;
import cn.dfx.share_record_SSM.dsum.note.pojo.NoteComment;

/**
 * 笔记业务层的接口类
 * @author Administrator
 *
 */
public interface NoteIService {

	public void add(Note note);//添加会议笔记内容
	
	public void edit(Note note);//修改笔记内容
	
	public void delete(int id);//删除笔记内容
	
	public List<Note> findHotNote();//查看最新的三条笔记
	
	public List<Note> findAllNote(Note note);//查看所有公开笔记以及当前用户的笔记
	
	public void addComment(NoteComment noteComment);//添加笔记评论
	
	public void deleteComment(int  id);//删除笔记评论
	
	public List<NoteComment> findNoteCommentsByNoteId(int noteid);//根据笔记评论id查看该笔记的笔记评论
	
	public NoteComment findNoteCommentById(int id);//根据评论id查询该评论
}
