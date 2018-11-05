package com.kh.viewnimal.adoption.model.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.adoption.model.dao.AdoptionApplyDao;
import com.kh.viewnimal.adoption.model.dto.AdoptionAdminDto;
import com.kh.viewnimal.adoption.model.dto.AdoptionApplyDto;

@Service("adoptionApplyService")
public class AdoptionApplyServiceImpl implements AdoptionApplyService{
	@Autowired
	private AdoptionApplyDao adoptionApplyDao;

	// 입양 신청
	@Override
	public int insertAdoption(AdoptionApplyDto applyDto) {
		return adoptionApplyDao.insertAdoption(applyDto);	
	}	

	// 입양 신청 내역 조회
	@Override
	public AdoptionApplyDto selectApplyAdoption(int no) {
		return adoptionApplyDao.selectApplyAdoption(no);
	}

	@Override
	public int getAdminListCount() {
		return adoptionApplyDao.getAdminListCount();
	}

	// 관리자 입양 신청 관리 페이지로 이동 및 조회
	@Override
	public List<AdoptionAdminDto> selectAdminList(HashMap<String, Integer> hmap) {
		return adoptionApplyDao.selectAdminList(hmap);
	}

	// 관리자 입양 신청 관리 페이지에서 상태 수정
	@Override
	public int updateState(HashMap<String, Object> hmap) {
		return adoptionApplyDao.updateState(hmap);
	}

	// 관리자 검색기능
	@Override
	public List<AdoptionAdminDto> adminSearch(HashMap<String, Object> hmap) {
		return adoptionApplyDao.adminSearch(hmap);
	}

	// review 상태 'Y'으로
	@Override
	public int updateReview(int no) {
		return adoptionApplyDao.updateReview(no);
	}

	// 입양 신청 내역 삭제
	@Override
	public int deleteApply(int no) {
		return adoptionApplyDao.deleteApply(no);
	}

	// 입양 완료된 동물 조회
	@Override
	public List<String> selectAdoptedPet() {
		return adoptionApplyDao.selectAdoptedPet();
	}
	
}
