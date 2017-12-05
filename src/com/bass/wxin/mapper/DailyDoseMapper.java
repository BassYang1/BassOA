package com.bass.wxin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bass.wxin.model.po.DailyDoseModel;

@Repository
public interface DailyDoseMapper {
	public DailyDoseModel getDailyDoseById(@Param("id1") int id1);
	public List<String> collectDailyDrugs(int userId);
	public int addDailyDose(DailyDoseModel model);
	public List<DailyDoseModel> queryDailyDose(DailyDoseModel model, @Param("start") int start, @Param("limit") int limit);
}

