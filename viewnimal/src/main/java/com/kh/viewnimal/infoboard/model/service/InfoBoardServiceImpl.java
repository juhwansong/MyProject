package com.kh.viewnimal.infoboard.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.infoboard.model.dao.InfoBoardDao;
import com.kh.viewnimal.infoboard.model.dto.InfoBoardDto;
import com.kh.viewnimal.infoboard.model.dto.InfoBoardReplyDto;

@Service("infoBoardService")
public class InfoBoardServiceImpl implements InfoBoardService{

	@Autowired
	private InfoBoardDao infoBoardDao;
	
	
	public InfoBoardServiceImpl() {
		// TODO Auto-generated constructor stub
	}


	@Override
	public ArrayList<InfoBoardDto> selectInfoBoardList(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return infoBoardDao.selectInfoBoardList(map);
	}


	@Override
	public InfoBoardDto selectInfoBoardDetail(int no) {
		// TODO Auto-generated method stub
		return infoBoardDao.selectInfoBoardDetail(no);
	}


	@Override
	public int insertInfoBoard(InfoBoardDto infoBoard) {
		// TODO Auto-generated method stub
		return infoBoardDao.insertInfoBoard(infoBoard);
	}


	@Override
	public int UpdateInfoBoard(InfoBoardDto infoBoard) {
		// TODO Auto-generated method stub
		return infoBoardDao.UpdateInfoBoard(infoBoard);
	}


	@Override
	public int updateInfoBoardNonActive(int no) {
		// TODO Auto-generated method stub
		return infoBoardDao.updateInfoBoardNonActive(no);
	}


	@Override
	public ArrayList<InfoBoardDto> selectInfoBoardSearch(HashMap<String, String> search) {
		// TODO Auto-generated method stub
		return infoBoardDao.selectInfoBoardSearch(search);
	}


	@Override
	public ArrayList<InfoBoardReplyDto> selectInfoBoardReplyList(HashMap<String, String> search) {
		// TODO Auto-generated method stub
		return infoBoardDao.selectInfoBoardReplyList(search);
	}


	@Override
	public int insertInfoBoardReply(InfoBoardReplyDto infoBoardReply) {
		// TODO Auto-generated method stub
		return infoBoardDao.insertInfoBoardReply(infoBoardReply);
	}


	@Override
	public int updateInfoBoardReply(InfoBoardReplyDto infoBoardReply) {
		// TODO Auto-generated method stub
		return infoBoardDao.updateInfoBoardReply(infoBoardReply);
	}


	@Override
	public int deleteInfoBoardReply(int no) {
		// TODO Auto-generated method stub
		return infoBoardDao.deleteInfoBoardReply(no);
	}
	

	
	
}
