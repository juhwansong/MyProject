
package com.kh.viewnimal.adoption.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.adoption.model.dto.AdoptionAdminDto;
import com.kh.viewnimal.adoption.model.dto.AdoptionApplyDto;
import com.kh.viewnimal.adoption.model.dto.AdoptionReviewDto;

@Repository("adoptionApplyDao")
public class AdoptionApplyDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public AdoptionApplyDao(){}
	
	// 입양 신청
	public int insertAdoption(AdoptionApplyDto applyDto) {
		return sqlSession.insert("adoptionMapper.insertAdoption", applyDto);		
	};	
	
	// 입양 신청 내역 조회
	public AdoptionApplyDto selectApplyAdoption(int no){
		return sqlSession.selectOne("adoptionMapper.selectAdoptionApply", no);
	};
	
	// 관리자 입양 신청 관리 리스트 수
	public int getAdminListCount() {
		return sqlSession.selectOne("adoptionMapper.getAdminListCount");
	}

	// 관리자 입양 신청 관리 페이지로 이동 및 조회
	public List<AdoptionAdminDto> selectAdminList(HashMap<String, Integer> hmap) {
		return sqlSession.selectList("adoptionMapper.selectAdminList", hmap);
	}

	// 관리자 입양 신청 관리 페이지에서 상태 수정
	public int updateState(HashMap<String, Object> hmap) {
		return sqlSession.update("adoptionMapper.updateState", hmap);
	}

	// 관리자 검색 기능
	public List<AdoptionAdminDto> adminSearch(HashMap<String, Object> hmap) {
		return sqlSession.selectList("adoptionMapper.adminSearch", hmap);
	}

	// review 상태 'Y'으로
	public int updateReview(int no) {
		return sqlSession.update("adoptionMapper.updateReview", no);
	}

	// 입양 신청 내역 삭제
	public int deleteApply(int no) {
		return sqlSession.delete("adoptionMapper.deleteApply", no);
	}

	// 입양 완료된 동물 조회
	public List<String> selectAdoptedPet() {
		return sqlSession.selectList("adoptionMapper.selectAdoptedPet");
	}

}
