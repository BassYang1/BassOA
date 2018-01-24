package com.bass.oa.model.po;

import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

import com.bass.oa.core.AppUtil;
import com.bass.oa.model.BaseModel;

public class UserModel extends BaseModel {
	private int userId;
	@NotEmpty
	private String userName;
	@NotEmpty(message="密码不能为空")
	private String password;
	/*
	 * 账号是否可用
	 */
	private boolean enabled;
	private String token;
	
	/*
	 * 登录有效密文
	 */
	private String series;
	private Date loginDate;
	
	/*
	 * 用户名
	 */
	private String name;
	
	/*
	 * 用户邮箱
	 */
	private String email;
	
	/*
	 * 登录失败次数
	 */
	private int loginCount;
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

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return this.password;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public boolean isEnabled() {
		return this.enabled;
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

	public int getLoginCount(){
		return loginCount;
	}
	
	public void setLoginCount(int loginCount){
		this.loginCount = loginCount;
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
		return String.format("[User=%d,%s,%s,%s,%s]", this.userId, this.userName, AppUtil.formatDateTime(this.loginDate), AppUtil.formatDateTime(this.expiredDate), AppUtil.formatDateTime(this.createdDate));
	}
}
