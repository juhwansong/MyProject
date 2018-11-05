package com.kh.viewnimal.freeboard.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.freeboard.model.dao.FreeBoardDao;
import com.kh.viewnimal.freeboard.model.dto.FreeBoardDto;
import com.kh.viewnimal.freeboard.model.dto.FreeBoardReplyDto;

@Service("freeBoardService")
public class FreeBoardServiceImpl implements FreeBoardService {
	
	@Autowired
	private FreeBoardDao freeBoardDao;
	
	//자유게시판 리스트
	@Override
	public ArrayList<FreeBoardDto> selectListFreeBoard( HashMap<String, Integer> row ) {
		return freeBoardDao.selectListFreeBoard( row );
	}
	
	//자유게시판 총 게시글 개수 ( for 페이징 )
	@Override
	public int selectTotalCountFreeBoard() {
		return freeBoardDao.selectTotalListFreeBoard();
	}


	//자유게시판 상세페이지
	@Override
	public FreeBoardDto selectDetailFreeBoard( int no ) {
		return freeBoardDao.selectDetailFreeBoard( no );
	}
	
	//자유게시판 조회수 증가
	@Override
	public int updateReadCount(int no) {
		return freeBoardDao.updateReadCount( no );
	}

	//자유게시판 글 작성
	@Override
	public int insertFreeBoard( FreeBoardDto freeBoardDto ) {
		return freeBoardDao.insertFreeBoard( freeBoardDto );
	}

	//자유게시판 답글 작성 update
	@Override
	public int updateBeforeInsertFreeBoard( FreeBoardDto freeBoardDto ) {
		return freeBoardDao.updateBeforeInsertFreeBoard( freeBoardDto );
	}
	
	//자유게시판 답글 작성 insert
	@Override
	public int insertWriteReplyFreeBoard(FreeBoardDto freeBoardDto) {
		return freeBoardDao.insertWriteReplyFreeBoard( freeBoardDto );
	}

	//자유게시판 글 수정
	@Override
	public int updateFreeBoard( FreeBoardDto freeBoardDto ) {
		return freeBoardDao.updateFreeBoard( freeBoardDto );
	}

	//자유게시판 글 삭제 (비공개)
	@Override
	public int updateNonActiveFreeBoard(int no) {
		return freeBoardDao.updateNonActiveFreeBorad( no );
	}

	//자유게시판 글 검색 카테고리 불러오기
	@Override
	public ArrayList<String> selectSearchCategoryFreeBoard() {
		// TODO Auto-generated method stub
		return null;
	}

	//자유게시판 글 검색 리스트
	@Override
	public ArrayList<FreeBoardDto> selectSearchListFreeBoard(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

	//자유게시판 댓글 리스트
	@Override
	public ArrayList<FreeBoardReplyDto> selectListFreeBoardReply( HashMap<String, Integer> row ) {
		return freeBoardDao.selectListFreeBoardReply( row );
	}

	//자유게시판 댓글 총 개수
	@Override
	public int selectTotalCountFreeBoardReply( int board_no) {
		return freeBoardDao.selectTotalCountFreeBoardReply( board_no );
	}
	
	//자유게시판 댓글 작성
	@Override
	public int insertFreeBoardReply( FreeBoardReplyDto freeBoardReplyDto ) {
		return freeBoardDao.insertFreeBoardReply( freeBoardReplyDto );
	}

	//자유게시판 댓글 수정
	@Override
	public int updateFreeBoardReply( FreeBoardReplyDto freeBoardReplyDto ) {
		return freeBoardDao.updateFreeBoardReply( freeBoardReplyDto );
	}

	//자유게시판 댓글 삭제
	@Override
	public int deleteFreeBoardReply( int no ) {
		return freeBoardDao.deleteFreeBoardReply( no );
	}

}
