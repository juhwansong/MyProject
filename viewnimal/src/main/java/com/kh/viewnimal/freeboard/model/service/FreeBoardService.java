package com.kh.viewnimal.freeboard.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.viewnimal.freeboard.model.dto.FreeBoardDto;
import com.kh.viewnimal.freeboard.model.dto.FreeBoardReplyDto;

public interface FreeBoardService {

	//자유게시판 리스트
	public abstract ArrayList<FreeBoardDto> selectListFreeBoard( HashMap<String, Integer> row );
	
	//자유게시판 총 게시글 개수 ( for 페이징 )
	public abstract int selectTotalCountFreeBoard();
	
	//자유게시판 상세페이지
	public abstract FreeBoardDto selectDetailFreeBoard( int no );
	
	//자유게시판 조회수 증가
	public abstract int updateReadCount( int no );
		
	//자유게시판 글 작성
	public abstract int insertFreeBoard( FreeBoardDto freeBoardDto );
	
	//자유게시판 답글 작성 update
	public abstract int updateBeforeInsertFreeBoard( FreeBoardDto freeBoardDto );
	
	//자유게시판 답글 작성 insert
	public abstract int insertWriteReplyFreeBoard(FreeBoardDto freeBoardDto);

	//자유게시판 글 수정
	public abstract int updateFreeBoard( FreeBoardDto freeBoardDto );
	
	//자유게시판 글 삭제 (비공개)
	public abstract int updateNonActiveFreeBoard( int no );
	
	//자유게시판 글 검색 카테고리 불러오기
	public abstract ArrayList<String> selectSearchCategoryFreeBoard();
	
	//자유게시판 글 검색 리스트
	public abstract ArrayList<FreeBoardDto> selectSearchListFreeBoard(HashMap<String, String> map);

	//자유게시판 댓글 리스트
	public abstract ArrayList<FreeBoardReplyDto> selectListFreeBoardReply(HashMap<String, Integer> row);
	
	//자유게시판 댓글 총 개수
	public abstract int selectTotalCountFreeBoardReply( int board_no );
	
	//자유게시판 댓글 작성
	public abstract int insertFreeBoardReply( FreeBoardReplyDto freeBoardReplyDto );
	
	//자유게시판 댓글 수정
	public abstract int updateFreeBoardReply( FreeBoardReplyDto freeBoardReplyDto );
	
	//자유게시판 댓글 삭제
	public abstract int deleteFreeBoardReply( int no );

}
