package com.bass.oa.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bass.oa.model.MyResult;

@Controller
//@ResponseBody
@RequestMapping(value = "")
public class TestController {
	@RequestMapping(value = "test")
	public String test() {
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
