package com.kh.viewnimal.qna.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.qna.model.dto.QnaDto;

@Repository("qnaDao")
public class QnaDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	public QnaDao(){}
	
	//qna 목록
	public ArrayList<QnaDto> selectQnaList(HashMap<String, Object> map) {
		return (ArrayList)sqlSession.selectList("qnaMapper.selectQnaList", map);
	}

	//qna 상세보기
	public QnaDto selectQna(int no) {
		return (QnaDto)sqlSession.selectOne("qnaMapper.selectQna", no);
	}

	//qna 쓰기
	public int insertQna(QnaDto qna) {
		return sqlSession.insert("qnaMapper.insertQna", qna);
	}

	//qna 수정
	public int updateQna(QnaDto qna) {
		return sqlSession.update("qnaMapper.updateQna", qna);
	}

	//qna 삭제(상태 변경)
	public int deleteQna(int no) {
		return sqlSession.update("qnaMapper.deleteQna", no);
	}

	//qna 키워드 검색
	public ArrayList<QnaDto> selectSearchKeyword(HashMap<String, Object> search) {
		return (ArrayList)sqlSession.selectList("qnaMapper.selectSearchKeyword", search);
	}

	//qna 게시글 총 개수(관리자)
	public int selectCountListAdmin() {
		return (int)sqlSession.selectOne("qnaMapper.selectCountListAdmin");
	}

	//qna 게시글 총 개수(회원)
	public int selectCountList(QnaDto qna) {
		return (int)sqlSession.selectOne("qnaMapper.selectCountList", qna);
	}

	//qna 검색결과 개수
	public int selectSearchCount(HashMap<String, Object> search) {
		return (int)sqlSession.selectOne("qnaMapper.selectSearchCount", search);
	}

	
	///////////////
	//qna 답글 작성/수정(update)
	public int insertQnaAnswer(QnaDto qna) {
		return sqlSession.update("qnaMapper.insertQnaAnswer", qna);
	}

	//qna 답글 삭제(update)
	public int deleteQnaAnswer(int no) {
		return sqlSession.update("qnaMapper.deleteQnaAnswer", no);
	}


}
