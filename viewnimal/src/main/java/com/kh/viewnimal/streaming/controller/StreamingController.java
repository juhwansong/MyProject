package com.kh.viewnimal.streaming.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.member.model.dto.MemberDto;
import com.kh.viewnimal.streaming.model.dto.StreamingDto;
import com.kh.viewnimal.streaming.model.dto.StreamingReplyDto;
import com.kh.viewnimal.streaming.model.service.StreamingService;

@Controller
public class StreamingController {

	@Autowired
	private StreamingService streamingService;
	
	
	// 실시간 리스트
/*	@RequestMapping("streamingLive")
	public ModelAndView selectStreamingLive(ModelAndView mv){
		
		mv.addObject("pageSubType", "Streaming");
		mv.addObject("Streaming", streamingService.selectStreamingLive());
		
		return mv;
	}*/

	// 스트리밍 라이브 리스트
	@RequestMapping("Streaming")
	public ModelAndView selectStreamingList( ModelAndView mv, HttpServletRequest request){
		
		mv.addObject("Live", streamingService.selectStreamingLive());
		mv.addObject("pageSubType", "Streaming");
		
		mv.setViewName("client/streaming/streamingList");
		
		
		return mv;
	}
	
	// 지난 스트리밍 목록
	@RequestMapping(value="selectLastStreamingList")
	public ModelAndView selectLastStreamingList(ModelAndView mv, StreamingDto keywordDto, HttpServletRequest request){
		
		mv.setViewName("jsonView");
		
		int countList = 6;
		keywordDto.setCount_list(6);
		int countPage = 3;
		
		
		int totalCount = streamingService.selectCountStreaming();
		
		int maxPage = totalCount / countList;
		int currentPage = keywordDto.getCurrent_page();
		
		if(totalCount % countList > 0){
			maxPage++;
		}
		
		if(maxPage < currentPage){
			currentPage = maxPage;                         
		}
		
	    int start_row = (currentPage - 1 ) * countList + 1;
		int end_row = start_row + countList - 1;
		
		keywordDto.setStart_row(start_row);
		keywordDto.setEnd_row(end_row);
		
		ArrayList<StreamingDto> list = streamingService.selectLastStreamingList(keywordDto);
		
		mv.addObject("list", list);
		
		int startPage = ((currentPage -1) / countPage ) * countPage + 1;
		int endPage = startPage + countPage - 1;
		
		if(endPage > maxPage){
			endPage = maxPage;
		}
		
		HashMap<String, Integer> pageMap = new HashMap<>();
		pageMap.put("max_page", maxPage);
		pageMap.put("start_page", startPage);
		pageMap.put("end_page", endPage);
		pageMap.put("current_page", currentPage);
		pageMap.put("totalCount", totalCount);
		
		
		mv.addObject("infoMap", pageMap);
		
		mv.addObject("pageSubType", "Streaming");
		
		return mv;
	}
	
	
	// 스트리밍 상세페이지
	@RequestMapping("StreamingDetail")
	public ModelAndView selectStreamingDetail(@RequestParam(value="no") int no,ModelAndView mv){
		
		mv.addObject("pageSubType", "Streaming");
		
		streamingService.selectStreamingDetail(no);
		mv.addObject("Streaming", streamingService.selectStreamingDetail(no));
		mv.setViewName("client/streaming/streamingDetail");
		
		return mv;
	}
	
	// 스트리밍 글 작성페이지로 이동
	@RequestMapping("StreamingWrite")
	public ModelAndView moveWriteStreaming(ModelAndView mv){
		
		mv.addObject("pageSubType", "Streaming");
		mv.setViewName("client/streaming/streamingWrite");
		
		return mv;
	}
	// 스트리밍 글 작성
	@RequestMapping(value="insertStreaming", method=RequestMethod.POST)
	public ModelAndView insertStreaming(ModelAndView mv, StreamingDto streaming, HttpServletRequest request){
		
		MemberDto memberDto = (MemberDto)request.getSession().getAttribute("loginMemberDto");
		streaming.setId(memberDto.getId());
		
		streamingService.insertStreaming(streaming);
		mv.setViewName("client/streaming/streamingList");
		return mv;
	}
	
	// 스트리밍 글 수정 페이지로 이동
	@RequestMapping("StreamingUpdate")
	public ModelAndView moveUpdateStreaming(ModelAndView mv, @RequestParam(value="no") int no){
		mv.addObject("pageSubType", "Streaming");
		mv.addObject("Streaming", streamingService.selectStreamingDetail(no));
		mv.setViewName("client/streaming/streamingUpdate");
		
		return mv;
	}
	
	
	// 스트리밍 글 수정
	@RequestMapping(value="updateStreaming", method=RequestMethod.POST)
	public ModelAndView updateStreaming(ModelAndView mv, StreamingDto streaming, HttpServletRequest request){
		
		MemberDto memberDto = (MemberDto)request.getSession().getAttribute("loginMemberDto");
		streaming.setId(memberDto.getId());
		String resultMessage = "fail";
		
		/*streamingService.updateStreaming(streaming);*/
		if(streamingService.updateStreaming(streaming) > 0){
			resultMessage = "success";
		}
		mv.addObject("resultMessage", resultMessage);
		mv.setViewName("jsonView");
		/*mv.setViewName("client/streaming/streamingList");*/
		
		
		return mv;
	}
	// 글 상태 바꾸기(비활성화)
	@RequestMapping("streamingDelete")
	public ModelAndView deleteStreaming(@RequestParam(value="no") int no, ModelAndView mv){
		
		String result = "fail";
		
		if(streamingService.deleteStreaming(no) > 0) {
				result = "ok"; 
		}
		
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 스트리밍 댓글 리스트
	@RequestMapping(value="selectStreamingReplyList", method=RequestMethod.POST)
	public ModelAndView selectStreamingReplyList(ModelAndView mv, @RequestParam("no")String no, StreamingReplyDto keywordDto){
		
		mv.setViewName("jsonView");
		
		int countList = 10;
		keywordDto.setCount_list(10);
		keywordDto.setNo(Integer.parseInt(no));
		
		int boardCount = streamingService.selectCountStreamingReplyList(keywordDto);
		
		int countPage = 10;
		int maxPage = boardCount / countList;
		int currentPage = keywordDto.getCurrent_page();
		
		if(boardCount % countList > 0){
			maxPage++;
		}
		
		if(maxPage < currentPage){
			currentPage = maxPage;
		}
		
		int start_row = (currentPage - 1 ) * countList + 1;
		int end_row = start_row + countList - 1;
		
		keywordDto.setStart_row(start_row);
		keywordDto.setEnd_row(end_row);
		
		ArrayList<StreamingReplyDto> list = streamingService.selectStreamingReplyList(keywordDto);
		for(int i=0; i< list.size(); i++){
			System.out.println(i + "번째 : " + list.get(i));
		}
		
		mv.addObject("list", list);
		
		int startPage = ((currentPage -1) / countPage ) * countPage + 1;
		int endPage = startPage + countPage - 1;
		
		if(endPage > maxPage){
			endPage = maxPage;
		}
		
		HashMap<String, Integer> pageMap = new HashMap<>();
		pageMap.put("max_page", maxPage);
		pageMap.put("start_page", startPage);
		pageMap.put("end_page", endPage);
		pageMap.put("current_page", currentPage);
		pageMap.put("board_count", boardCount);
		
		mv.addObject("infoMap", pageMap);
		
		return mv;
	}
	// 스트리밍 댓글 작성
	@RequestMapping(value="insertStreamingReply", method = RequestMethod.POST)
	public ModelAndView insertStreamingReply(ModelAndView mv, StreamingReplyDto streamingReply, HttpServletRequest request){
		
		mv.setViewName("jsonView");
		String resultMessage = "fail";
		
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){
			return mv;
		}
		
		streamingReply.setId(loginDto.getId());
		
		if(streamingService.insertStreamingReply(streamingReply) > 0){
			resultMessage = "success";
		}
		
		mv.addObject("resultMessage", resultMessage);
		
		return mv;
	}
	// 스트리밍 댓글 수정
	@RequestMapping("updateStreamingReply")
	public ModelAndView updateStreamingReply(ModelAndView mv, StreamingReplyDto streamingReply, HttpServletRequest request){
		
		mv.setViewName("jsonView");
		mv.addObject("resultMessage", "fail");
		
		//Exception
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){
			return mv;
		}
		
		streamingReply.setId(loginDto.getId());
		
		if(streamingService.updateStreamingReply(streamingReply) > 0){
			mv.addObject("resultMessage", "success");
		}
		
		
		return mv;
	}
	// 스트리밍 댓글 삭제
	@RequestMapping("deleteStreamingReply")
	public ModelAndView deleteStreamingReply(ModelAndView mv, StreamingReplyDto streamingReply, HttpServletRequest request){
		
		mv.setViewName("jsonView");
		mv.addObject("resultMessage", "fail");
		
		//Exception
		MemberDto loginDto = (MemberDto)request.getSession(false).getAttribute("loginMemberDto");
		if(loginDto == null){
			return mv;
		}
		
		streamingReply.setId(loginDto.getId());
		
		if(streamingService.deleteStreamingReply(streamingReply) > 0){
			mv.addObject("resultMessage", "success");
		}
		
		return mv;
	}
	// 스트리밍 키워드 검색  그런 거 없어 돌아가
	
	// 스트리밍 게시글 총 갯수
	public ModelAndView selectCountStreaming(ModelAndView mv){
		
		return mv;
	}
	

	
	

	
}
