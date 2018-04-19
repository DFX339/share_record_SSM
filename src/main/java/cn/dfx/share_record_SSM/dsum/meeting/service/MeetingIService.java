package cn.dfx.share_record_SSM.dsum.meeting.service;

import java.util.List;

import cn.dfx.share_record_SSM.dsum.meeting.mapper.MeetingCommentMapper;
import cn.dfx.share_record_SSM.dsum.meeting.pojo.Meeting;
import cn.dfx.share_record_SSM.dsum.meeting.pojo.MeetingComment;

/**
 * 业务层会议记录的接口设计类
 * @author Administrator
 *
 */
public interface MeetingIService {

public void add(Meeting meeting);//添加会议
	
	public void edit(Meeting meeting);//修改会议
	
	public  void delete(int id);//删除会议
	
	public List<Meeting> findAllMeetings(String companynum);//根据公司编号查询出该公司的所有会议记录内容
	
	public List<Meeting> findMeetingByCondition(Meeting meeting);//根据用户的条件查询出会议内容

	public void addComment(MeetingComment meetingComment);//添加会议评论
	
	public void deleteComment(int id);//删除会议评论
	
	public List<MeetingComment> findMeetingCommentByMeetingId(int meetingid);//根据会议内容id查询出该条记录的所有评论
	
}
