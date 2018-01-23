package com.bass.oa.model.vo;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import com.bass.oa.model.BaseModel;
import com.bass.oa.model.po.UserModel;

public class PasswordResetModel extends BaseModel {
	@Email
	private String email;
	@NotEmpty
	private String captcha;
	@NotEmpty
	private String password;
	@NotEmpty
	private String cfmPassword;
	
	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return this.email;
	}

	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}

	public String getCaptcha() {
		return this.captcha;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return this.password;
	}

	public void setCfmPassword(String password) {
		this.cfmPassword = password;
	}

	public String getCfmPassword() {
		return this.cfmPassword;
	}

	@Override
	public String toString(){
		return String.format("[UserPassword=%s,%s,%s,%s]", this.email, this.captcha, "", "");
	}
}
