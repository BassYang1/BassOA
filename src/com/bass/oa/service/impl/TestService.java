package com.bass.oa.service.impl;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;

import com.bass.oa.exception.AuthorizationException;
import com.bass.oa.exception.enums.AuthorizationExEnum;
import com.bass.oa.service.ITestService;

@Scope("prototype")
@Service
public class TestService implements ITestService {
	public String getMessage() {
		return "Hello World.";
	}

	public double getNum(int userId) {
		if (userId <= 0) {
			throw new AuthorizationException(AuthorizationExEnum.INVALID_INFO);
		}

		return 1 / 0;
	}
}
