package cn.dfx.share_record_SSM.dsum.base.service;

import cn.dfx.share_record_SSM.dsum.base.pojo.Person;

/**
 * 用户登录注册模块接口定义
 * @author Administrator
 *
 */
public interface PersonIService {
	
	/**
	 * 用户登录（根据用户账号，用户密码，用户身份）
	 * @param usernum
	 * @param password
	 * @param identity
	 * @return
	 */
	public Person login(String usernum,String password,int identity);
	
	
	/**
	 * 注册账号（Person中包含用户基本信息）
	 * @param person
	 * @return
	 */
	public void regist(Person person);
}
