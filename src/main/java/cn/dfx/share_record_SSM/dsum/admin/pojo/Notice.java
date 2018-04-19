package cn.dfx.share_record_SSM.dsum.admin.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 * 通告实体类 (管理员发布通告)
 * @author Administrator
 * @2018/1/11
 */
public class Notice implements Serializable{
	
	private int id;
	private String content;
	private Date createtime;
	private int createid;
	
	public Notice(){}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public int getCreateid() {
		return createid;
	}

	public void setCreateid(int createid) {
		this.createid = createid;
	}
	
	
}
