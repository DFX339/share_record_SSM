package cn.dfx.share_record_SSM.dsum.plan.mapper;

import java.util.List;

import cn.dfx.share_record_SSM.dsum.plan.pojo.Plan;

/**
 * 今日计划的持久层接口设计
 * @author Administrator
 *
 */
public interface PlanMapper {
	
	public Integer add(Plan plan);//添加计划
	
	public Integer edit(Plan plan);//修改计划
	
	public void delete(int id);//删除计划
	
	public List<Plan> findByCondition(Plan plan);//根据id查找计划
	
	public List<Plan> findAllPlan(int userid);//查看所有plan
	
}
