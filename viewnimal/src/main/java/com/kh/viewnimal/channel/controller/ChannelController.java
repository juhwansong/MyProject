package com.kh.viewnimal.channel.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.adoption.model.dto.AdoptionPetDto;
import com.kh.viewnimal.channel.model.dto.ChannelDto;
import com.kh.viewnimal.channel.model.dto.ChannelReplyDto;
import com.kh.viewnimal.channel.model.service.ChannelService;
import com.kh.viewnimal.member.model.dto.MemberDto;

@Controller
public class ChannelController {
	
	@Autowired
	private ChannelService channelService;
	
	//채널 선택 
	@RequestMapping(value="SelectChannelChoice", method=RequestMethod.GET)
	public ModelAndView selectChannelChoice(
		ModelAndView mav, AdoptionPetDto adoptionPetDto
	) {
		
		ArrayList<AdoptionPetDto> list = channelService.selectChannelChoice( adoptionPetDto );
		
		mav.addObject( "list", list );
		mav.setViewName("jsonView");		
		return mav;
	}
	
	//채널 리스트 사이트 이동
	@RequestMapping(value="ChannelList", method=RequestMethod.GET)
	public ModelAndView selectListChannel(
			HttpServletRequest request, ModelAndView mav
	){
		
		int currentPage = 1;
		String animal_id = "";
		
		if( null != request.getParameter( "currentPage" ) )
		{
			currentPage = Integer.parseInt( request.getParameter("currentPage") );
		}
		
		if( null != request.getParameter( "animal_id" ) )
		{
			animal_id = request.getParameter( "animal_id" );
		}
		
		mav.addObject( "animal_id", animal_id );
		mav.addObject( "currentPage", currentPage );
		mav.addObject( "pageSubType", "ChannelList" );
		mav.setViewName("client/channel/channelList");		
		return mav;
	}
	
	//채널 리스트
	@RequestMapping(value="ListChannel", method=RequestMethod.GET)
	public ModelAndView selectListChannel(
		HttpServletRequest request, ModelAndView mav, ChannelDto channelDto
	) throws UnsupportedEncodingException {
		
		int currentPage = 1;
		
		if( null != request.getParameter( "currentPage" ) ) {
			currentPage = Integer.parseInt(request.getParameter( "currentPage" ));
		}
		
		//페이징처리
		int totalCount	= channelService.selectTotalChannel( channelDto );
		
		int printCount	= 9;
		int printPage	= 5;
		int totalPage	= totalCount / printCount;
		
		if( totalCount % printCount > 0 )
		{
			totalPage ++;
		}
		
		int startPage	= ( (currentPage - 1) / printPage ) * printPage + 1;
		int endPage		= startPage + printPage - 1;
		
		if( endPage > totalPage )
		{
			endPage	= totalPage;
		}

		int startRow	= ( currentPage - 1 ) * printCount + 1;
		int endRow		= currentPage * printCount;
		
		channelDto.setStartRow( startRow );
		channelDto.setEndRow( endRow );
		
		//리스트 불러오기
		ArrayList<ChannelDto> list = channelService.selectListChannel( channelDto );
		
		JSONObject json	= new JSONObject();
		JSONArray jarr	= new JSONArray();

		for(ChannelDto e : list)
		{
			JSONObject job = new JSONObject();
			job.put( "id", e.getId() );
			job.put( "no", e.getNo() );
			job.put( "title", URLEncoder.encode(e.getTitle(), "UTF-8") );
			job.put( "write_date", String.valueOf(e.getWrite_date()) );
			job.put( "read_count", e.getRead_count() );
			job.put( "animal_id", e.getAnimal_id() );
			job.put( "thumbnail", e.getThumbnail() );
			
			jarr.add(job);
		}
	
		mav.addObject( "currentPage", currentPage );
		mav.addObject( "printPage", printPage );
		mav.addObject( "totalPage", totalPage );
		mav.addObject( "startPage", startPage );
		mav.addObject( "endPage", endPage );
		mav.addObject( "list", jarr );
		mav.addObject( "pageSubType", "ChannelList" );
		mav.setViewName("jsonView");		
		return mav;
	} 
	
	//채널상세페이지
	@RequestMapping( value="ChannelDetail", method=RequestMethod.GET )
	public ModelAndView selectDetailChannel(
		@RequestParam(value="no") int no, HttpServletRequest request, ModelAndView mav
	){

		int currentPage = Integer.parseInt( request.getParameter("currentPage") );
		String animal_id = "";
		
		if( null != request.getParameter( "animal_id" ) )
		{
			animal_id = request.getParameter( "animal_id" );
		}
		
		//조회수 증가 
		channelService.updateReadCount( no ); 

		ChannelDto result = channelService.selectDetailChannel( no );

		mav.addObject( "animal_id", animal_id );
		mav.addObject( "currentPage", currentPage );
		mav.addObject( "channelDto", result );
		mav.addObject( "pageSubType", "ChannelList" );
		mav.setViewName("client/channel/channelDetail");
		
		return mav;
	}
	
	//채널 글쓰기 페이지로 이동
	@RequestMapping( value="WriteChannel", method=RequestMethod.POST )
	public ModelAndView moveWriteChannel(
		ChannelDto channelDto, HttpServletRequest request, ModelAndView mav
	){
		String type = request.getParameter("type");	
		
		if ( !type.equals("first") )
		{
			mav.addObject( "channelDto", channelDto );
		} 
		
		mav.addObject( "type", type);
		mav.addObject( "pageSubType", "ChannelList" );
		mav.setViewName("client/channel/channelWrite");		
		return mav;
	}
	
	//채널 글쓰기 카테고리
	@RequestMapping( value="ChannelCategory", method=RequestMethod.GET )
	public ModelAndView selectCategoryChannel(
		ModelAndView mav
	){
		
		ArrayList<AdoptionPetDto> list = channelService.selectCategoryChannel();
		
		mav.addObject( "list", list);
		mav.setViewName( "jsonView" );		
		return mav;
	}
	
	//채널 글 작성
	@RequestMapping( value="ChannelWrite", method=RequestMethod.GET )
	public ModelAndView insertChannel(
		HttpServletRequest request, ChannelDto channelDto, ModelAndView mav
	){
		//세션에서 현재 아이디 값 가져오기
		MemberDto memberDto = (MemberDto)request.getSession().getAttribute("loginMemberDto");
		channelDto.setId(memberDto.getId()); 
		
		//유튜브 섬네일 저장
		String youtubeId = request.getParameter( "youtubeId" );
		
		//중간품질
		String thumbnail = "https://img.youtube.com/vi/" + youtubeId + "/mqdefault.jpg";
		
		//고품질 아래는 HQ 동영상에서만. 다른 버전도 있으나 검은색 바탕의 사진이 출력됨.
		//String thumbnail = "https://img.youtube.com/vi/" + youtubeId + "/maxresdefault.jpg";
		
		channelDto.setThumbnail( thumbnail );

		int result = channelService.insertChannel( channelDto );
		

		mav.addObject( "result", result );
		mav.addObject( "pageSubType", "ChannelList" );
		mav.setViewName( "jsonView" );
		
		return mav;
	}
	
	//채널 글 수정
	@RequestMapping( value="ChannelUpdate", method=RequestMethod.GET )
	public ModelAndView updateChannel(
		HttpServletRequest request, ChannelDto channelDto, ModelAndView mav
	){
		//세션에서 현재 아이디 값 가져오기
		MemberDto memberDto = (MemberDto)request.getSession().getAttribute("loginMemberDto");
		channelDto.setId(memberDto.getId()); 
		
		//유튜브 섬네일 저장
		String youtubeId = request.getParameter( "youtubeId" );
		
		//중간품질
		String thumbnail = "https://img.youtube.com/vi/" + youtubeId + "/mqdefault.jpg";
		
		//고품질 아래는 HQ 동영상에서만. 다른 버전도 있으나 검은색 바탕의 사진이 출력됨.
		//String thumbnail = "https://img.youtube.com/vi/" + youtubeId + "/maxresdefault.jpg";
		
		channelDto.setThumbnail( thumbnail );

		int result = channelService.updateChannel( channelDto );
		

		mav.addObject( "result", result );
		mav.addObject( "pageSubType", "ChannelList" );
		mav.setViewName( "jsonView" );
		
		return mav;
	}
	
	//채널 글 삭제 (비공개)
	@RequestMapping( value="UpdateNonActiveChannel", method=RequestMethod.GET )
	public ModelAndView updateNonActiveChannel(
		@RequestParam(value="no") int no, ModelAndView mav
	){

		int result = channelService.updateNonActiveChannel( no );
		System.out.println( "result : " + result );
		
		mav.addObject( "result", result );
		mav.addObject( "pageSubType", "FreeBoardList" );
		mav.setViewName( "jsonView" );
		return mav;
	}
	
	
	@RequestMapping( value="ChannelReplyList", method=RequestMethod.GET )
	//채널 댓글 리스트
	public ModelAndView selectChannelReplyList(
		Integer currentPage, HttpServletRequest request, ModelAndView mav
	) throws UnsupportedEncodingException{
		
		int channel_no = Integer.parseInt( request.getParameter("channel_no") );
		HashMap<String, Integer> row = new HashMap<>();

		//페이징처리
		int totalCount	= channelService.selectTotalCountChannelReply( channel_no );
		
		int printCount	= 10;
		int printPage	= 5;
		int totalPage	= totalCount / printCount;
		
		if( null == currentPage )
		{
			currentPage = 1;
		}
		
		if( totalCount % printCount > 0 )
		{
			totalPage ++;
		}
		
		int startPage	= ( (currentPage - 1) / printPage ) * printPage + 1;
		int endPage		= startPage + printPage - 1;
		
		if( endPage > totalPage )
		{
			endPage	= totalPage;
		}
		
		int startRow	= ( currentPage - 1 ) * printCount + 1;
		int endRow		= currentPage * printCount;
		
		row.put( "startRow", startRow );
		row.put( "endRow", endRow );
		row.put( "channel_no", channel_no );


		//댓글 리스트
		ArrayList<ChannelReplyDto> list = channelService.selectChannelReplyList( row );
		
		JSONObject json	= new JSONObject();
		JSONArray jarr	= new JSONArray();

		for(ChannelReplyDto e : list)
		{
			JSONObject job = new JSONObject();
			job.put( "id", e.getId() );
			job.put( "no", e.getNo() );
			job.put( "channel_no", e.getChannel_no() );
			job.put( "write_date", String.valueOf(e.getWrite_date()) );
			job.put( "reply_content", URLEncoder.encode(e.getReply_content(), "UTF-8") );
			job.put( "nickname", URLEncoder.encode(e.getNickname(), "UTF-8") );

			jarr.add(job);
		}
		
		mav.addObject( "currentPage", currentPage );
		mav.addObject( "printPage", printPage );
		mav.addObject( "totalPage", totalPage );
		mav.addObject( "startPage", startPage );
		mav.addObject( "endPage", endPage );
		mav.addObject( "totalCount", totalCount );
		mav.addObject( "list", jarr );
		mav.setViewName( "jsonView" );
		return mav;
	}
	
	@RequestMapping( value="InsertChannelReply", method=RequestMethod.POST )	
	//채널 댓글 쓰기
	public ModelAndView insertChannelReply(
		ChannelReplyDto channelReplyDto, ModelAndView mav
	){
		
		int result = channelService.insertChannelReply( channelReplyDto );
		
		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );
		return mav;
	}
	
	//채널 댓글 수정
	@RequestMapping( value="UpdateChannelReply", method=RequestMethod.GET )
	public ModelAndView updateChannelReply( 
		ChannelReplyDto channelReplyDto, HttpServletRequest request, ModelAndView mav
	){
		int result = channelService.updateChannelReply( channelReplyDto );
		
		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );
		return mav;
	}
	
	//채널 댓글 삭제
	@RequestMapping( value="DeleteChannelReply", method=RequestMethod.GET )
	public ModelAndView deleteChannelReply(
		HttpServletRequest request, ModelAndView mav
	){
		int no = Integer.parseInt( request.getParameter("no") );
		int result = channelService.deleteChannelReply( no );
		
		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );
		return mav;
	}
	

}
