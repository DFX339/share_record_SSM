package cn.dfx.share_record_SSM.dsum.meeting.pojo;

import java.util.Date;

/**
 * 会议评论的实体类
 * 
 * */
public class MeetingComment {
	
	private int id;
	private int meetingid;
	private int meetinguserid;
	private int commentid;
	private Date createtime;
	private String content;
	
	public MeetingComment(){}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getMeetingid() {
		return meetingid;
	}

	public void setMeetingid(int meetingid) {
		this.meetingid = meetingid;
	}

	public int getMeetinguserid() {
		return meetinguserid;
	}

	public void setMeetinguserid(int meetinguserid) {
		this.meetinguserid = meetinguserid;
	}

	public int getCommentid() {
		return commentid;
	}

	public void setCommentid(int commentid) {
		this.commentid = commentid;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	
}
