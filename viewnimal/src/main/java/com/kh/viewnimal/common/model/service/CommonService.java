package com.kh.viewnimal.common.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.viewnimal.channel.model.dto.ChannelDto;
import com.kh.viewnimal.freeboard.model.dto.FreeBoardDto;
import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplyDto;
import com.kh.viewnimal.volunteerepilogue.model.dto.VolunteerEpilogueDto;

public interface CommonService {
	// ---------------------------------------------------------------- SELECT
	// 자동완성 목록 리스트 게시글 제목 불러오기
	public abstract ArrayList<String> selectChannelTitleList();
	public abstract ArrayList<String> selectFreeBoardTitleList();
	public abstract ArrayList<String> selectVolunteerApplyTitleList();
	public abstract ArrayList<String> selectVolunteerEpilogueTitleList();

	// 통합검색
	public abstract ArrayList<ChannelDto> 			selectChannel			( String keyword );
	public abstract ArrayList<FreeBoardDto> 		selectFreeBoard			( String keyword );
	public abstract ArrayList<VolunteerApplyDto> 	selectVolunteerApply	( String keyword );
	public abstract ArrayList<VolunteerEpilogueDto> selectVolunteerEpilogue	( String keyword );

	// 관리자 카운트
	public abstract HashMap<String, Integer> selectMemberCount();
	public abstract HashMap<String, Integer> selectProductCount();
	public abstract HashMap<String, Integer> selectChannelCount();
	public abstract HashMap<String, Integer> selectStreamingCount();
	public abstract HashMap<String, Integer> selectLabCount();
	public abstract HashMap<String, Integer> selectNoticeCount();
	public abstract HashMap<String, Integer> selectVolunteerApplyCount();
	public abstract HashMap<String, Integer> selectVolunteerEpilogueCount();
	public abstract HashMap<String, Integer> selectAdoptionApplyCount();
	public abstract HashMap<String, Integer> selectAdoptionReviewCount();
	public abstract HashMap<String, Integer> selectFreeBoardCount();

	// 관리자 그래프
	public abstract ArrayList<HashMap<String, Object>> selectVolunteerApplyGraph();
}
