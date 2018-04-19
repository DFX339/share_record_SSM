package cn.dfx.share_record_SSM.dsum.note.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.dfx.share_record_SSM.dsum.note.mapper.NoteCommentMapper;
import cn.dfx.share_record_SSM.dsum.note.mapper.NoteMapper;
import cn.dfx.share_record_SSM.dsum.note.pojo.Note;
import cn.dfx.share_record_SSM.dsum.note.pojo.NoteComment;
/**
 * 业务层笔记接口实现类 
 * @author Administrator
 *
 */
public class NoteService implements NoteIService{

	@Autowired
	private NoteMapper noteMapper;
	
	@Autowired
	private NoteCommentMapper noteCommentMapper;
	
	//添加笔记
	@Override
	public void add(Note note) {
		Date createtime = new Date();
		note.setCreatetime(createtime);
		noteMapper.add(note);
	}
	
	//修改笔记
	@Override
	public void edit(Note note) {
		Date createtime = new Date();
		note.setCreatetime(createtime);
		noteMapper.edit(note);
	}
	
	//删除笔记
	@Override
	public void delete(int id) {
		noteMapper.delete(id);
	}
	
	//查看所有笔记
	@Override
	public List<Note> findAllNote(Note note) {
		return noteMapper.findAllNote(note);
	}

	//添加笔记评论
	@Override
	public void addComment(NoteComment noteComment) {
		Date createtime = new Date();
		noteComment.setCreatetime(createtime);
		noteCommentMapper.addComment(noteComment);
	}

	//删除笔记评论
	@Override
	public void deleteComment(int id) {
		noteCommentMapper.deleteComment(id);
	}
	
	//根据笔记id查看笔记评论
	@Override
	public List<NoteComment> findNoteCommentsByNoteId(int noteid) {
		return noteCommentMapper.findNoteCommentsByNoteId(noteid);
	}

	public List<Note> findNoteByCondition(Note note){
		return noteMapper.findNoteByCondition(note);
	}
	
	//查看最新笔记
	public List<Note> findHotNote() {
		return noteMapper.findHotNote();
	}

	public NoteComment findNoteCommentById(int id) {
		return noteCommentMapper.findNoteCommentById(id);
	}
}
