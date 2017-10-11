package com.bass.oa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bass.oa.service.ITestService;

@Controller
public class IndexController {

	private ITestService testService;
	
	public void setTestService(ITestService testService){
		this.testService = testService;
	}
	
	
	@RequestMapping(value="/index", method=RequestMethod.GET)
	public String index(){
		System.out.println(this.testService.getMessage());
		return "index";
	}
}
