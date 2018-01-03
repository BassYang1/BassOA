package com.bass.oa.model;

public class MyResult<T> {
	private String message;
	private boolean status;
	private int code;
	private T data;
	
	public MyResult(){
		this.status = false;
		this.message = "";
		this.data = null;
	}
	
	public MyResult(boolean status){
		this.status = status;
		this.message = "";
		this.data = null;
	}

	public MyResult(boolean status, String message){
		this.status = status;
		this.message = message;
		this.data = null;
	}
	
	public MyResult(boolean status, T data){
		this.status = status;
		this.message = "";
		this.data = data;
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
