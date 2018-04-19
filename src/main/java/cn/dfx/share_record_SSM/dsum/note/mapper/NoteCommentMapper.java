package cn.dfx.share_record_SSM.dsum.note.mapper;

import java.util.List;

import cn.dfx.share_record_SSM.dsum.note.pojo.NoteComment;

/**
 * 笔记评论的持久层接口设计
 * @author Administrator
 *
 */
public interface NoteCommentMapper {

	public void addComment(NoteComment noteComment);//添加笔记评论
	
	public void deleteComment(int  id);//删除笔记评论
	
	public List<NoteComment> findNoteCommentsByNoteId(int noteid);//根据笔记评论id查看该笔记的笔记评论
	
	public NoteComment findNoteCommentById(int id);//根据评论id查询该评论
}
