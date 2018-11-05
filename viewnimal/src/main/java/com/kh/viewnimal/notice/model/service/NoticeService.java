package com.kh.viewnimal.notice.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.viewnimal.notice.model.dto.NoticeDto;

public interface NoticeService {
	
	//공지사항 목록
	ArrayList<NoticeDto> selectNoticeList(HashMap<String, Object> paging);
	
	//공지사항 읽기
	NoticeDto selectNotice(int no);
	
	//공지사항 작성
	int insertNotice(NoticeDto notice);
	
	//공지사항 수정
	int updateNotice(NoticeDto notice);
	
	//공지사항 삭제
	int deleteNotice(int no);
	
	//공지사항 검색
	ArrayList<NoticeDto> selectSearchNotice(HashMap<String, Object> search);
	
	//공지사항 조회수 증가
	int updateAddReadCount(int no);
	
	//공지사항 전체 게시글 개수
	int selectCountList();
	
	//공지사항 검색 게시글 개수
	int selectCountSearch(HashMap<String, Object> search);
}
