package cn.dfx.share_record_SSM.dsum.base.service;

import org.springframework.beans.factory.annotation.Autowired;

import cn.dfx.share_record_SSM.dsum.base.mapper.PersonMapper;
import cn.dfx.share_record_SSM.dsum.base.pojo.Person;
import cn.dfx.share_record_SSM.dsum.util.exception.LoginException;

/**
 * 用户登录注册模块的业务实现类
 * @author Administrator
 *
 */
public class PersonService implements PersonIService{

	@Autowired
	private PersonMapper personMapper;
	
	@Override
	public Person login(String usernum, String password, int identity) {
		Person person = new Person();
		person.setUsernum(usernum);
		person.setPassword(password);
		person.setIdentity(identity);
		person = personMapper.login(person);
		return personMapper.login(person);
	}

	@Override
	public void regist(Person person) {
		personMapper.add(person);
	}

}
