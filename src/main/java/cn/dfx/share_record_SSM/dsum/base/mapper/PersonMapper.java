package cn.dfx.share_record_SSM.dsum.base.mapper;

import cn.dfx.share_record_SSM.dsum.base.pojo.Person;

/**
 * 用户模块的接口定义
 * @author Administrator
 *
 */
public interface PersonMapper {
	
	public void add(Person person);//用户注册 插入数据到数据库中
	
	public Person login(Person person);//用户登录 从数据库中查询对应的账号和密码是否存在(以及身份)
	
}
