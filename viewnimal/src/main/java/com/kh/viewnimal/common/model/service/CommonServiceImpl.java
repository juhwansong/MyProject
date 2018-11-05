package com.kh.viewnimal.common.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.channel.model.dto.ChannelDto;
import com.kh.viewnimal.common.model.dao.CommonDao;
import com.kh.viewnimal.freeboard.model.dto.FreeBoardDto;
import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplyDto;
import com.kh.viewnimal.volunteerepilogue.model.dto.VolunteerEpilogueDto;

@Service("commonService")
public class CommonServiceImpl implements CommonService {
	
	@Autowired
	private CommonDao commonDao;
	
	// ---------------------------------------------------------------- SELECT
	// 자동완성 목록 리스트 게시글 제목 불러오기
	@Override
	public ArrayList<String> selectChannelTitleList(){
		return (ArrayList<String>)commonDao.selectChannelTitleList();
	}
	@Override
	public ArrayList<String> selectFreeBoardTitleList(){
		return (ArrayList<String>)commonDao.selectFreeBoardTitleList();
	}
	@Override
	public ArrayList<String> selectVolunteerApplyTitleList(){
		return (ArrayList<String>)commonDao.selectVolunteerApplyTitleList();
	}
	@Override
	public ArrayList<String> selectVolunteerEpilogueTitleList(){
		return (ArrayList<String>)commonDao.selectVolunteerEpilogueTitleList();
	}

	// 통합검색
	public ArrayList<ChannelDto> selectChannel( String keyword ) {
		return (ArrayList<ChannelDto>) commonDao.selectChannel( keyword );
	}
	public ArrayList<FreeBoardDto> selectFreeBoard( String keyword ) {
		return (ArrayList<FreeBoardDto>) commonDao.selectFreeBoard( keyword );
	}
	public ArrayList<VolunteerApplyDto> selectVolunteerApply( String keyword ) {
		return (ArrayList<VolunteerApplyDto>) commonDao.selectVolunteerApply( keyword );
	}
	public ArrayList<VolunteerEpilogueDto> selectVolunteerEpilogue( String keyword ) {
		return (ArrayList<VolunteerEpilogueDto>) commonDao.selectVolunteerEpilogue( keyword );
	}

	// 관리자 카운트
	public HashMap<String, Integer> selectMemberCount() {
		return commonDao.selectMemberCount();
	}
	public HashMap<String, Integer> selectProductCount() {
		return commonDao.selectProductCount();
	}
	public HashMap<String, Integer> selectChannelCount() {
		return commonDao.selectChannelCount();
	}
	public HashMap<String, Integer> selectStreamingCount() {
		return commonDao.selectStreamingCount();
	}
	public HashMap<String, Integer> selectLabCount() {
		return commonDao.selectLabCount();
	}
	public HashMap<String, Integer> selectNoticeCount() {
		return commonDao.selectNoticeCount();
	}
	public HashMap<String, Integer> selectVolunteerApplyCount() {
		return commonDao.selectVolunteerApplyCount();
	}
	public HashMap<String, Integer> selectVolunteerEpilogueCount() {
		return commonDao.selectVolunteerEpilogueCount();
	}
	public HashMap<String, Integer> selectAdoptionApplyCount() {
		return commonDao.selectAdoptionApplyCount();
	}
	public HashMap<String, Integer> selectAdoptionReviewCount() {
		return commonDao.selectAdoptionReviewCount();
	}
	public HashMap<String, Integer> selectFreeBoardCount() {
		return commonDao.selectFreeBoardCount();
	}

	// 관리자 그래프
	public ArrayList<HashMap<String, Object>> selectVolunteerApplyGraph() {
		return (ArrayList<HashMap<String, Object>>) commonDao.selectVolunteerApplyGraph();
	}

}
