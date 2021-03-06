package com.bass.oa.exception.enums;

public enum AuthorizationExEnum implements ExceptionEnum {
	UNKNOWN("User", "U00000", "用户登录异常"),
	INVALID_INFO("User", "U00001", "无效的用户信息"),	
	INVALID_USERNAME("User", "U00002", "无效的用户名"),
	INVALID_PASSWORD("User", "U00004", "无效的用户密码"),
	INVALID_EMAIL("User", "U00005", "无效的用户邮箱"),
	INVALID_TOKEN("User", "U00006", "无效的用户Token"),
	EXPIRED_TOKEN("User", "U00007", _context.getMessage("oa.login.token.expired")),
	DISABLED_USER("User", "U00008", "用户被禁用"),
	OVER_LOGIN_LIMIT("User", "U00009", "超过用户登录次数限制"),
	INVALID_LOGIN("User", "U00010", "无效的用户名或密码");

	private String module;
	private String code;
	private String message;

	private AuthorizationExEnum(){
	}
	
	private AuthorizationExEnum(String module, String code, String message){
		this.module = module;
		this.code = code;
		this.message = message;		
	}
	
	@Override
	public String getModule(){
		return this.module;
	}

	@Override
	public String getCode() {
		return code;
	}

	@Override
	public String getMessage() {
		return this.message;
	}

	@Override
	public String toString() {
		return String.format("[AuthorizationExEnum=%s,%s,%s]", this.module, this.code, this.message);
	}
}
