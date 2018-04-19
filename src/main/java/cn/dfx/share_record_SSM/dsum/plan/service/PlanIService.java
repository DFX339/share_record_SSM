package cn.dfx.share_record_SSM.dsum.plan.service;

import java.util.List;

import cn.dfx.share_record_SSM.dsum.plan.pojo.Plan;

/**
 * 计划的业务层接口方法设计
 * @author Administrator
 *
 */
public interface PlanIService {

	public Integer add(Plan plan);//添加计划
	
	public Integer eidt(Plan plan);//修改计划
	
	public void delete(int id);//删除计划
	
	public List<Plan> findByCondition(Plan plan);//根据id查找计划
	
	public List<Plan> findAllPlan(int userid);//查看当前用户的所有plan
}
