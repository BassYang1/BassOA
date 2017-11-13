package com.bass.oa.model;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

public class UserModel {
	private int userId;
	@NotEmpty
	private String userName;
	@NotEmpty(message="密码不能为空")
	private String password;
	private String _userToken;
	private Date loginedDate;
	private Date createdDate;
	private String[] favoriteFrameworks;

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

	public void setUserToken(String userToken) {
		this._userToken = userToken;
	}

	public String getUserToken() {
		return this._userToken;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return this.password;
	}

	public void setLoginedDate(Date loginedDate) {
		this.loginedDate = loginedDate;
	}

	public Date getLoginedDate() {
		return this.loginedDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getCreatedDate() {
		return this.createdDate;
	}

	public String[] getFavoriteFrameworks() {
		return favoriteFrameworks;
	}

	public void setFavoriteFrameworks(String[] favoriteFrameworks) {
		this.favoriteFrameworks = favoriteFrameworks;
	}
}
