package com.kh.viewnimal.streaming.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.streaming.model.dto.StreamingDto;
import com.kh.viewnimal.streaming.model.dto.StreamingReplyDto;

@Repository("streamingDao")
public class StreamingDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public StreamingDao() {
		// TODO Auto-generated constructor stub
	}
	
	public ArrayList<StreamingDto> selectStreamingList(HashMap<String, Integer> paging) {
		return (ArrayList)sqlSession.selectList("streamingMapper.selectStreamingList", paging);
	}
	
	public int selectCountStreaming() {
		return (int)sqlSession.selectOne("streamingMapper.selectCountStreaming");
	}

	public StreamingDto selectStreamingDetail(int no) {
		return (StreamingDto)sqlSession.selectOne("streamingMapper.selectStreaming", no);
	}

	public int insertStreaming(StreamingDto streaming) {
		return sqlSession.insert("streamingMapper.insertStreaming", streaming);
	}

	public int updateStreaming(StreamingDto streaming) {
		return sqlSession.update("streamingMapper.updateStreaming", streaming);
	}
	// 삭제(상태변경)
	public int deleteStreaming(int no) {
		return sqlSession.update("streamingMapper.deleteStreaming", no);
	}

	
	
	
	public List selectStreamingReplyList(StreamingReplyDto keywordDto) {
		return sqlSession.selectList("streamingMapper.selectStreamingReplyList", keywordDto);
	}
	
	public int selectCountStreamingReplyList(StreamingReplyDto keywordDto){
		return sqlSession.selectOne("streamingMapper.selectCountStreamingReplyList", keywordDto);
	}

	public int insertStreamingReply(StreamingReplyDto streamingReply) {
		return sqlSession.insert("streamingMapper.insertStreamingReply", streamingReply);
	}

	public int updateStreamingReply(StreamingReplyDto streamingReply) {
		return sqlSession.update("streamingMapper.updateStreamingReply", streamingReply);
	}

	public int deleteStreamingReply(StreamingReplyDto streamingReply) {
		return sqlSession.delete("streamingMapper.deleteStreamingReply", streamingReply);
	}


	public StreamingDto selectStreamingLive() {
		return (StreamingDto)sqlSession.selectOne("streamingMapper.selectStreamingLive");
	}

	public List selectLastStreamingList(StreamingDto keywordDto) {
		return sqlSession.selectList("streamingMapper.selectLastStreamingList", keywordDto);
	}


}
