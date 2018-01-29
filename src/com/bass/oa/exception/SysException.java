package com.bass.oa.exception;

import com.bass.oa.exception.enums.SysExEnum;

public class SysException extends RuntimeException {
	private static final long serialVersionUID = 1L;
	private SysExEnum exception;

	private String module;
	private String code;
	private String message;

	// private Map<String, Object> errorData;

	public SysException(SysExEnum exception) {
		super();
		this.exception = exception;
		this.module = exception.getModule();
		this.code = exception.getCode();
		this.message = exception.getMessage();
	}

	/*
	 * 利用此构函数解决国际化问题
	 */
	public SysException(SysExEnum exception, String message) {
		super();
		this.exception = exception;
		this.module = exception.getModule();
		this.code = exception.getCode();
		this.message = message;
	}

	public SysException(String message) {
		this(SysExEnum.UNKNOWN, message);
	}

	public void setException(SysExEnum exception) {
		this.exception = exception;
	}

	public SysExEnum getException() {
		return this.exception;
	}

	public void setModule(String module) {
		this.module = module;
	}

	public String getModule() {
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
		return String.format("[SysException=%s,%s,%s]", this.module, this.code,
				this.message);
	}
}
