package cn.dfx.share_record_SSM.dsum.meeting.mapper;

import java.util.List;

import cn.dfx.share_record_SSM.dsum.meeting.pojo.MeetingComment;

/**
 * 会议内容评论持久层接口设计
 * @author Administrator
 *
 */
public interface MeetingCommentMapper {
	
	public void addComment(MeetingComment meetingComment);//添加会议评论
	
	public void deleteComment(int id);//删除会议评论
	
	public List<MeetingComment> findMeetingCommentByMeetingId(int meetingid);//根据会议内容id查询出该条记录的所有评论
	
}
