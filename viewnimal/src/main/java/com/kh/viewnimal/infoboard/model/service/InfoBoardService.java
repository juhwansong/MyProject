package com.kh.viewnimal.infoboard.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.viewnimal.infoboard.model.dto.InfoBoardDto;
import com.kh.viewnimal.infoboard.model.dto.InfoBoardReplyDto;



public interface InfoBoardService {

	// 생정게시판 리스트
    ArrayList<InfoBoardDto> selectInfoBoardList(HashMap<String, String> map);
	
	// 생정게시판 상세페이지
	InfoBoardDto selectInfoBoardDetail(int no);
	
	// 생정게시판 글 작성
	int insertInfoBoard(InfoBoardDto infoBoard );
	
	// 생정게시판 글 수정
	int UpdateInfoBoard(InfoBoardDto infoBoard );
	
	// 생정게시판 글 삭제 (비공개)
	int updateInfoBoardNonActive(int no);
	
	// 생정게시판 글 검색
	ArrayList<InfoBoardDto> selectInfoBoardSearch(HashMap<String, String> search );
	
	// 생정게시판 댓글 리스트
	ArrayList<InfoBoardReplyDto> selectInfoBoardReplyList(HashMap<String, String> search );
	
	// 생정게시판 댓글 작성
	int  insertInfoBoardReply(InfoBoardReplyDto infoBoardReply);
	
	// 생정게시판 댓글 수정
	int  updateInfoBoardReply(InfoBoardReplyDto infoBoardReply );
	
	// 생정게시판 댓글 삭제
	int  deleteInfoBoardReply(int no);
	
	
	
	
}
