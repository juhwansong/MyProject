package com.kh.viewnimal.volunteerepilogue.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplierDto;
import com.kh.viewnimal.volunteerepilogue.model.dao.VolunteerEpilogueDao;
import com.kh.viewnimal.volunteerepilogue.model.dto.VolunteerEpilogueDto;
import com.kh.viewnimal.volunteerepilogue.model.dto.VolunteerEpilogueReplyDto;

@Service("volunteerEpilogueService")
public class VolunteerEpilogueServiceImpl implements VolunteerEpilogueService {
	@Autowired
	private VolunteerEpilogueDao volunteerEpilogueDao;
	
	//자원봉사 쓰기 글 버튼 눌렀을 때 쓸 수 있는 글이 있는지 없는지 상태값 반환
	@Override
	public ArrayList<VolunteerApplierDto> selectVolunteerEpiloguePossibleState(String userId){
		
		
		
		return (ArrayList<VolunteerApplierDto>)volunteerEpilogueDao.selectVolunteerEpiloguePossibleState(userId);
	}
	
	//자원봉사 후기 글 검색 카테고리 목록(년,월,일) 불러오기
	@Override
	public ArrayList<String> selectVolunteerEpilogueCategoryList(String categoryKeword) {
		return (ArrayList<String>)volunteerEpilogueDao.selectVolunteerEpilogueCategoryList(categoryKeword);
	}
	
	//자원봉사 후기 글 등록 가능한 목록 카테고리 가져오기
	@Override
	public ArrayList<VolunteerEpilogueDto> selectVolunteerEpilogueWriteCategoryList(String id){
		return (ArrayList<VolunteerEpilogueDto>)volunteerEpilogueDao.selectVolunteerEpilogueWriteCategoryList(id);
	}

	//자원봉사 후기 검색 결과 목록 불러오기
	@Override
	public ArrayList<VolunteerEpilogueDto> selectSearchVolunteerEpilogue(VolunteerEpilogueDto keywordDto) {
		return (ArrayList<VolunteerEpilogueDto>)volunteerEpilogueDao.selectSearchVolunteerEpilogue(keywordDto);
	}

	//자원봉사 후기 검색 결과 목록 글 갯수 가져오기
	@Override
	public int selectCountSearchVolunteerEpilogueList(VolunteerEpilogueDto keywordDto) {
		return volunteerEpilogueDao.selectCountSearchVolunteerEpilogueList(keywordDto);
	}

	//자원봉사 후기 글 등록하기
	@Override
	public int insertVolunteerEpilogue(VolunteerEpilogueDto volunteerEpilogue) {
		//둘중에 하나라도 0이 return되면 0 return
		return (volunteerEpilogueDao.insertVolunteerEpilogue(volunteerEpilogue) * volunteerEpilogueDao.updateVolunteerAppilerState(volunteerEpilogue)); 
	}

	//자원봉사 후기 글 수정하기
	@Override
	public int updateVolunteerEpilogue(VolunteerEpilogueDto volunteerEpilogue) {
		return volunteerEpilogueDao.updateVolunteerEpilogue(volunteerEpilogue);
	}

	//해당 자원봉사 후기 글 안 보이게 하기(상태 바꾸기)
	@Override
	public int updateNonActiveVolunteerEpilogue(VolunteerEpilogueDto volunteerEpilogue) {//게시글 상태 값 바꾸고, 해당 봉사날짜 후기 쓸수 있게
		
		return volunteerEpilogueDao.updateNonActiveVolunteerEpilogue(volunteerEpilogue) * volunteerEpilogueDao.updateVolunteerEpilogueStateChange(volunteerEpilogue);
	}

	//자원봉사 후기 상세글 불러오기
	@Override
	public VolunteerEpilogueDto selectVolunteerEpilogue(int no) {
		return volunteerEpilogueDao.selectVolunteerEpilogue(no);
	}

	//자원봉사 후기 글 조회수 증가시키기
	@Override
	public int updateAddReadCountVolunteerEpilogue(int no) {
		return volunteerEpilogueDao.updateAddReadCountVolunteerEpilogue(no);
	}
	
	//자원봉사 후기글 댓글 작성
	@Override
	public int insertVolunteerEpilogueReply(VolunteerEpilogueReplyDto volunteerEpilogueReply){
		return volunteerEpilogueDao.insertVolunteerEpilogueReply(volunteerEpilogueReply);
	}

	//자원봉사 후기글 댓글 목록 불러오기
	@Override
	public ArrayList<VolunteerEpilogueReplyDto> selectVolunteerEpilogueReplyList(VolunteerEpilogueReplyDto keywordDto) {
		return (ArrayList<VolunteerEpilogueReplyDto>)volunteerEpilogueDao.selectVolunteerEpilogueReplyList(keywordDto);
	}

	//자원봉사 후기 댓글 갯수 가져오기
	@Override
	public int selectCountVolunteerEpilogueReplyList(VolunteerEpilogueReplyDto keywordDto) {
		return volunteerEpilogueDao.selectCountVolunteerEpilogueReplyList(keywordDto);
	}

	//자원봉사 후기글 댓글 수정하기
	@Override
	public int updateVolunteerEpilogueReply(VolunteerEpilogueReplyDto volunteerEpilogueReply) {
		return volunteerEpilogueDao.updateVolunteerEpilogueReply(volunteerEpilogueReply);
	}

	//자원봉사 후기글 댓글 삭제하기
	@Override
	public int deleteVolunteerEpilogueReply(VolunteerEpilogueReplyDto volunteerEpilogueReply) {
		return volunteerEpilogueDao.deleteVolunteerEpilogueReply(volunteerEpilogueReply);
	}
	
	
	
}
