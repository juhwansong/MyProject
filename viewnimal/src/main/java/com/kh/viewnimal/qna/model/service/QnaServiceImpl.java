package com.kh.viewnimal.qna.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.qna.model.dao.QnaDao;
import com.kh.viewnimal.qna.model.dto.QnaDto;

@Service("qnaService")
public class QnaServiceImpl implements QnaService{

	@Autowired
	private QnaDao qnaDao;
	
	public QnaServiceImpl(){}
	
	@Override
	public ArrayList<QnaDto> selectQnaList(HashMap<String, Object> map) {
		return qnaDao.selectQnaList(map);
	}

	@Override
	public QnaDto selectQna(int no) {
		return qnaDao.selectQna(no);
	}

	@Override
	public int insertQna(QnaDto qna) {
		return qnaDao.insertQna(qna);
	}

	@Override
	public int updateQna(QnaDto qna) {
		return qnaDao.updateQna(qna);
	}

	@Override
	public int deleteQna(int no) {
		return qnaDao.deleteQna(no);
	}

	@Override
	public ArrayList<QnaDto> selectSearchKeyword(HashMap<String, Object> search) {
		return qnaDao.selectSearchKeyword(search);
	}

	@Override
	public int selectCountListAdmin() {
		return qnaDao.selectCountListAdmin();
	}

	@Override
	public int selectCountList(QnaDto qna) {
		return qnaDao.selectCountList(qna);
	}

	@Override
	public int selectSearchCount(HashMap<String, Object> search) {
		return qnaDao.selectSearchCount(search);
	}

	@Override
	public int insertQnaAnswer(QnaDto qna) {
		return qnaDao.insertQnaAnswer(qna);
	}

	@Override
	public int deleteQnaAnswer(int no) {
		return qnaDao.deleteQnaAnswer(no);
	}


}
