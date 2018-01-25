package com.bass.oa.enums;

public enum UserGender implements IMyEnum {
	UNKNOWN("User", 4, "未知"),
	FEMALE("User", 1, "女"),
	MALE("User", 2, "男");

	private String module;
	private int code;
	private String desc;
	
	private UserGender(String module, int code, String desc){
		this.module = module;
		this.code = code;
		this.desc = desc;
	}

	@Override
	public String getModule() {
		return this.module;
	}

	@Override
	public int getCode() {
		return this.code;
	}

	@Override
	public String getDesc() {
		return this.desc;
	}
	
	@Override
	public String toString() {
		return String.format("[UserGender=%s,%s,%s]", this.module, this.code, this.desc);
	}
}
