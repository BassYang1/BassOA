package com.bass.wxin.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bass.wxin.model.vo.DailyDoseEditModel;
import com.bass.wxin.service.IDailyDoseService;

@Controller
@RequestMapping("/wxin/daily")
public class DailyController extends BaseController {
	private static Logger Log = Logger.getLogger(DailyController.class);
	
	@Autowired
	IDailyDoseService _dailyDoseService;
	
	@RequestMapping("/index")
	public String index() {
		//System.out.println(_dailyDoseService.getDailyDoseById(1));
		System.out.println(_dailyDoseService.queryDailyDose());
		return "wxin/daily/index";
	}
	
	@RequestMapping(value="/edit", method=RequestMethod.GET)
	public String edit(Model model){
		model.addAttribute("drugs", _dailyDoseService.collectDailyDrugs(1));
		return "wxin/daily/edit";
	}
	
	@RequestMapping(value="edit", method=RequestMethod.POST)
	public void edit(@ModelAttribute("dose") DailyDoseEditModel dose, BindingResult result, Model model){
		model.addAttribute("edit.result", "success");
	}
}
