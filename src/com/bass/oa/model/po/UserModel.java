package com.bass.oa.model.po;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

import com.bass.oa.model.BaseModel;

public class UserModel extends BaseModel {
	private int userId;
	@NotEmpty
	private String userName;
	@NotEmpty(message="密码不能为空")
	private String password;
	private String token;
	private String series;
	private Date loginDate;
	private Date expiredDate;
	private Date createdDate;

	public UserModel(){
		
	}
	
	public UserModel(String userName, String password){
		this.userName = userName;
		this.password = password;
	}
	
	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getUserId() {
		return this.userId;
	}

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
	
	public void setToken(String token) {
		this.token = token;
	}

	public String getToken() {
		return this.token;
	}

	public void setSeries(String series) {
		this.series = series;
	}

	public String getSeries() {
		return this.series;
	}

	public void setLoginDate(Date loginDate) {
		this.loginDate = loginDate;
	}

	public Date getLoginDate() {
		return this.loginDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getCreatedDate() {
		return this.createdDate;
	}

	public void setExpiredDate(Date expiredDate) {
		this.expiredDate = expiredDate;
	}

	public Date getExpiredDate() {
		return this.expiredDate;
	}

	@Override
	public String toString(){
		return String.format("[User=%d,%s,%s,%s,%s]", this.userId, this.userName, _app.formatDateTime(this.loginDate), _app.formatDateTime(this.expiredDate), _app.formatDateTime(this.createdDate));
	}
}
