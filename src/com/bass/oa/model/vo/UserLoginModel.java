package com.bass.oa.model.vo;

import org.hibernate.validator.constraints.NotEmpty;

public class UserLoginModel {
	@NotEmpty
	private String _userName;
	@NotEmpty
	private String _password;
	
	public void setUserName(String userName) {
		this._userName = userName;
	}

	public String getUserName() {
		return this._userName;
	}

	public void setPassword(String password) {
		this._password = password;
	}

	public String getPassword() {
		return this._password;
	}
}
