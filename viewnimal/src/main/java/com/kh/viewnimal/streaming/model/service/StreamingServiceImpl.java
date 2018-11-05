package com.kh.viewnimal.streaming.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.lab.model.dto.LabDto;
import com.kh.viewnimal.streaming.model.dao.StreamingDao;
import com.kh.viewnimal.streaming.model.dto.StreamingDto;
import com.kh.viewnimal.streaming.model.dto.StreamingReplyDto;

@Service("streamingService")
public class StreamingServiceImpl implements StreamingService {

	@Autowired
	private StreamingDao streamingDao;
	
	public StreamingServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public ArrayList<StreamingDto> selectStreamingList(HashMap<String, Integer> paging) {
		return streamingDao.selectStreamingList(paging);
	}
	
	@Override
	public int selectCountStreaming() {
		return streamingDao.selectCountStreaming();
	}

	@Override
	public StreamingDto selectStreamingDetail(int no) {
		return streamingDao.selectStreamingDetail(no);
	}

	@Override
	public int insertStreaming(StreamingDto streaming) {
		return streamingDao.insertStreaming(streaming);
	}

	@Override
	public int updateStreaming(StreamingDto streaming) {
		return streamingDao.updateStreaming(streaming);
	}

	@Override
	public int deleteStreaming(int no) {
		return streamingDao.deleteStreaming(no);
	}

	@Override
	public ArrayList<StreamingReplyDto> selectStreamingReplyList(StreamingReplyDto keywordDto) {
		return (ArrayList<StreamingReplyDto>)streamingDao.selectStreamingReplyList(keywordDto);
	}

	@Override
	public int selectCountStreamingReplyList(StreamingReplyDto keywordDto){
		return streamingDao.selectCountStreamingReplyList(keywordDto);
	}
	@Override
	public int insertStreamingReply(StreamingReplyDto streamingReply) {
		return streamingDao.insertStreamingReply(streamingReply);
	}

	@Override
	public int updateStreamingReply(StreamingReplyDto streamingReply) {
		return streamingDao.updateStreamingReply(streamingReply);
	}

	@Override
	public int deleteStreamingReply(StreamingReplyDto streamingReply) {
		return streamingDao.deleteStreamingReply(streamingReply);
	}






	@Override
	public StreamingDto selectStreamingLive() {
		return streamingDao.selectStreamingLive();
	}

	@Override
	public ArrayList<StreamingDto> selectLastStreamingList(StreamingDto keywordDto) {
		return (ArrayList<StreamingDto>)streamingDao.selectLastStreamingList(keywordDto);
	}

/*	@Override
	public StreamingDto selectStreamingLive(int no) {
		return streamingDao.selectStreamingLive(no);
	}*/
}
