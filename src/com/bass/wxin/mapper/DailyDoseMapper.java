package com.bass.wxin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.bass.wxin.model.po.DailyDoseModel;

@Repository
public interface DailyDoseMapper {
	public DailyDoseModel getDailyDoseById(int id);
	public List<String> collectDailyDrugs(int userId);
	public int addDailyDose(DailyDoseModel model);
	public List<DailyDoseModel> test(@Param("userId") int userId, @Param("start") int start, @Param("limit") int limit);
}

