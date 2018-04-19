package cn.dfx.share_record_SSM.dsum.mail.pojo;

import java.util.Date;

/**
 * 邮件的实体类
 * @author Administrator
 *
 */
public class Mail {

	private int id;
	private int sendid;
	private int recieveid;
	private String content;
	private String title;
	private Date createtime;
	private int state;
	
	public Mail(){}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getSendid() {
		return sendid;
	}

	public void setSendid(int sendid) {
		this.sendid = sendid;
	}

	public int getRecieveid() {
		return recieveid;
	}

	public void setRecieveid(int recieveid) {
		this.recieveid = recieveid;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}
	
	
}
