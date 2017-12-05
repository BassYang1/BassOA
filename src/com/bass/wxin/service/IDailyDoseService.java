package com.bass.wxin.service;

import java.util.List;

import com.bass.wxin.model.po.DailyDoseModel;

public interface IDailyDoseService {
	public DailyDoseModel getDailyDoseById(int iid);
	public List<String> collectDailyDrugs(int userId);
	public List<DailyDoseModel> queryDailyDose();
}
