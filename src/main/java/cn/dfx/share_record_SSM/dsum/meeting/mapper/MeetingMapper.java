package cn.dfx.share_record_SSM.dsum.meeting.mapper;

import java.util.List;

import cn.dfx.share_record_SSM.dsum.meeting.pojo.Meeting;

/**
 * 会议内容的持久层接口定义
 * @author Administrator
 *
 */
public interface MeetingMapper {

	public void add(Meeting meeting);//添加会议
	
	public void edit(Meeting meeting);//修改会议
	
	public  void delete(int id);//删除会议
	
	public List<Meeting> findAllMeetings(String companynum);//根据公司编号查询出该公司的所有会议记录内容
	
	public List<Meeting> findMeetingByCondition(Meeting meeting);//根据用户的条件查询出会议内容
}
