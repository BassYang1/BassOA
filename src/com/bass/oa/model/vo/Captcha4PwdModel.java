package com.bass.oa.model.vo;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.bass.oa.model.BaseModel;
import com.bass.oa.model.po.UserModel;

public class Captcha4PwdModel extends BaseModel {
	@Email
	private String email;
	@NotEmpty
	private String captcha;
	
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
	
	@Override
	public String toString(){
		return String.format("[Captcha=%s,%s]", this.email, this.captcha);
	}
}
