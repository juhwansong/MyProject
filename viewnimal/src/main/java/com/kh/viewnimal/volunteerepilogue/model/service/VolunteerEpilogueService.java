package com.kh.viewnimal.volunteerepilogue.model.service;

import java.util.ArrayList;

import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplierDto;
import com.kh.viewnimal.volunteerepilogue.model.dto.VolunteerEpilogueDto;
import com.kh.viewnimal.volunteerepilogue.model.dto.VolunteerEpilogueReplyDto;

public interface VolunteerEpilogueService {
	
	//자원봉사 쓰기 글 버튼 눌렀을 때 쓸 수 있는 글이 있는지 없는지 상태값 반환
	public ArrayList<VolunteerApplierDto> selectVolunteerEpiloguePossibleState(String userId);
	
	//자원봉사 후기 글 검색 카테고리 목록(년,월,일) 불러오기
	public ArrayList<String> selectVolunteerEpilogueCategoryList(String categoryKeword);
	
	//자원봉사 후기 글 등록 가능한 목록 카테고리 가져오기
	public ArrayList<VolunteerEpilogueDto> selectVolunteerEpilogueWriteCategoryList(String id);
	
	//자원봉사 후기 검색 결과 목록 불러오기  
	public ArrayList<VolunteerEpilogueDto> selectSearchVolunteerEpilogue(VolunteerEpilogueDto keywordDto);
	
	//자원봉사 후기 검색 결과 목록 글 갯수 가져오기
	public int selectCountSearchVolunteerEpilogueList(VolunteerEpilogueDto keywordDto);
	
	//자원봉사 후기 글 등록하기
	public int insertVolunteerEpilogue(VolunteerEpilogueDto volunteerEpilogue);
	
	//자원봉사 후기 글 수정하기
	public int updateVolunteerEpilogue(VolunteerEpilogueDto volunteerEpilogue);
	
	//해당 자원봉사 후기 글 안 보이게 하기(상태 바꾸기)
	public int updateNonActiveVolunteerEpilogue(VolunteerEpilogueDto volunteerEpilogue);
	
	//자원봉사 후기 상세글 불러오기
	public VolunteerEpilogueDto selectVolunteerEpilogue(int no);
	
	//자원봉사 후기 글 조회수 증가시키기
	public int updateAddReadCountVolunteerEpilogue(int no);
	
	//자원봉사 후기글 댓글 목록 불러오기
	public ArrayList<VolunteerEpilogueReplyDto> selectVolunteerEpilogueReplyList(VolunteerEpilogueReplyDto keywordDto);
	
	//자원봉사 후기글 댓글 작성
	public int insertVolunteerEpilogueReply(VolunteerEpilogueReplyDto volunteerEpilogueReply);
	
	//자원봉사 후기 댓글 갯수 가져오기
	public int selectCountVolunteerEpilogueReplyList(VolunteerEpilogueReplyDto keywordDto);
	
	//자원봉사 후기글 댓글 수정하기
	public int updateVolunteerEpilogueReply(VolunteerEpilogueReplyDto volunteerEpilogueReply);
	
	//자원봉사 후기글 댓글 삭제하기
	public int deleteVolunteerEpilogueReply(VolunteerEpilogueReplyDto volunteerEpilogueReply);
}
