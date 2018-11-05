package com.kh.viewnimal.streaming.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.viewnimal.streaming.model.dto.StreamingDto;
import com.kh.viewnimal.streaming.model.dto.StreamingReplyDto;

public interface StreamingService {

	// 스트리밍 리스트 
	ArrayList<StreamingDto> selectStreamingList(HashMap<String, Integer> paging);
	
	// 스트리밍 게시글 총 갯수
	int selectCountStreaming();
	
	// 스트리밍 상세페이지
	StreamingDto selectStreamingDetail(int no);
	
	// 스트리밍 글 작성
	int insertStreaming(StreamingDto streaming);
	
	// 스트리밍 글 수정
	int updateStreaming(StreamingDto streaming);
	
	// 글 상태 바꾸기(비활성화)
	int deleteStreaming(int no);
	
	
	
	// 스트리밍 댓글 리스트
	ArrayList<StreamingReplyDto>selectStreamingReplyList(StreamingReplyDto keywordDto);
	
	// 스트리밍 댓글 갯수
	int selectCountStreamingReplyList(StreamingReplyDto keywordDto);
	
	// 스트리밍 댓글 작성
	int insertStreamingReply(StreamingReplyDto streamingReply);
	
	// 스트리밍 댓글 수정
	int updateStreamingReply(StreamingReplyDto streamingReply);
	
	// 스트리밍 댓글 삭제
	int deleteStreamingReply(StreamingReplyDto streamingReply);
	

	

	

	// 상단에 노출되는 실시간 라이브
	StreamingDto selectStreamingLive();

	
	// 지난스트리밍,, 리스트페이징처리
	ArrayList<StreamingDto> selectLastStreamingList(StreamingDto keywordDto);


	
	
	
	
	
	
	
	
	
	
}
