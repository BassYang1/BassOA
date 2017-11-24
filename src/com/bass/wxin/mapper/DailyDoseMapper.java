package com.bass.wxin.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bass.wxin.model.po.DailyDoseModel;

@Repository
public interface DailyDoseMapper {
	public DailyDoseModel getDailydoseById(int id);
	public List<String> collectDailyDrugs(int userId);
	public int addDailyDose(DailyDoseModel model);
}
