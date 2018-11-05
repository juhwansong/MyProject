package com.kh.viewnimal.adoption.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.adoption.model.dto.AdoptionPetDto;

@Repository("adoptionPetDao")
public class AdoptionPetDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public AdoptionPetDao(){}
	
	// 입양 동물 등록
	public int insertPet(AdoptionPetDto pet){
		return sqlSession.insert("adoptionMapper.insertPet", pet);
	}

	// 전체 목록 갯수
	public int getPetListCount() {
		return sqlSession.selectOne("adoptionMapper.getPetListCount");
	}

	// 입양 동물 리스트 조회
	public List<AdoptionPetDto> selectPetList(HashMap<String, Integer> hmap) {
		return sqlSession.selectList("adoptionMapper.selectPetList", hmap);
	}

	// 입양 동물 수정 페이지로 이동
	public AdoptionPetDto selectPet(String pet_id) {
		return sqlSession.selectOne("adoptionMapper.selectPet", pet_id);
	}

	// 입양 동물 수정
	public int updatePet(AdoptionPetDto pet) {
		return sqlSession.update("adoptionMapper.updatePet", pet);
	}

	// active 상태 N으로
	public int updateActive(String pet_id) {
		return sqlSession.update("adoptionMapper.updateActive", pet_id);
	}

}
