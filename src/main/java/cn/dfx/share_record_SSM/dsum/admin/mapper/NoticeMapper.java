package cn.dfx.share_record_SSM.dsum.admin.mapper;

import java.util.List;

import cn.dfx.share_record_SSM.dsum.admin.pojo.Notice;

/**
 * 管理员对通告管理的接口设计
 * @author Administrator
 * @2018/1/11
 */
public interface NoticeMapper {
	
	/**
	 * 添加通告
	 * @param notice
	 */
	void addNotice(Notice notice);
	
	/**
	 * 编辑通告
	 * @param notice
	 */
	void editNotice(Notice notice);
	
	/**
	 * 按指定条件查询通告
	 * @param notice
	 * @return
	 */
	List<Notice> findByCondition(Notice notice);
	
	/**
	 * 删除通告
	 * @param id
	 */
	void deleteNotice(int id);
	
	/**
	 * 查看热门笔记，显示在index页面
	 * @return
	 */
	List<Notice> findHotNotice();
}
