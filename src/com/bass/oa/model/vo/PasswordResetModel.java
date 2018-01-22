package com.bass.oa.model.vo;

import org.hibernate.validator.constraints.NotEmpty;

import com.bass.oa.model.BaseModel;
import com.bass.oa.model.po.UserModel;

public class PasswordResetModel extends BaseModel {
	@NotEmpty
	private String password;
	@NotEmpty
	private String checkPassword;

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return this.password;
	}

	public void setCheckPassword(String password) {
		this.checkPassword = password;
	}

	public String getCheckPassword() {
		return this.checkPassword;
	}

	@Override
	public String toString(){
		return String.format("[UserPassword=%s,%s]", this.password, this.checkPassword);
	}
}
