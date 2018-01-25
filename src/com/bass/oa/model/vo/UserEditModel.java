package com.bass.oa.model.vo;

import java.util.Date;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import com.bass.oa.core.AppUtil;
import com.bass.oa.enums.UserGender;
import com.bass.oa.model.BaseModel;

public class UserEditModel extends BaseModel {
	/*
	 * 登录名
	 */
	@NotEmpty
	private String userName;
	
	/*
	 * 用户名
	 */
	@NotEmpty
	private String name;
	
	/*
	 * 用户邮箱
	 */
	@Email
	private String email;

	/*
	 * 部门
	 */
	private int departmentId;	
	
	/*
	 * 年龄
	 */
	private int age;

	/*
	 * 性别
	 */
	private UserGender gender;
	
	public UserEditModel(){
		
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return this.name;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return this.email;
	}

	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}

	public int getDepartmentId() {
		return this.departmentId;
	}
	
	public void setAge(int age) {
		this.age = age;
	}

	public int getAge() {
		return this.age;
	}

	public void setGender(UserGender gender) {
		this.gender = gender;
	}

	public UserGender getGender() {
		return this.gender;
	}
	
	/*@Override
	public String toString(){
		return String.format("[User=%d,%s,%s,%s,%s]", this.userId, this.userName, AppUtil.formatDateTime(this.loginDate), AppUtil.formatDateTime(this.expiredDate), AppUtil.formatDateTime(this.createdDate));
	}*/
}
