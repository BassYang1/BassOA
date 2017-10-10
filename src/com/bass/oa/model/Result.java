package com.bass.oa.model;

public class Result {
	private String message;
	private boolean status;
	private int code;
	
	public String getMessage(){
		return this.message;
	}
	
	public void setMessage(String message){
		this.message = message;
	}
	
	public boolean isStatus(){
		return this.status;
	}
	
	public void setStatus(boolean status){
		this.status = status;
	}
	
	public int getCode(){
		return this.code;
	}
	
	public void setCode(int code){
		this.code = code;
	}
}
