package com.bass.oa.model;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

public class UserModel {
	private int _userId;
	@NotEmpty
	private String _userName;
	@NotEmpty(message="密码不能为空")
	private String _password;
	private String _token;
	private String _series;
	private Date _loginDate;
	private Date _expiredDate;
	private Date _createdDate;

	public void setUserId(int userId) {
		this._userId = userId;
	}

	public int getUserId() {
		return this._userId;
	}

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
	
	public void setToken(String token) {
		this._token = token;
	}

	public String getToken() {
		return this._token;
	}

	public void setSeries(String series) {
		this._series = series;
	}

	public String getSeries() {
		return this._series;
	}

	public void setLoginDate(Date loginDate) {
		this._loginDate = loginDate;
	}

	public Date getLoginDate() {
		return this._loginDate;
	}

	public void setCreatedDate(Date createdDate) {
		this._createdDate = createdDate;
	}

	public Date getCreatedDate() {
		return this._createdDate;
	}

	public void setExpiredDate(Date expiredDate) {
		this._expiredDate = expiredDate;
	}

	public Date getExpiredDate() {
		return this._expiredDate;
	}

	@Override
	public String toString(){
		return String.format("[User=%d,%s,%s,%s,%s]", this._userId, this._userName, this._loginDate, this._expiredDate, this._createdDate);
	}
}
