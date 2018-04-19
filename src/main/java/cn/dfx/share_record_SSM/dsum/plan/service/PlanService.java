package cn.dfx.share_record_SSM.dsum.plan.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.dfx.share_record_SSM.dsum.plan.mapper.PlanMapper;
import cn.dfx.share_record_SSM.dsum.plan.pojo.Plan;
/**
 * 计划业务层实现类
 * @author Administrator
 *
 */

public class PlanService implements PlanIService {
	
	@Autowired
	private PlanMapper planMapper;
	
	
	@Override
	public Integer add(Plan plan) {
		Date createtime = new Date();
		plan.setCreatetime(createtime);
		return planMapper.add(plan);
	}

	@Override
	public Integer eidt(Plan plan) {
		Date createtime = new Date();
		plan.setCreatetime(createtime);
		return planMapper.edit(plan);
	}

	@Override
	public void delete(int id) {
		planMapper.delete(id);
	}

	@Override
	public List<Plan> findByCondition(Plan plan) {
		return planMapper.findByCondition(plan);
	}

	@Override
	public List<Plan> findAllPlan(int userid) {
		return planMapper.findAllPlan(userid);
	}

}
