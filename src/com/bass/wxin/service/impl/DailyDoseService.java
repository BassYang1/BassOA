package com.bass.wxin.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		if(id <= 0){
			return null;
		}
		
		DailyDoseModel model = _dailyDoseMapper.getDailyDoseById(id);
		
		return model;
	}

	@Override
	public List<String> collectDailyDrugs(int userId) {
		if(userId <= 0){
			return new ArrayList<String>();
		}
		
		return _dailyDoseMapper.collectDailyDrugs(userId);
	}
	
	public static void main(String[] args){
		IDailyDoseService service = new DailyDoseService();
		System.out.println(service.getDailyDoseById(1));
	}

	@Override
	public List<DailyDoseModel> test() {
		return _dailyDoseMapper.test(2, 0, 1);
	}
}
