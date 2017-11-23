package com.bass.wxin.mapper;

import com.bass.wxin.model.po.DailyDoseModel;

public interface DailyDoseMapper {
	public DailyDoseModel getDailydoseById(int id);
	public int addDailyDose(DailyDoseModel model);
}
