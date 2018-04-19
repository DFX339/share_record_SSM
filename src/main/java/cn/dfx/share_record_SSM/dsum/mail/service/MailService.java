package cn.dfx.share_record_SSM.dsum.mail.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.dfx.share_record_SSM.dsum.base.pojo.Person;
import cn.dfx.share_record_SSM.dsum.mail.mapper.MailMapper;
import cn.dfx.share_record_SSM.dsum.mail.pojo.Mail;
/**
 * 邮件业务层方法实现类
 * @author Administrator
 *
 */
@Service
public class MailService implements MailIService {

	@Autowired
	private MailMapper mailMapper;
	
	@Override
	public void add(Mail mail) {
		Date createtime = new Date();
		mail.setCreatetime(createtime);
		mailMapper.add(mail);
	}

	@Override
	public void editState(Mail mail) {
		mailMapper.editState(mail);
	}

	@Override
	public void delete(int id) {
		mailMapper.delete(id);
	}

	@Override
	public List<Mail> findByCondition(Mail mail) {
		return mailMapper.findByCondition(mail);
	}

	@Override
	public List<Mail> findAllSendMails(int sendid) {
		return mailMapper.findAllSendMails(sendid);
	}

	@Override
	public List<Mail> findAllRecieveMails(int recieveid) {
		return mailMapper.findAllRecieveMails(recieveid);
	}


	@Override
	public Mail findMailById(int id) {
		return mailMapper.findMailById(id);
	}
	
	@Override
	public List<Person> findAllPerson(Person person){
		return mailMapper.findAllPerson(person);
	}

	public List<Person> findHotPerson() {
		return mailMapper.findHotPerson();
	}
	
	/**
	 * 删除用户，此方法归管理员调用
	 * @param id
	 */
	public void deletePerson(int id) {
		mailMapper.deletePerson(id);
	}
}
