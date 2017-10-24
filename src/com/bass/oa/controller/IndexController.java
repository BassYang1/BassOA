package com.bass.oa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bass.oa.service.ITestService;

@Controller
@RequestMapping(value="/index")
public class IndexController {

	private ITestService testService;
	
	@Autowired
	public void setTestService(ITestService testService){
		this.testService = testService;
	}
	
	
	@RequestMapping(method=RequestMethod.GET)
	public String index(){
		System.out.println(this.testService.getMessage());
		return "index";
	}
}
