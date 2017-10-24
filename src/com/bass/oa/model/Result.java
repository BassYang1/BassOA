package com.bass.oa.model;

public class Result<T> {
	private String message;
	private boolean status;
	private int code;
	private T data;
	
	public Result(boolean status){
		this.status = status;
	}

	public Result(boolean status, int code){
		this.status = status;
		this.code = code;
	}
	
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
	
	public T getData(){
		return this.data;
	}
	
	public void setData(T data){
		this.data = data;
	}
}
