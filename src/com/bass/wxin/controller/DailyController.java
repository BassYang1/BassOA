package com.bass.wxin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bass.wxin.model.vo.DailyDoseEditModel;
import com.bass.wxin.service.IDailyDoseService;

@Controller
@RequestMapping("/wxin/daily")
public class DailyController {
	@Autowired
	IDailyDoseService _dailyDoseService;
	
	@RequestMapping("/index")
	public String index(){
		System.out.println(_dailyDoseService.getDailyDoseById(1));
		return "wxin/daily/index";
	}
	
	@RequestMapping(value="/edit", method=RequestMethod.GET)
	public String edit(){
		return "wxin/daily/edit";
	}
	
	@RequestMapping(value="edit", method=RequestMethod.POST)
	public String edit(@ModelAttribute("dose") DailyDoseEditModel dose){
		return "wxin/daily/index";
	}
}
