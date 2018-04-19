package cn.dfx.share_record_SSM.dsum.admin.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.dfx.share_record_SSM.dsum.admin.mapper.NoticeMapper;
import cn.dfx.share_record_SSM.dsum.admin.pojo.Notice;
/**
 * 通告业务层设计的接口实现类
 * @author Administrator
 *
 */
public class NoticeService implements NoticeIService {
	
	@Autowired
	private NoticeMapper noticeMapper;
	
	/**
	 * 添加通告
	 */
	@Override
	public void addNotice(Notice notice) {
		Date createtime = new Date();
		notice.setCreatetime(createtime);
		noticeMapper.addNotice(notice);
	}
	
	/**
	 * 编辑通告
	 */
	@Override
	public void editNotice(Notice notice) {
		Date createtime = new Date();
		notice.setCreatetime(createtime);
		noticeMapper.editNotice(notice);
	}

	/**
	 * 查询通告
	 */
	@Override
	public List<Notice> findByCondition(Notice notice) {
		return noticeMapper.findByCondition(notice);
	}
	
	/**
	 * 删除通告
	 */
	@Override
	public void deleteNotice(int id) {
		noticeMapper.deleteNotice(id);
	}
	
	/**
	 * 查看最新通告
	 */
	@Override
	public List<Notice> findHotNotice() {
		
		return noticeMapper.findHotNotice();
	}

}
