package com.kh.viewnimal.infoboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.infoboard.model.service.InfoBoardService;

@Controller
public class InfoBoardController {

	@Autowired
	private InfoBoardService infoBoardService;
	
	
	// 생정게시판 리스트
	@RequestMapping("InfoBoard")
	public ModelAndView selectInfoBoardList(ModelAndView mv){
		mv.setViewName("client/infoBoard/infoBoardList");
		mv.addObject("pageSubType", "InfoBoard");
		return mv;
	}
		
	// 생정게시판 상세페이지
	@RequestMapping("InfoBoardDetail")
	public ModelAndView selectInfoBoardDetail(ModelAndView mv){
		mv.setViewName("client/infoBoard/infoBoardDetail");
		mv.addObject("pageSubType", "InfoBoard");			
		return mv;
	}

	// 생정게시판 글 작성
	@RequestMapping("InfoBoardWrite")
	public ModelAndView insertInfoBoard(ModelAndView mv){
		mv.setViewName("client/infoBoard/infoBoardWrite");
		mv.addObject("pageSubType", "InfoBoard");		
		return mv;
	}
		
	// 생정게시판 글 수정
	public ModelAndView UpdateInfoBoard(ModelAndView mv){
			
		return mv;
	}
		
	// 생정게시판 글 삭제 (비공개)
	public ModelAndView updateInfoBoardNonActive(ModelAndView mv){
			
		return mv;
	}
		
	// 생정게시판 글 검색
	public ModelAndView selectInfoBoardSearch(ModelAndView mv){
			
		return mv;
	}
		
		
		
	// 생정게시판 댓글 리스트
	public ModelAndView selectInfoBoardReplyList(ModelAndView mv){
			
		return mv;
	}
		
	// 생정게시판 댓글 작성
	public ModelAndView insertInfoBoardReply(ModelAndView mv){
			
		return mv;
	}
		
	// 생정게시판 댓글 수정
	public ModelAndView updateInfoBoardReply(ModelAndView mv){
			
		return mv;
	}
		
	// 생정게시판 댓글 삭제
	public ModelAndView deleteInfoBoardReply(ModelAndView mv){
			
		return mv;
	}
	
	
	
}
