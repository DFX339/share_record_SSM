package cn.dfx.share_record_SSM.dsum.plan.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.dfx.share_record_SSM.dsum.base.pojo.Person;
import cn.dfx.share_record_SSM.dsum.plan.pojo.Plan;
import cn.dfx.share_record_SSM.dsum.plan.service.PlanService;
import net.sf.json.JSONArray;
/**
 * 计划的前端控制器类
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value="/plan")
public class PlanController {
	
	@Autowired
	private PlanService planService;
	
	//最先进入的计划主页面（查询当前用户的所有的计划）
	@RequestMapping(value="/goMain")
	public String goMain(HttpServletRequest request){
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		
		int userid = person.getId();
		List<Plan> allPlan = planService.findAllPlan(userid);
		request.setAttribute("allPlan", allPlan);
		
		return "plan/plan";
	}
	
	
	//完成计划的添加
	@ResponseBody
	@RequestMapping(value="/addPlan",produces="application/json;charset=UTF-8")
	public String add(Plan plan,HttpServletRequest request,HttpServletResponse response){
		response.setHeader("Content-Type", "text/html;charset=utf-8");   
		System.out.println("进入plan---addplan---"+plan.getContent());
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "error";
		}
		
		int userid = person.getId();
		plan.setUserid(userid);
		planService.add(plan);
		return "ok";
	}
	

	
	//修改计划
	@RequestMapping(value="/editPlan")
	public String edit(int editid,String editcontent,HttpServletRequest request){
		System.out.println("进入plan---editplan---"+editcontent+"------"+editid);
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		int userid = person.getId(); //得到当前登录用户的id
		
		Plan plan = new Plan();
		plan.setUserid(userid);
		plan.setId(editid);
		plan.setContent(editcontent);
		planService.eidt(plan);
		return  goMain(request);
	}
	
	//删除计划
	@RequestMapping(value="/deletePlan")
	public String delete(int id,HttpServletRequest request){
		System.out.println("进入plan---deleteplan");
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "redirect:index.jsp";
		}
		planService.delete(id);
		return  goMain(request);
	}
	
	@RequestMapping(value="/findById",produces="application/json;charset=UTF-8")
	@ResponseBody
	//根据条件查询计划
	public String findById(Plan plan,HttpServletRequest request){
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "error";
		}
		System.out.println("进入按条件查询plan-id查询--"+plan.getId());
		List<Plan> planList = planService.findByCondition(plan);
		System.out.println("进入按条件查询plan-id查询--"+planList.get(0).getContent());
		if(planList.size() > 0){
			return planList.get(0).getContent();
		}else{
			return "error";
		}
	}
	
	@RequestMapping("/findByCondition")
	@ResponseBody
	//根据条件查询计划
	public String findByCondition(Plan plan,HttpServletRequest request){
		//判断用户是否合法，在session中是否有信息（有表示合法，没有则表示不合法）
		Person person = (Person) request.getSession().getAttribute("person");
		if(person == null){
			request.setAttribute("error", "非法用户");
			return "error";
		}
		plan.setUserid(person.getId());
		System.out.println("进入按条件查询plan-模糊查询--");
		List<Plan> planList = planService.findByCondition(plan);
		request.setAttribute("planList", planList);
		
		JSONArray json = JSONArray.fromObject(planList); 
		return json.toString();
	}
	
	
}
