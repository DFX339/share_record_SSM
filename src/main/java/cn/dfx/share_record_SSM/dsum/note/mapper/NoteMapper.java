package cn.dfx.share_record_SSM.dsum.note.mapper;

import java.util.List;

import cn.dfx.share_record_SSM.dsum.note.pojo.Note;
import cn.dfx.share_record_SSM.dsum.note.pojo.NoteComment;

/**
 * 笔记持久层接口设计类
 * @author Administrator
 *
 */

public interface NoteMapper {
	
	public void add(Note note);//添加会议笔记内容
	
	public void edit(Note note);//修改笔记内容
	
	public void delete(int id);//删除笔记内容
	
	public List<Note> findAllNote(Note note);//查看所有公开笔记以及当前用户的笔记
	
	public List<Note> findNoteByCondition(Note note);//根据用户的条件查询出笔记

	public List<Note> findHotNote();//查看最新的三条笔记

	

}
