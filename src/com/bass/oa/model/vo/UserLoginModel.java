package com.bass.oa.model.vo;

import org.hibernate.validator.constraints.NotEmpty;

import com.bass.oa.model.BaseModel;
import com.bass.oa.model.po.UserModel;

public class UserLoginModel extends BaseModel {
	@NotEmpty
	private String userName;
	@NotEmpty
	private String password;
	private boolean remembered;
	
	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return this.password;
	}

	public void setRemembered(boolean remembered) {
		this.remembered = remembered;
	}
	
	public boolean isRemembered() {
		return this.remembered;
	}
	
	public UserModel convertToUserModel(){
		return new UserModel(this.userName, this.password);
	}
	
	@Override
	public String toString(){
		return String.format("[User=%d,%s]", this.userName, "******");
	}
}
