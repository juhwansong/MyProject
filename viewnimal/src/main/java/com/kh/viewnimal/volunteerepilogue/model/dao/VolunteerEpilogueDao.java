package com.kh.viewnimal.volunteerepilogue.model.dao;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.volunteerepilogue.model.dto.VolunteerEpilogueDto;
import com.kh.viewnimal.volunteerepilogue.model.dto.VolunteerEpilogueReplyDto;

@Repository("volunteerEpilogueDao")
public class VolunteerEpilogueDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public VolunteerEpilogueDao(){}
	
	//자원봉사 쓰기 글 버튼 눌렀을 때 쓸 수 있는 글이 있는지 없는지 상태값 반환
	public List selectVolunteerEpiloguePossibleState(String userId){	
		return sqlSession.selectList("volunteerepilogueMapper.selectVolunteerEpiloguePossibleState", userId);
	}
		
	//자원봉사 후기 글 검색 카테고리 목록(년,월,일) 불러오기
	public List selectVolunteerEpilogueCategoryList(String categoryKeword){
		return sqlSession.selectList("volunteerepilogueMapper.selectVolunteerEpilogueCategoryList",categoryKeword);
	}
	
	//자원봉사 후기 글 등록 가능한 목록 카테고리 가져오기
	public List selectVolunteerEpilogueWriteCategoryList(String id){
		return sqlSession.selectList("volunteerepilogueMapper.selectVolunteerEpilogueWriteCategoryList", id);	
	}
			
	//자원봉사 후기 검색 결과 목록 불러오기  
	public List selectSearchVolunteerEpilogue(VolunteerEpilogueDto keywordDto){
		return sqlSession.selectList("volunteerepilogueMapper.selectSearchVolunteerEpilogue", keywordDto);
	}
	
	//자원봉사 후기 검색 결과 목록 글 갯수 가져오기
	public int selectCountSearchVolunteerEpilogueList(VolunteerEpilogueDto keywordDto){
		return sqlSession.selectOne("volunteerepilogueMapper.selectCountSearchVolunteerEpilogueList", keywordDto);
	}
	
	//자원봉사 후기 글 등록하기
	public int insertVolunteerEpilogue(VolunteerEpilogueDto volunteerEpilogue){
		return sqlSession.insert("volunteerepilogueMapper.insertVolunteerEpilogue", volunteerEpilogue);
	}
	
	//자원봉사 후기 글 썼을때 신청자테이블에서 후기 글 쓴 여부 상태값 변경//자원봉사 후기 글 썼을때 신청자테이블에서 후기 글 쓴 여부 상태값 변경
	public int updateVolunteerAppilerState(VolunteerEpilogueDto volunteerEpilogue){
		return sqlSession.update("volunteerepilogueMapper.updateVolunteerAppilerState", volunteerEpilogue);
	}
	
	//자원봉사 후기 글 수정하기
	public int updateVolunteerEpilogue(VolunteerEpilogueDto volunteerEpilogue){
		return sqlSession.update("volunteerepilogueMapper.updateVolunteerEpilogue", volunteerEpilogue);
	}
	
	//해당 자원봉사 후기 글 안 보이게 하기(상태 바꾸기)
	public int updateNonActiveVolunteerEpilogue(VolunteerEpilogueDto volunteerEpilogue){
		return sqlSession.update("volunteerepilogueMapper.updateNonActiveVolunteerEpilogue", volunteerEpilogue);
	}
	
	//자원봉사 후기 글 상태 바꾸기 값 바꿨을 때 해당 봉사날짜 후기글 다시 쓸수 있게 트랜젝션
	public int updateVolunteerEpilogueStateChange(VolunteerEpilogueDto volunteerEpilogue){
		return sqlSession.update("volunteerepilogueMapper.updateVolunteerEpilogueStateChange", volunteerEpilogue);
	}
	
	//자원봉사 후기 상세글 불러오기
	public VolunteerEpilogueDto selectVolunteerEpilogue(int no){
		return sqlSession.selectOne("volunteerepilogueMapper.selectVolunteerEpilogue", no);
	}
	
	//자원봉사 후기 글 조회수 증가시키기
	public int updateAddReadCountVolunteerEpilogue(int no){
		return sqlSession.update("volunteerepilogueMapper.updateAddReadCountVolunteerEpilogue", no);
	}
	
	//자원봉사 후기글 댓글 작성
	public int insertVolunteerEpilogueReply(VolunteerEpilogueReplyDto volunteerEpilogueReply){
		return sqlSession.insert("volunteerepilogueMapper.insertVolunteerEpilogueReply", volunteerEpilogueReply);
	}
	
	//자원봉사 후기글 댓글 목록 불러오기
	public List selectVolunteerEpilogueReplyList(VolunteerEpilogueReplyDto keywordDto){
		return sqlSession.selectList("volunteerepilogueMapper.selectVolunteerEpilogueReplyList", keywordDto);
	}
	
	//자원봉사 후기 댓글 갯수 가져오기
	public int selectCountVolunteerEpilogueReplyList(VolunteerEpilogueReplyDto keywordDto){
		return sqlSession.selectOne("volunteerepilogueMapper.selectCountVolunteerEpilogueReplyList", keywordDto);
	}
	
	//자원봉사 후기글 댓글 수정하기
	public int updateVolunteerEpilogueReply(VolunteerEpilogueReplyDto volunteerEpilogueReply){
		return sqlSession.update("volunteerepilogueMapper.updateVolunteerEpilogueReply", volunteerEpilogueReply);
	}
	
	//자원봉사 후기글 댓글 삭제하기
	public int deleteVolunteerEpilogueReply(VolunteerEpilogueReplyDto volunteerEpilogueReply){
		return sqlSession.delete("volunteerepilogueMapper.deleteVolunteerEpilogueReply", volunteerEpilogueReply);
	}
	
}
