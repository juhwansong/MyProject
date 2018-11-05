package com.kh.viewnimal.volunteerapply.model.service;

import java.util.ArrayList;
import java.util.HashMap;


import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplierDto;
import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplyDto;

public interface VolunteerApplyService {
	
	//자원봉사 모집글 검색 카테고리 목록(년,월) 불러오기
	public abstract ArrayList<String> selectVolunteerApplyCategoryList();
	
	//자원봉사 모집글 리스트(특정 한달치만) 불러오기
	public abstract ArrayList<VolunteerApplyDto> selectSearchVolunteerApplyList(String selectedYearMonth);
	
	//자원봉사 모집글 등록하기
	public abstract int insertVolunteerApply(VolunteerApplyDto volunteerApply);
	
	//자원봉사 모집 상세글 불러오기
	public abstract VolunteerApplyDto selectVolunteerApply(String volunteer_date);
	
	//자원봉사 모집 상세글 수정하기
	public abstract int updateVolunteerApply(VolunteerApplyDto volunteerApply);
	
	//자원봉사 신청자 목록 불러오기
	public abstract ArrayList<VolunteerApplierDto> selectVolunteerApplierList(VolunteerApplierDto pageDto);
	
	//자원봉사 신청여부 상태값 얻기(select)
	public abstract int selectCheckVolunteerApply(HashMap<String, String> map);
	
	//자원봉사 신청하기(insert)
	public abstract HashMap insertApplyVolunteer(HashMap<String, String> map);
	
	//자원봉사 취소하기(delete)
	public abstract int deleteApplyVolunteer(HashMap<String, String> map);
	
}
