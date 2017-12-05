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
	public DailyDoseModel getDailyDoseById(int iid) {
		if(iid <= 0){
			return null;
		}
		
		DailyDoseModel model = _dailyDoseMapper.getDailyDoseById(iid);
		
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
	public List<DailyDoseModel> queryDailyDose() {
		DailyDoseModel model = new DailyDoseModel();
		model.setUserId(2);
		return _dailyDoseMapper.queryDailyDose(model, 0, 1);
	}
}
