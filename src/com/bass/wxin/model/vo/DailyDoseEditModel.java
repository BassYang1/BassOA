package com.bass.wxin.model.vo;

import org.hibernate.validator.constraints.NotEmpty;

import com.bass.wxin.model.po.DailyDoseModel;

/*
 * 编辑日常用药量
 */
public class DailyDoseEditModel {

	public DailyDoseEditModel(){}

	public DailyDoseEditModel(DailyDoseModel model){		
		if(model != null){
			this._seqNumber = model.getSeqNumber();
			this._drugName = model.getDrugName();
			this._dose = model.getDose();
			this._unit = model.getUnit();
		}		
	}
	
	/*
	 * 序列号
	 */
	private int _seqNumber;
	
	/*
	 * 药品名称
	 */
	@NotEmpty
	private String _drugName;
	
	/*
	 * 用药剂量
	 */
	@NotEmpty
	private String _dose;

	/*
	 * 剂量单位
	 */
	@NotEmpty
	private String _unit;

	public void setSeqNumber(int seqNumber){
		this._seqNumber = seqNumber;
	}
	
	public int getSeqNumber(){
		return this._seqNumber;
	}

	public String getDrugName(){
		return this._drugName;
	}
	
	public void setDrugName(String drugName){
		this._drugName = drugName;
	}

	public void setDose(String dose){
		this._dose = dose;
	}
	
	public String getDose(){
		return this._dose;
	}
	
	public void setUnit(String unit){
		this._unit = unit;
	}
	
	public String getUnit(){
		return this._unit;
	}	

	@Override
	public String toString(){
		return String.format("[DailyDose=%d,%s,%s,%s]", this._seqNumber, this._drugName, this._dose, this._unit);
	}
}
