package com.kh.viewnimal.adoption.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.adoption.model.dao.AdoptionReviewDao;
import com.kh.viewnimal.adoption.model.dto.AdoptionPetDto;
import com.kh.viewnimal.adoption.model.dto.AdoptionReviewDto;
import com.kh.viewnimal.adoption.model.dto.AdoptionReviewReplyDto;

@Service("adoptionReviewService")
public class AdoptionReviewServiceImpl implements AdoptionReviewService{
	@Autowired
	private AdoptionReviewDao adoptionReviewDao;
	
	// 총 입양 후기 게시글 수
	@Override
	public int getReviewListCount(){
		return adoptionReviewDao.getReviewListCount();
	}
	
	// 입양 후기 리스트 조회
	@Override
	public List<AdoptionReviewDto> selectReviewList(HashMap<String, Integer> hmap) {
		return adoptionReviewDao.selectReviewList(hmap);
	}

	// 입양 후기 등록
	@Override
	public int insertReview(AdoptionReviewDto review) {
		return adoptionReviewDao.insertReview(review);		
	}	

	// 입양 후기 수정
	@Override
	public int updateAdoptionReview(AdoptionReviewDto review) {
		return adoptionReviewDao.updateAdoptionReview(review);
	}
	
	// 입양 후기 삭제
	@Override
	public int deleteReview(int no) {
		return adoptionReviewDao.deleteAdoptionReview(no);
	}

	// 입양 후기 상세 조회
	@Override
	public AdoptionReviewDto selectAdoptionReviewDetail(String pet_id) {
		return adoptionReviewDao.selectAdoptionReviewDetail(pet_id);
	}
	
	// 입양 후기 조회수 증가
	@Override
	public int updateCount(int origin_no) {
		return adoptionReviewDao.updateCount(origin_no);
	}

	// 입양 후기 댓글 입력
	@Override
	public int insertReply(HashMap<String, Object> hmap) {
		return adoptionReviewDao.insertReply(hmap);
	}

	@Override
	public int updateReply(HashMap<String, Object> hmap) {
		return adoptionReviewDao.updateReply(hmap);
	}

	// 입양 후기 댓글 삭제
	@Override
	public int deleteReply(int no) {
		return adoptionReviewDao.deleteReply(no);
	}
	
	// 댓글 조회
	@Override
	public List<AdoptionReviewReplyDto> selectAdoptionReviewReply(int no) {
		return adoptionReviewDao.selectAdoptionReviewReply(no);
	}

	// 입양 후기 댓글 수
	@Override
	public int getReplyCount(int origin_no) {
		return adoptionReviewDao.getReplyCount(origin_no);
	}

	// 입양 후기 동물 조회
	@Override
	public AdoptionPetDto selectPet(String name) {
		return adoptionReviewDao.selectPet(name);
	}

}


