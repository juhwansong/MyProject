package com.kh.viewnimal.adoption.model.service;

import java.util.HashMap;
import java.util.List;

import com.kh.viewnimal.adoption.model.dto.AdoptionAdminDto;
import com.kh.viewnimal.adoption.model.dto.AdoptionApplyDto;
import com.kh.viewnimal.adoption.model.dto.AdoptionReviewDto;

public interface AdoptionApplyService {
	
	// 입양 신청
	public abstract int insertAdoption(AdoptionApplyDto applyDto);
	
	// 입양 신청 내역 조회
	AdoptionApplyDto selectApplyAdoption(int no);
	
	// 입양 신청 내역 삭제
	public abstract int deleteApply(int no);
	
	// 관리자 입양 신청 관리 리스트 수
	public abstract int getAdminListCount();
	
	// 관리자 입양 신청 관리 페이지로 이동 및 조회
	public abstract List<AdoptionAdminDto> selectAdminList(HashMap<String, Integer> hmap);

	// 관리자 입양 신청 관리 페이지에서 상태 수정
	public abstract int updateState(HashMap<String, Object> hmap);

	// 관리자 검색 기능
	public abstract List<AdoptionAdminDto> adminSearch(HashMap<String, Object> hmap);

	// review 상태 'Y'으로
	public abstract int updateReview(int no);

	// 입양 완료된 동물 조회
	public abstract List<String> selectAdoptedPet();


}
