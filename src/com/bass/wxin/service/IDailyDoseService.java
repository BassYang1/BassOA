package com.bass.wxin.service;

import java.util.List;

import com.bass.wxin.model.po.DailyDoseModel;

public interface IDailyDoseService {
	public DailyDoseModel getDailyDoseById(int id);
	public List<String> collectDailyDrugs(int userId);
	public List<DailyDoseModel> test();
}
