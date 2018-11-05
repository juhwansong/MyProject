package com.kh.viewnimal.channel.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.adoption.model.dto.AdoptionPetDto;
import com.kh.viewnimal.channel.model.dao.ChannelDao;
import com.kh.viewnimal.channel.model.dto.ChannelDto;
import com.kh.viewnimal.channel.model.dto.ChannelReplyDto;

@Service("channelService")
public class ChannelServiceImpl implements ChannelService {
	
	@Autowired
	private ChannelDao channelDao;

	//채널 리스트
	@Override
	public ArrayList<ChannelDto> selectListChannel( ChannelDto channelDto ) {
		return channelDao.selectListChannel( channelDto );
	}
	
	//채널 선택
	@Override
	public ArrayList<AdoptionPetDto> selectChannelChoice( AdoptionPetDto adoptionPetDto ) {
		return channelDao.selectChannelChoice( adoptionPetDto );
	}

	//총 채널 게시글 개수
	@Override
	public int selectTotalChannel( ChannelDto channelDto ) {
		return channelDao.selectTotalChannel( channelDto );
	}

	//채널 상세페이지
	@Override
	public ChannelDto selectDetailChannel( int no ) {
		return channelDao.selectDetailChannel( no );
	}
	
	//채널 조회수
	@Override
	public  int updateReadCount( int no ){
		return channelDao.updateReadCount( no );
	}
	
	//채널 글작성 카테고리
	@Override
	public ArrayList<AdoptionPetDto> selectCategoryChannel() {
		return channelDao.selectCategoryChannel();
	}

	//채널 글 작성
	@Override
	public int insertChannel( ChannelDto channelDto ) {
		return channelDao.insertChannel( channelDto );
	}

	//채널 글 수정
	@Override
	public int updateChannel( ChannelDto channelDto ) {
		return channelDao.updateChannel( channelDto );
	}
	
	//채널 글 삭제(비공개)
	@Override
	public int updateNonActiveChannel( int no ) {
		return channelDao.updateNonActiveChannel( no );
	}

	//채널 글 검색 카테고리 불러오기
	@Override
	public ArrayList<String> selectSearchCategoryChannel() {
		// TODO Auto-generated method stub
		return null;
	}

	//채널 글 검색 리스트
	@Override
	public ArrayList<ChannelDto> selectSearchListChannel(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return null;
	}

	//채널 댓글 리스트
	@Override
	public ArrayList<ChannelReplyDto> selectChannelReplyList( HashMap<String, Integer> row ) {
		return channelDao.selectChannelReplyList( row );
	}

	//채널 댓글 작성
	@Override
	public int insertChannelReply(ChannelReplyDto channelReplyDto) {
		return channelDao.insertChannelReply( channelReplyDto );
	}

	//채널 댓글 수정
	@Override
	public int updateChannelReply( ChannelReplyDto channelReplyDto ) {
		return channelDao.updateChannelReply( channelReplyDto );
	}

	//채널 댓글 삭제
	@Override
	public int deleteChannelReply( int no ) {
		return channelDao.deleteChannelReply( no );
	}

	//채널 댓글 총개수
	@Override
	public int selectTotalCountChannelReply( int channel_no ) {
		return channelDao.selectTotalCountChannelReply( channel_no );
	}


	
}
