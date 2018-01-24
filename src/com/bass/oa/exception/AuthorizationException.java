package com.bass.oa.exception;

import com.bass.oa.exception.enums.AuthorizationExEnum;

public class AuthorizationException extends RuntimeException {
	private static final long serialVersionUID = 1L;
	private AuthorizationExEnum exception;

	private String module;
	private String code;
	private String message;
	//private Map<String, Object> errorData;

	public AuthorizationException(AuthorizationExEnum exception) {
		super();
		this.exception = exception;
		this.module = exception.getModule();
		this.code = exception.getCode();
		this.message = exception.getMessage();
	}

	/*
	 * 利用此构函数解决国际化问题
	 */
	public AuthorizationException(AuthorizationExEnum exception, String message) {
		super();
		this.exception = exception;
		this.module = exception.getModule();
		this.code = exception.getCode();
		this.message = message;
	}

	public AuthorizationException(String message) {
		this(AuthorizationExEnum.UNKNOWN, message);
	}
	
	public void setException(AuthorizationExEnum exception){
		this.exception = exception;
	}
	
	public AuthorizationExEnum getException(){
		return this.exception;
	}

	public void setModule(String module){
		this.module = module;
	}
	
	public String getModule(){
		return this.module;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	@Override
	public String toString() {
		return String.format("[AuthorizationException=%s,%s,%s]", this.module, this.code, this.message);
	}
}
