package cn.dfx.share_record_SSM.dsum.note.pojo;

import java.util.Date;

/**
 * 笔记评论的实体类
 * @author Administrator
 *
 */
public class NoteComment {
	
	private int id;
	private int noteid;
	private int noteuserid;
	private int commentid;
	private String content;
	private Date createtime;
	
	public NoteComment(){}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getNoteid() {
		return noteid;
	}

	public void setNoteid(int noteid) {
		this.noteid = noteid;
	}

	public int getNoteuserid() {
		return noteuserid;
	}

	public void setNoteuserid(int noteuserid) {
		this.noteuserid = noteuserid;
	}

	public int getCommentid() {
		return commentid;
	}

	public void setCommentid(int commentid) {
		this.commentid = commentid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
	
	
	
}
