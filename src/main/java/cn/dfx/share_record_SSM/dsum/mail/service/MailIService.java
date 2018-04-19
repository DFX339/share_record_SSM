package cn.dfx.share_record_SSM.dsum.mail.service;

import java.util.List;

import cn.dfx.share_record_SSM.dsum.base.pojo.Person;
import cn.dfx.share_record_SSM.dsum.mail.pojo.Mail;
/**
 * 邮件业务层接口方法设计类
 * @author Administrator
 *
 */
public interface MailIService {
	
	public void add(Mail mail);//添加邮件
	
	public void editState(Mail mail);//更新邮件状态
	
	public void delete(int id);//删除邮件
	
	public Mail findMailById(int id);//根据mail 的id查询mail
	
	public List<Mail> findByCondition(Mail mail);//根据条件查询接收到的邮件
	
	public List<Mail> findAllSendMails(int sendid);//查询出所有的发送出去的邮件
	
	public List<Mail> findAllRecieveMails(int recieveid);//查询出所有的接收到的邮件
	
	public List<Person> findAllPerson(Person person);//查出所有的用户
	
	public List<Person> findHotPerson();//查询出最新注册的三位用户
	
	public void deletePerson(int id);//删除 用户
}
