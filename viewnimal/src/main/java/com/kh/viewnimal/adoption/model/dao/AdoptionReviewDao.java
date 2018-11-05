package com.kh.viewnimal.adoption.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.adoption.model.dto.AdoptionPetDto;
import com.kh.viewnimal.adoption.model.dto.AdoptionReviewDto;
import com.kh.viewnimal.adoption.model.dto.AdoptionReviewReplyDto;

@Repository("adoptionReviewDao")
public class AdoptionReviewDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public AdoptionReviewDao(){}
	
	// 총 입양 후기 게시글 수
	public int getReviewListCount() {
		return sqlSession.selectOne("adoptionMapper.getReviewListCount");
	};	
	
	// 입양 후기 리스트 조회
	public List<AdoptionReviewDto> selectReviewList(HashMap<String, Integer> hmap) {
		return sqlSession.selectList("adoptionMapper.selectReviewList", hmap);
	};
	
	// 입양 후기 등록
	public int insertReview(AdoptionReviewDto review) {
		return sqlSession.insert("adoptionMapper.insertReview", review);
	}
	
	// 입양 후기 수정
	public int updateAdoptionReview(AdoptionReviewDto review){
		return sqlSession.update("adoptionMapper.updateAdoptionReview", review);
	}
	
	// 입양 후기 삭제
	public int deleteAdoptionReview(int no) {
		return sqlSession.delete("adoptionMapper.deleteReview", no);
	}
	
	// 입양 후기 상세 조회
	public AdoptionReviewDto selectAdoptionReviewDetail(String pet_id) {
		return sqlSession.selectOne("adoptionMapper.selectReview", pet_id);
	}
	
	// 입양 후기 조회수 증가
	public int updateCount(int origin_no) {
		return sqlSession.update("adoptionMapper.updateCount", origin_no);
	}
	
	// 입양 후기 댓글 입력
	public int insertReply(HashMap<String, Object> hmap) {
		return sqlSession.insert("adoptionMapper.insertReply", hmap);
	}	
	
	// 입양 후기 댓글 수정
	public int updateReply(HashMap<String, Object> hmap) {
		return sqlSession.update("adoptionMapper.updateReply", hmap);
	}
	
	// 입양 후기 댓글 삭제
	public int deleteReply(int no) {
		return sqlSession.delete("adoptionMapper.deleteReply", no);
	}	
	
	// 입양 후기 댓글 조회
	public List<AdoptionReviewReplyDto> selectAdoptionReviewReply(int no){
		return sqlSession.selectList("adoptionMapper.selectReviewReply", no);
	}

	// 입양 후기 댓글 수
	public int getReplyCount(int origin_no) {
		return sqlSession.selectOne("adoptionMapper.getReplyCount", origin_no);
	}

	// 입양 후기 동물 조회
	public AdoptionPetDto selectPet(String name) {
		return sqlSession.selectOne("adoptionMapper.petReview", name);
	}

}
