package com.kh.viewnimal.volunteerapply.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.volunteerapply.model.dao.VolunteerApplyDao;
import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplierDto;
import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplyDto;

@Service("volunteerApplyService")
public class VolunteerApplyServiceImpl implements VolunteerApplyService {
	@Autowired
	private VolunteerApplyDao volunteerApplyDao;
	
	//자원봉사 모집글 검색 카테고리 목록(년,월) 불러오기
	@Override
	public ArrayList<String> selectVolunteerApplyCategoryList() {
		return volunteerApplyDao.selectVolunteerApplyCategoryList();
	}
	
	//자원봉사 모집글 리스트(특정 한달치만) 불러오기
	@Override
	public ArrayList<VolunteerApplyDto> selectSearchVolunteerApplyList(String selectedYearMonth) {
		return volunteerApplyDao.selectSearchVolunteerApplyList(selectedYearMonth);
	}
	
	//자원봉사 모집글 등록하기
	@Override
	public int insertVolunteerApply(VolunteerApplyDto volunteerApply) {
		return volunteerApplyDao.insertVolunteerApply(volunteerApply);
	}
	
	//자원봉사 모집 상세글 불러오기
	@Override
	public VolunteerApplyDto selectVolunteerApply(String volunteer_date) {
		return volunteerApplyDao.selectVolunteerApply(volunteer_date);
	}
	
	//자원봉사 모집 상세글 수정하기
	@Override
	public int updateVolunteerApply(VolunteerApplyDto volunteerApply) {
		return volunteerApplyDao.updateVolunteerApply(volunteerApply);
	}
	
	//자원봉사 신청자 목록 불러오기
	@Override
	public ArrayList<VolunteerApplierDto> selectVolunteerApplierList(VolunteerApplierDto pageDto){
		return (ArrayList<VolunteerApplierDto>)volunteerApplyDao.selectVolunteerApplierList(pageDto);
	}
	
	//자원봉사 신청하기(insert)
	@Override
	public HashMap insertApplyVolunteer(HashMap<String, String> map) {
		return volunteerApplyDao.insertApplyVolunteer(map);
	}
	
	//자원봉사 취소하기(delete)
	@Override
	public int deleteApplyVolunteer(HashMap<String, String> map) {
		return volunteerApplyDao.deleteApplyVolunteer(map);
	}
	
	//자원봉사 신청여부 상태값 얻기(select)
	@Override
	public int selectCheckVolunteerApply(HashMap<String, String> map) {
		return volunteerApplyDao.selectCheckVolunteerApply(map);
	}
	
	
}
