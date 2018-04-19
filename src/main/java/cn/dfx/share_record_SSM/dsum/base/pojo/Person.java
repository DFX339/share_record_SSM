package cn.dfx.share_record_SSM.dsum.base.pojo;
/**
 * 用户类
 * @author DFX
 * 用户表  t_person:
	id       主键，主标识 自增
	usernum  用户账号
	username 用户昵称
	password 用户密码
	identity 用户身份(1表示普通用户，2表示公司用户，3表示管理员)
	companynum 公司编号//当注册用户为公司用户时不能为null，其余可以为null
 */
public class Person {

	private int id;
	private String usernum;
	private String username;
	private String password;
	private int identity;
	private String companynum;
	
	public Person(){}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsernum() {
		return usernum;
	}

	public void setUsernum(String usernum) {
		this.usernum = usernum;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getIdentity() {
		return identity;
	}

	public void setIdentity(int identity) {
		this.identity = identity;
	}

	public String getCompanynum() {
		return companynum;
	}

	public void setCompanynum(String companynum) {
		this.companynum = companynum;
	}
	
	
}
