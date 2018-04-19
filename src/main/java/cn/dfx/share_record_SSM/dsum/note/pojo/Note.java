package cn.dfx.share_record_SSM.dsum.note.pojo;

import java.util.Date;

/**
 * 笔记实体类
 * @author Administrator
 *
 */
public class Note {

	private int id;
	private int userid;
	private String title;
	private String content;
	private Date createtime;
	private String state;
	
	public Note(){}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	
}
