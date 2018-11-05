package com.kh.viewnimal.volunteerapply.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplierDto;
import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplyDto;

@Repository("volunteerApplyDao")
public class VolunteerApplyDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public VolunteerApplyDao(){}
	
	//자원봉사 모집글 검색 카테고리 목록(년,월) 불러오기
	public ArrayList<String> selectVolunteerApplyCategoryList(){
		return null;
	}
	
	//자원봉사 모집글 리스트(특정 한달치만) 불러오기
	public ArrayList<VolunteerApplyDto> selectSearchVolunteerApplyList(String selectedYearMonth){
		return new ArrayList<VolunteerApplyDto>(sqlSession.selectList("volunteerapplyMapper.selectSearchVolunteerApplyList", selectedYearMonth));
	}
	
	//자원봉사 모집글 등록하기
	public int insertVolunteerApply(VolunteerApplyDto volunteerApply){
		return sqlSession.insert("volunteerapplyMapper.insertVolunteerApply", volunteerApply);
	}
	
	//자원봉사 모집 상세글 불러오기
	public VolunteerApplyDto selectVolunteerApply(String volunteer_date){
		return sqlSession.selectOne("volunteerapplyMapper.selectVolunteerApply", volunteer_date);
	}
	
	//자원봉사 모집 상세글 수정하기
	public int updateVolunteerApply(VolunteerApplyDto volunteerApply){	
		return sqlSession.update("volunteerapplyMapper.updateVolunteerApply", volunteerApply);
	}
	
	//자원봉사 신청자 목록 불러오기
	public List selectVolunteerApplierList(VolunteerApplierDto pageDto){
		return sqlSession.selectList("volunteerapplyMapper.selectVolunteerApplierList", pageDto);
	}
	
	//자원봉사 신청여부 상태값 얻기(select)
	public int selectCheckVolunteerApply(HashMap<String, String> map) {
		return sqlSession.selectOne("volunteerapplyMapper.selectCheckVolunteerApply", map);
	}
	
	//자원봉사 신청하기(insert)
	public HashMap insertApplyVolunteer(HashMap<String, String> map){
		sqlSession.selectOne("volunteerapplyMapper.insertApplyVolunteer", map);
		return map;
	}
	
	//자원봉사 취소하기(delete)
	public int deleteApplyVolunteer(HashMap<String, String> map){
		return sqlSession.delete("volunteerapplyMapper.deleteApplyVolunteer", map);
	}
	
}
