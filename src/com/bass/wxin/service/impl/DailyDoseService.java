package com.bass.wxin.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bass.wxin.mapper.DailyDoseMapper;
import com.bass.wxin.model.po.DailyDoseModel;
import com.bass.wxin.service.IDailyDoseService;

@Service
public class DailyDoseService extends BaseService implements IDailyDoseService {
	@Autowired
	DailyDoseMapper _dailyDoseMapper;
	
	@Override
	public DailyDoseModel getDailyDoseById(int id) {
		return _dailyDoseMapper.getDailydoseById(id);
	}
	
	public static void main(String[] args){
		IDailyDoseService service = new DailyDoseService();
		System.out.println(service.getDailyDoseById(1));
	}
}
