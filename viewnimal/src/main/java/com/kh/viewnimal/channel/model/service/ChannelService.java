package com.kh.viewnimal.channel.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.viewnimal.adoption.model.dto.AdoptionPetDto;
import com.kh.viewnimal.channel.model.dto.ChannelDto;
import com.kh.viewnimal.channel.model.dto.ChannelReplyDto;

public interface ChannelService {
	
	//채널 리스트
	public abstract ArrayList<ChannelDto> selectListChannel( ChannelDto channelDto );
	
	//채널 선택
	public abstract ArrayList<AdoptionPetDto> selectChannelChoice( AdoptionPetDto adoptionPetDto );

	//채널 총 게시글 개수
	public abstract int selectTotalChannel( ChannelDto channelDto );

	//채널 상세페이지
	public abstract ChannelDto selectDetailChannel( int no );
		
	//채널 조회수 증가	
	public abstract int updateReadCount( int no );
	
	//채널 글작성 카테고리
	public abstract ArrayList<AdoptionPetDto> selectCategoryChannel();
	
	//채널 글작성
	public abstract int insertChannel( ChannelDto channelDto );
	
	//채널 글 수정
	public abstract int updateChannel( ChannelDto channelDto );
	
	//채널 글 삭제(비공개)
	public abstract int updateNonActiveChannel( int no );
	
	//채널 글 검색 카테고리 불러오기
	public abstract ArrayList<String> selectSearchCategoryChannel();
	
	//채널 글 검색 리스트
	public abstract ArrayList<ChannelDto> selectSearchListChannel(HashMap<String, String> map);
	
	//채널 댓글 리스트
	public abstract ArrayList<ChannelReplyDto> selectChannelReplyList( HashMap<String, Integer> row );
	
	//채널 댓글 작성
	public abstract int insertChannelReply( ChannelReplyDto channelReplyDto );
	
	//채널 댓글 수정
	public abstract int updateChannelReply( ChannelReplyDto channelReplyDto );
	
	//채널 댓글 삭제
	public abstract int deleteChannelReply( int no );

	//채널 댓글 총개수
	public abstract int selectTotalCountChannelReply( int channel_no );





		

}
