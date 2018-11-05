package com.kh.viewnimal.notice.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.notice.model.dto.NoticeDto;

@Repository("noticeDao")
public class NoticeDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public NoticeDao(){}
	
	//공지사항 목록	
	public ArrayList<NoticeDto> selectNoticeList(HashMap<String, Object> paging){
		return (ArrayList)sqlSession.selectList("noticeMapper.selectNoticeList", paging);
	}
	
	//공지사항 읽기
	public NoticeDto selectNotice(int no){
		return (NoticeDto)sqlSession.selectOne("noticeMapper.selectNotice", no);
	}
	
	//공지사항 작성
	public int insertNotice(NoticeDto notice){
		return sqlSession.insert("noticeMapper.insertNotice", notice);
	}
	
	//공지사항 수정
	public int updateNotice(NoticeDto notice){
		return sqlSession.update("noticeMapper.updateNotice", notice);
	}
	
	//공지사항 삭제(active 변경)
	public int deleteNotice(int no){;
		return sqlSession.update("noticeMapper.deleteNotice", no);
	}
	
	//공지사항 검색
	public ArrayList<NoticeDto> selectSearchNotice(HashMap<String, Object> search){
		return (ArrayList)sqlSession.selectList("noticeMapper.selectSearchNotice", search);
	}
	
	//공지사항 조회수 증가
	public int updateAddReadCount(int no){
		return sqlSession.update("noticeMapper.updateAddReadCount", no);
	}
	
	//공지사항 전체 게시글 개수
	public int selectCountList(){
		return (int)sqlSession.selectOne("noticeMapper.selectCountList");
	}
	
	//공지사항 검색 게시글 개수
	public int selectCountSearch(HashMap<String, Object> search){
		return (int)sqlSession.selectOne("noticeMapper.selectCountSearch", search);
	}


}
