package cn.dfx.share_record_SSM.dsum.meeting.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.dfx.share_record_SSM.dsum.meeting.mapper.MeetingCommentMapper;
import cn.dfx.share_record_SSM.dsum.meeting.mapper.MeetingMapper;
import cn.dfx.share_record_SSM.dsum.meeting.pojo.Meeting;
import cn.dfx.share_record_SSM.dsum.meeting.pojo.MeetingComment;
/**
 * 业务层 会议实现类
 * @author Administrator
 *
 */
public class MeetingService implements MeetingIService{

	@Autowired
	private MeetingMapper meetingMapper;
	
	@Autowired
	private MeetingCommentMapper meetingCommentMapper;
	
	//添加会议内容
	@Override
	public void add(Meeting meeting) {
		Date createtime = new Date();
		meeting.setCreatetime(createtime);
		meetingMapper.add(meeting);
	}
	
	//修改会议内容
	@Override
	public void edit(Meeting meeting) {
		Date createtime = new Date();
		meeting.setCreatetime(createtime);
		meetingMapper.edit(meeting);
	}
	
	//删除会议内容
	@Override
	public void delete(int id) {
		meetingMapper.delete(id);
	}

	//查询本公司的所有会议内容
	@Override
	public List<Meeting> findAllMeetings(String companynum) {
		return meetingMapper.findAllMeetings(companynum);
	}

	//知道条件查询本公司的会议内容
	@Override
	public List<Meeting> findMeetingByCondition(Meeting meeting) {
		return meetingMapper.findMeetingByCondition(meeting);
	}

	//添加会议评论内容
	@Override
	public void addComment(MeetingComment meetingComment) {
		Date createtime = new Date();
		meetingComment.setCreatetime(createtime);
		meetingCommentMapper.addComment(meetingComment);
	}
	
	//删除会议评论内容
	@Override
	public void deleteComment(int id) {
		meetingCommentMapper.deleteComment(id);
	}
	
	//根据会议id查询出会议评论内容
	@Override
	public List<MeetingComment> findMeetingCommentByMeetingId(int meetingid) {
		return meetingCommentMapper.findMeetingCommentByMeetingId(meetingid);
	}

}
