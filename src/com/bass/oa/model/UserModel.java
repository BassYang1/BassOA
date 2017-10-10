package com.bass.oa.model;

import java.util.Date;

public class UserModel {
	private int userId;
	private String userName;
	private String password;
	private Date loginedDate;
	private Date createdDate;
	
	public void setUserId(int userId){
		this.userId = userId;
	}
	
	public int getUserId(){
		return this.userId;
	}
	
	public void setUserName(String userName){
		this.userName = userName;
	}
	
	public String getUserName(){
		return this.userName;
	}
	
	public void setPassword(String password){
		this.password = password;
	}
	
	public String getPassword(){
		return this.password;
	}
	
	public void setLoginedDate(Date loginedDate){
		this.loginedDate = loginedDate;
	}
	
	public Date getLoginedDate(){
		return this.loginedDate;
	}
	
	public void setCreatedDate(Date createdDate){
		this.createdDate = createdDate;
	}
	
	public Date getCreatedDate(){
		return this.createdDate;
	}
}
