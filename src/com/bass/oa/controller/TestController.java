package com.bass.oa.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bass.oa.exception.AuthorizationException;
import com.bass.oa.model.MyResult;
import com.bass.oa.service.ITestService;
import com.bass.oa.service.IUserService;

@Controller
//@ResponseBody
@RequestMapping(value = "")
public class TestController extends BaseController {
	@Autowired
	private ITestService _testService;
	
	@RequestMapping(value = "test")
	public String test(Model model) {
		try{
			model.addAttribute("msg", "未出现异常");
			_testService.getNum(1);
		}
		catch(AuthorizationException ex){
			model.addAttribute("msg", ex.getMessage());
		}
		
		return "test/test";
	}

	@RequestMapping(value = "test2")
	public String test2() {
		return "test/test2";
	}
	
	/*public String test() {
		return "test字符串";
	}*/

	/*public MyResult<String> test() {
		MyResult<String> result = new MyResult(true, true);
		result.setMessage("test字符串");
		return result;
	}*/

	/*public Object test(@RequestBody List<String> p) {
		System.out.println(p.toString());
		List<String> list = new ArrayList();
		list.add("test字符串");
		return list;
	}*/

}
