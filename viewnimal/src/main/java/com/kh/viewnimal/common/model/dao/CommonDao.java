package com.kh.viewnimal.common.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.channel.model.dto.ChannelDto;
import com.kh.viewnimal.freeboard.model.dto.FreeBoardDto;
import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplyDto;
import com.kh.viewnimal.volunteerepilogue.model.dto.VolunteerEpilogueDto;


@Repository("commonDao")
public class CommonDao{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public CommonDao(){}

	// ---------------------------------------------------------------- SELECT
	// 자동완성 목록 리스트 게시글 제목 불러오기
	public List<String> selectChannelTitleList(){
		return sqlSession.selectList("commonMapper.selectChannelTitleList");
	}
	public List<String> selectFreeBoardTitleList(){
		return sqlSession.selectList("commonMapper.selectFreeBoardTitleList");
	}
	public List<String> selectVolunteerApplyTitleList(){
		return sqlSession.selectList("commonMapper.selectVolunteerApplyTitleList");
	}
	public List<String> selectVolunteerEpilogueTitleList(){
		return sqlSession.selectList("commonMapper.selectVolunteerEpilogueTitleList");
	}
	
	// 통합검색
	public List<ChannelDto> selectChannel( String keyword ) {
		return sqlSession.selectList( "commonMapper.selectChannel", keyword );
	}
	public List<FreeBoardDto> selectFreeBoard( String keyword ) {
		return sqlSession.selectList( "commonMapper.selectFreeBoard", keyword );
	}
	public List<VolunteerApplyDto> selectVolunteerApply( String keyword ) {
		return sqlSession.selectList( "commonMapper.selectVolunteerApply", keyword );
	}
	public List<VolunteerEpilogueDto> selectVolunteerEpilogue( String keyword ) {
		return sqlSession.selectList( "commonMapper.selectVolunteerEpilogue", keyword );
	}

	// 관리자 카운트
	public HashMap<String, Integer> selectMemberCount() {
		return sqlSession.selectOne( "commonMapper.selectMemberCount" );
	}
	public HashMap<String, Integer> selectProductCount() {
		return sqlSession.selectOne( "commonMapper.selectProductCount" );
	}
	public HashMap<String, Integer> selectChannelCount() {
		return sqlSession.selectOne( "commonMapper.selectChannelCount" );
	}
	public HashMap<String, Integer> selectStreamingCount() {
		return sqlSession.selectOne( "commonMapper.selectStreamingCount" );
	}
	public HashMap<String, Integer> selectLabCount() {
		return sqlSession.selectOne( "commonMapper.selectLabCount" );
	}
	public HashMap<String, Integer> selectNoticeCount() {
		return sqlSession.selectOne( "commonMapper.selectNoticeCount" );
	}
	public HashMap<String, Integer> selectVolunteerApplyCount() {
		return sqlSession.selectOne( "commonMapper.selectVolunteerApplyCount" );
	}
	public HashMap<String, Integer> selectVolunteerEpilogueCount() {
		return sqlSession.selectOne( "commonMapper.selectVolunteerEpilogueCount" );
	}
	public HashMap<String, Integer> selectAdoptionApplyCount() {
		return sqlSession.selectOne( "commonMapper.selectAdoptionApplyCount" );
	}
	public HashMap<String, Integer> selectAdoptionReviewCount() {
		return sqlSession.selectOne( "commonMapper.selectAdoptionReviewCount" );
	}
	public HashMap<String, Integer> selectFreeBoardCount() {
		return sqlSession.selectOne( "commonMapper.selectFreeBoardCount" );
	}

	// 관리자 그래프
	public List<HashMap<String, Object>> selectVolunteerApplyGraph(){
		return sqlSession.selectList("commonMapper.selectVolunteerApplyGraph");
	}

}
