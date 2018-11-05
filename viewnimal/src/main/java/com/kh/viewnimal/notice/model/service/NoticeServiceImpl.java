package com.kh.viewnimal.notice.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.notice.model.dao.NoticeDao;
import com.kh.viewnimal.notice.model.dto.NoticeDto;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	private NoticeDao noticeDao;
	
	@Override
	public ArrayList<NoticeDto> selectNoticeList(HashMap<String, Object> paging) {
		return noticeDao.selectNoticeList(paging);
	}

	@Override
	public NoticeDto selectNotice(int no) {
		return noticeDao.selectNotice(no);
	}

	@Override
	public int insertNotice(NoticeDto notice) {
		return noticeDao.insertNotice(notice);
	}

	@Override
	public int updateNotice(NoticeDto notice) {
		return noticeDao.updateNotice(notice);
	}

	@Override
	public int deleteNotice(int no) {
		return noticeDao.deleteNotice(no);
	}

	@Override
	public ArrayList<NoticeDto> selectSearchNotice(HashMap<String, Object> search) {
		return noticeDao.selectSearchNotice(search);
	}

	@Override
	public int updateAddReadCount(int no) {
		return noticeDao.updateAddReadCount(no);
	}

	@Override
	public int selectCountList() {
		return noticeDao.selectCountList();
	}

	@Override
	public int selectCountSearch(HashMap<String, Object> search) {
		return noticeDao.selectCountSearch(search);
	}
}
