package com.kh.viewnimal.channel.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.adoption.model.dto.AdoptionPetDto;
import com.kh.viewnimal.channel.model.dto.ChannelDto;
import com.kh.viewnimal.channel.model.dto.ChannelReplyDto;

@Repository("channelDao")
public class ChannelDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ChannelDao(){}
	
	//채널 리스트
	public ArrayList<ChannelDto> selectListChannel( ChannelDto channelDto ) {
		return (ArrayList) sqlSession.selectList( "channelMapper.selectListChannel", channelDto );
	}
	
	//채널 선택
	public ArrayList<AdoptionPetDto> selectChannelChoice( AdoptionPetDto adoptionPetDto ) {
		return (ArrayList) sqlSession.selectList( "channelMapper.selectChannelChoice", adoptionPetDto );
	}

	//채널 총 개시글 개수
	public int selectTotalChannel( ChannelDto channelDto ) {
		return (int) sqlSession.selectOne( "channelMapper.selectTotalChannel", channelDto);
	}

	//체널 상세페이지
	public ChannelDto selectDetailChannel(int no) {
		return (ChannelDto) sqlSession.selectOne( "channelMapper.selectDetailChannel", no );
	}
	
	//채널 조회수 증가
	public int updateReadCount( int no ) {
		return (int) sqlSession.update( "channelMapper.updateReadCount", no);
	}
	

	//채널 글작성 카테고리
	public ArrayList<AdoptionPetDto> selectCategoryChannel() {
		return (ArrayList) sqlSession.selectList( "channelMapper.selectCategoryChannel" );
	}
	
	//채널 글 작성
	public int insertChannel( ChannelDto channelDto ) {
		return (int) sqlSession.insert( "channelMapper.insertChannel", channelDto );
	}

	//채널 글 수정
	public int updateChannel(ChannelDto channelDto) {
		return (int) sqlSession.update( "channelMapper.updateChannel", channelDto );
	}
	
	//채널 글 삭제 (비공개)
	public int updateNonActiveChannel(int no) {
		return (int) sqlSession.update( "channelMapper.updateNonActiveChannel", no );
	}

	//채널 글 검색 카테고리 불러오기
	public ArrayList<String> selectSearchCategoryChannel() {
		// TODO Auto-generated method stub
		return null;
	}

	//채널 글 검색 리스트
	public ArrayList<ChannelDto> selectSearchListChannel(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

	//채널 댓글 리스트
	public ArrayList<ChannelReplyDto> selectChannelReplyList( HashMap<String, Integer> row ) {
		return (ArrayList) sqlSession.selectList( "channelMapper.selectChannelReplyList", row );
	}

	//채널 댓글 작성
	public int insertChannelReply( ChannelReplyDto channelReplyDto ) {
		return (int) sqlSession.insert( "channelMapper.insertChannelReply", channelReplyDto );
	}

	//채널 댓글 수정
	public int updateChannelReply( ChannelReplyDto channelReplyDto ) {
		return (int) sqlSession.update( "channelMapper.updateChannelReply", channelReplyDto );
	}

	//채널 댓글 삭제
	public int deleteChannelReply( int no ) {
		return (int) sqlSession.delete( "channelMapper.deleteChannelReply", no );
	}

	//채널 댓글 총개수
	public int selectTotalCountChannelReply(int channel_no) {
		return (int) sqlSession.selectOne( "channelMapper.selectTotalCountChannelReply", channel_no);
	}




	

}
