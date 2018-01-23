package com.bass.oa.exception.enums;

public enum AuthorizationExEnum implements ExceptionEnum {
	INVALID_INFO("User", "U00000", "无效的用户信息"),
	INVALID_USERNAME("User", "U00001", "无效的用户名"),
	INVALID_PASSWORD("User", "U00002", "无效的用户密码"),
	INVALID_EMAIL("User", "U00003", "无效的用户邮箱"),
	INVALID_TOKEN("User", "U00004", "无效的用户Token"),
	EXPIRED_TOKEN("User", "U00005", "过期的用户Token"),
	DISABLED_USER("User", "U00006", "用户被禁用"),
	OVER_LOGIN_LIMIT("User", "U00007", "超过用户登录次数限制");
	
	private String module;
	private String code;
	private String message;
	
	private AuthorizationExEnum(String module, String code, String message){
		this.module = module;
		this.code = code;
		this.message = message;		
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
}
