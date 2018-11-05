package com.kh.viewnimal.qna.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.viewnimal.qna.model.dto.QnaDto;

public interface QnaService {
	
	//qna 목록(회원)
	ArrayList<QnaDto> selectQnaList(HashMap<String, Object> map);

	//qna 조회
	QnaDto selectQna(int no);
	
	//qna 작성
	int insertQna(QnaDto qna);
	
	//qna 수정
	int updateQna(QnaDto qna);
	
	//qna 삭제
	int deleteQna(int no);
	
	//qna 키워드 검색
	ArrayList<QnaDto> selectSearchKeyword(HashMap<String, Object> search);
	
	//qna 게시글 총 개수(관리자)
	int selectCountListAdmin();
	
	//qna 게시글 총 개수(회원)
	int selectCountList(QnaDto qna);
	
	//qna 검색결과 개수
	int selectSearchCount(HashMap<String, Object> search);
	
	
	
	//관리자
	//qna 답글 작성/수정
	int insertQnaAnswer(QnaDto qna);
	
	//qna 답글 삭제
	int deleteQnaAnswer(int no);


	
}
