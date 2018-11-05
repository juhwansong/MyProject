package com.kh.viewnimal.infoboard.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.stereotype.Repository;

import com.kh.viewnimal.infoboard.model.dto.InfoBoardDto;
import com.kh.viewnimal.infoboard.model.dto.InfoBoardReplyDto;

@Repository("infoBoardDao")
public class InfoBoardDao {
	
	public InfoBoardDao() {
		// TODO Auto-generated constructor stub
	}

	
	public ArrayList<InfoBoardDto> selectInfoBoardList(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}


	public InfoBoardDto selectInfoBoardDetail(int no) {
		// TODO Auto-generated method stub
		return null;
	}


	public int insertInfoBoard(InfoBoardDto infoBoard) {
		// TODO Auto-generated method stub
		return 0;
	}


	public int UpdateInfoBoard(InfoBoardDto infoBoard) {
		// TODO Auto-generated method stub
		return 0;
	}


	public int updateInfoBoardNonActive(int no) {
		// TODO Auto-generated method stub
		return 0;
	}


	public ArrayList<InfoBoardDto> selectInfoBoardSearch(HashMap<String, String> search) {
		// TODO Auto-generated method stub
		return null;
	}


	public ArrayList<InfoBoardReplyDto> selectInfoBoardReplyList(HashMap<String, String> search) {
		// TODO Auto-generated method stub
		return null;
	}


	public int insertInfoBoardReply(InfoBoardReplyDto infoBoardReply) {
		// TODO Auto-generated method stub
		return 0;
	}


	public int updateInfoBoardReply(InfoBoardReplyDto infoBoardReply) {
		// TODO Auto-generated method stub
		return 0;
	}


	public int deleteInfoBoardReply(int no) {
		// TODO Auto-generated method stub
		return 0;
	}

}
