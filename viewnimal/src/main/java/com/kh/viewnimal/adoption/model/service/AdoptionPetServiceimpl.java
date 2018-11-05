package com.kh.viewnimal.adoption.model.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.adoption.model.dao.AdoptionPetDao;
import com.kh.viewnimal.adoption.model.dto.AdoptionPetDto;

@Service("adoptionPetService")
public class AdoptionPetServiceimpl implements AdoptionPetService{
	@Autowired
	private AdoptionPetDao adoptionPetDao;

	// 입양 동물 등록
	@Override
	public int insertPet(AdoptionPetDto pet) {
		return adoptionPetDao.insertPet(pet);		
	}

	// 전체 목록 갯수
	@Override
	public int getPetListCount() {
		return adoptionPetDao.getPetListCount();
	}

	// 입양 동물 리스트 조회
	@Override
	public List<AdoptionPetDto> selectPetList(HashMap<String, Integer> hmap) {
		// TODO Auto-generated method stub
		return adoptionPetDao.selectPetList(hmap);
	}

	// 입양 동물 수정 페이지로 이동
	@Override
	public AdoptionPetDto selectPet(String pet_id) {
		return adoptionPetDao.selectPet(pet_id);
	}

	// 입양 동물 수정
	@Override
	public int updatePet(AdoptionPetDto pet) {
		return adoptionPetDao.updatePet(pet);
	}

	// active 상태 N으로
	@Override
	public int updateActive(String pet_id) {
		return adoptionPetDao.updateActive(pet_id);
	}
}
