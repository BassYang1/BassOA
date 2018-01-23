package com.bass.oa.service.impl;

import com.bass.oa.exception.AuthorizationException;
import com.bass.oa.exception.enums.AuthorizationExEnum;
import com.bass.oa.model.po.UserModel;
import com.bass.oa.service.ITestService;

public class TestService implements ITestService {
	public String getMessage(){
		return "Hello World.";
	}
	
	public double getNum(int userId) {
		if(userId <= 0){
			throw new AuthorizationException(AuthorizationExEnum.INVALID_INFO);
		}
		
		return 1 / 0;
}
}
