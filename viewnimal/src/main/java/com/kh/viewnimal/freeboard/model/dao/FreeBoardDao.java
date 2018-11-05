package com.kh.viewnimal.freeboard.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.freeboard.model.dto.FreeBoardDto;
import com.kh.viewnimal.freeboard.model.dto.FreeBoardReplyDto;

@Repository("freeBoardDao")
public class FreeBoardDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public FreeBoardDao(){}
	
	//자유게시판 리스트
	public ArrayList<FreeBoardDto> selectListFreeBoard( HashMap<String, Integer> row ) {
		return (ArrayList) sqlSession.selectList( "freeboardMapper.selectListFreeBoard", row );
	}
	
	//자유게시판 총 게시글 개수 ( for 페이징 )
	public int selectTotalListFreeBoard() {
		return (int) sqlSession.selectOne( "freeboardMapper.selectTotalCountFreeBoard" );
	}
	
	//자유게시판 상세페이지
	public FreeBoardDto selectDetailFreeBoard( int no ) {
		return (FreeBoardDto) sqlSession.selectOne( "freeboardMapper.selectDetailFreeBoard", no );
	}

	//자유게시판 조회수 증가
	public int updateReadCount( int no ) {
		return (int) sqlSession.update( "freeboardMapper.updateReadCount", no );
	}
	
	//자유게시판 글 작성
	public int insertFreeBoard( FreeBoardDto freeBoardDto ) {
		return (int) sqlSession.insert( "freeboardMapper.insertFreeBoard", freeBoardDto);
	}

	//자유게시판 답글 작성 update
	public int updateBeforeInsertFreeBoard( FreeBoardDto freeBoardDto ) {
		return (int) sqlSession.update( "freeboardMapper.updateBeforeInsertFreeBoard", freeBoardDto );
	}
	
	//자유게시판 답글 작성 insert
	public int insertWriteReplyFreeBoard( FreeBoardDto freeBoardDto ) {
		return (int) sqlSession.insert( "freeboardMapper.insertWriteReplyFreeBoard", freeBoardDto );
	}
	
	//자유게시판 글 수정
	public int updateFreeBoard( FreeBoardDto freeBoardDto ) {
		return (int) sqlSession.update( "freeboardMapper.updateFreeBoard", freeBoardDto );
	}

	//자유게시판 글삭제 (비공개)
	public int updateNonActiveFreeBorad( int no ) {
		return (int) sqlSession.update( "freeboardMapper.updateNonActiveFreeBoard", no );
	}

	//자유게시판 카테고리 불러오기
	public ArrayList<String> selectSearchCategoryFreeBoard() {
		// TODO Auto-generated method stub
		return null;
	}

	//자유게시판 검색 리스트
	public ArrayList<FreeBoardDto> selectSearchListFreeBoard(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

	//자유게시판 댓글 리스트
	public ArrayList<FreeBoardReplyDto> selectListFreeBoardReply(HashMap<String, Integer> map) {
		return (ArrayList) sqlSession.selectList( "freeboardMapper.selectListFreeBoardReply", map );
	}

	//자유게시판 댓글 총 개수
	public int selectTotalCountFreeBoardReply( int board_no ) {
		return (int) sqlSession.selectOne( "freeboardMapper.selectTotalCountFreeBoardReply", board_no );
	}
	
	//자유게시판 댓글 작성
	public int insertFreeBoardReply(FreeBoardReplyDto freeBoardReplyDto) {
		return (int) sqlSession.insert( "freeboardMapper.insertFreeBoardReply", freeBoardReplyDto );
	}

	//자유게시판 댓글 수정
	public int updateFreeBoardReply( FreeBoardReplyDto freeBoardReplyDto ) {
		return (int) sqlSession.update( "freeboardMapper.updateFreeBoardReply", freeBoardReplyDto );
	}

	//자유게시판 댓글 삭제
	public int deleteFreeBoardReply( int no ) {
		return (int) sqlSession.delete( "freeboardMapper.deleteFreeBoardReply", no );
	}


}
