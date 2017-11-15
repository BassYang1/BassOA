package com.bass.oa.model.vo;

import org.hibernate.validator.constraints.NotEmpty;

public class UserLoginModel {
	@NotEmpty
	private String userName;
	@NotEmpty
	private String password;

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
}
