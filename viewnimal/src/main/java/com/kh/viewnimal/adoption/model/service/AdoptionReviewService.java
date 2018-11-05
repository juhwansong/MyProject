package com.kh.viewnimal.adoption.model.service;

import java.util.HashMap;
import java.util.List;

import com.kh.viewnimal.adoption.model.dto.AdoptionPetDto;
import com.kh.viewnimal.adoption.model.dto.AdoptionReviewDto;
import com.kh.viewnimal.adoption.model.dto.AdoptionReviewReplyDto;

public interface AdoptionReviewService {
	
	// 총 입양 후기 게시글 수
	public abstract int getReviewListCount();
	
	// 입양 후기 리스트 조회
	public abstract List<AdoptionReviewDto> selectReviewList(HashMap<String, Integer> hmap);	
	
	// 입양 후기 등록
	public abstract int insertReview(AdoptionReviewDto review);
	
	// 입양 후기 수정
	public abstract int updateAdoptionReview(AdoptionReviewDto review);
	
	// 입양 후기 삭제
	public abstract int deleteReview(int no);
	
	// 입양 후기 상세 조회
	public abstract AdoptionReviewDto selectAdoptionReviewDetail(String pet_id);
	
	// 입양 후기 조회수 증가
	public abstract int updateCount(int origin_no);
	
	// 입양 후기 댓글 입력
	public abstract int insertReply(HashMap<String, Object> hmap);
	
	// 입양 후기 댓글 수정
	public abstract int updateReply(HashMap<String, Object> hmap);
	
	// 입양 후기 댓글 삭제
	public abstract int deleteReply(int no);
	
	// 입양 후기 댓글 조회
	public abstract List<AdoptionReviewReplyDto> selectAdoptionReviewReply(int no);

	// 입양 후기 댓글 수
	public abstract int getReplyCount(int origin_no);

	// 입양 후기 동물 조회
	public abstract AdoptionPetDto selectPet(String name);

}
