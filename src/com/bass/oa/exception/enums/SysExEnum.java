package com.bass.oa.exception.enums;

public enum SysExEnum implements ExceptionEnum {
	UNKNOWN("Organization", "ORG00000", "未知异常"),	
	ORG_UNFOUND("Organization", "ORG00001", "组织机构不存在");

	private String module;
	private String code;
	private String message;

	private SysExEnum(){
	}
	
	private SysExEnum(String module, String code, String message){
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
		return String.format("[SysExEnum=%s,%s,%s]", this.module, this.code, this.message);
	}
}
