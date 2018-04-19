package cn.dfx.share_record_SSM.dsum.plan.pojo;

import java.util.Date;
/**
 * 今日计划的实体类
 * @author Administrator
 *
 */
public class Plan {
	
	private int id;
	private int userid;
	private String content;
	private Date createtime;
	
	public Plan(){}

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
