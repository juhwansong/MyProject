package com.kh.viewnimal.adoption.model.service;

import java.util.HashMap;
import java.util.List;

import com.kh.viewnimal.adoption.model.dto.AdoptionPetDto;

public interface AdoptionPetService {

	//입양 동물 등록
	public abstract int insertPet(AdoptionPetDto pet);

	//전체 목록 갯수
	public abstract int getPetListCount();

	//입양 동물 리스트 조회
	public abstract List<AdoptionPetDto> selectPetList(HashMap<String, Integer> hmap);

	//입양 동물 수정 페이지로 이동
	public abstract AdoptionPetDto selectPet(String pet_id);

	//입양 동물 수정
	public abstract int updatePet(AdoptionPetDto pet);
	
	//active 상태 N으로
	public abstract int updateActive(String pet_id);
}
