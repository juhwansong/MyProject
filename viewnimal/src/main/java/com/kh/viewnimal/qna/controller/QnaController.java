package com.kh.viewnimal.qna.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.member.model.dto.MemberDto;
import com.kh.viewnimal.qna.model.dto.QnaDto;
import com.kh.viewnimal.qna.model.service.QnaService;

@Controller
public class QnaController {
	
	@Autowired
	private QnaService qnaService;
	
	//////////////////회원//////////////////
	//qna 페이지로 이동(회원)
	@RequestMapping(value = "QnaList", method = RequestMethod.GET)
	public ModelAndView moveQnaListPage(QnaDto qna, HashMap<String, Object> paging, ModelAndView mv, HttpServletRequest request){
		
		int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
		HashMap<String, Integer> map = null;
		HttpSession session = request.getSession(false);
		
		if(null != session && null != session.getAttribute("loginMemberDto")){
			
			MemberDto memberDto = (MemberDto) session.getAttribute("loginMemberDto");
			qna.setId(memberDto.getId());
			
			paging.put("userid", qna.getId());
					
			//검색 목록 출력
			if(request.getParameter("sc1") != null){
				
				paging.put("kind", request.getParameter("sc1"));		//검색 카테고리(회원-제목/내용/문의종류)
				paging.put("category", request.getParameter("sc2"));	//문의종류
				paging.put("keyword", request.getParameter("sk"));		//keyword
				paging.put("where", request.getParameter("where"));		//넘어온 페이지 구분(매퍼1개라서)
				paging.put("type", "USER");								//매퍼 하나 쓰려고 강제 주입, 관리자도 개인페이지 확인가능
				map = pagination(currentPage, qnaService.selectSearchCount(paging));

				paging.put("startrow", map.get("startrow"));
				paging.put("endrow", map.get("endrow"));
				
				mv.addObject("list", qnaService.selectSearchKeyword(paging));
				
				
			//기본 목록 출력
			}else{

				map = pagination(currentPage, qnaService.selectCountList(qna));
				paging.put("startrow", map.get("startrow"));
				paging.put("endrow", map.get("endrow"));
				paging.put("type", "USER"); //매퍼 하나 쓰려고 강제 주입, 관리자도 개인페이지 확인가능
				
				mv.addObject("list", qnaService.selectQnaList(paging));
			}
		}
		mv.addObject( "pageSubType", "QnaList" );
		mv.addAllObjects(map);
		mv.setViewName("client/mypage/qnaList");
		return mv;
		
	}
	
	//qna 작성 페이지로 이동(회원)
	@RequestMapping(value = "QnaWrite", method = RequestMethod.GET)
	public String moveQnaWritePage(){
		return "client/mypage/qnaWrite";
	}
	
	//qna 읽기
	@RequestMapping(value = "qnaDetail", method = RequestMethod.POST)
	public ModelAndView selectQna(ModelAndView mv, @RequestParam(value="no") int no){
		mv.addObject("qna", qnaService.selectQna(no));
		mv.setViewName("jsonView");
		return mv;
	}
	
	//qna 작성
	@RequestMapping(value = "qnaWrite", method = RequestMethod.POST)
	public String insertQna(QnaDto qna){
		qnaService.insertQna(qna);		
		return "redirect:/QnaList";
	}
	
	//qna 수정
	@RequestMapping(value = "qnaModify", method = RequestMethod.POST)
	public String updateQna(QnaDto qna){
		qnaService.updateQna(qna);
		return "redirect:/QnaList";
	}
	
	//qna 삭제(회원/관리자 공용)
	@RequestMapping(value = "qnaDelete", method = RequestMethod.POST)
	public String deleteQna(@RequestParam(value="no") int no, @RequestParam(value="where") String where){
		qnaService.deleteQna(no);		
		
		if(where.equals("admin"))
			return "redirect:/AdminQna";
		else
			return "redirect:/QnaList";
		
	}
	
	
	//////////////////관리자전용//////////////////
	//qna 페이지로 이동(관리자)
	@RequestMapping(value = "AdminQna", method = RequestMethod.GET)
	public ModelAndView moveAdminQnaListPage(ModelAndView mv, HttpServletRequest request, HashMap<String, Object> paging){
		int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1;
		
		HttpSession session = request.getSession(false);
		HashMap<String, Integer> map = null;
		
		if(null != session && null != session.getAttribute("loginMemberDto")){
			
			MemberDto memberDto = (MemberDto) session.getAttribute("loginMemberDto");
			paging.put("type", memberDto.getType());
			
			//검색 목록 출력
			if(request.getParameter("sc1") != null){
				
				paging.put("kind", request.getParameter("sc1"));		//검색 카테고리(제목/내용/아이디/글번호/문의종류/처리상태)
				paging.put("category", request.getParameter("sc2"));	//문의종류
				paging.put("state", request.getParameter("sc3"));		//처리상태(관리자 전용)
				paging.put("keyword", request.getParameter("sk"));		//keyword
				paging.put("where", request.getParameter("where"));		//넘어온 페이지 구분
				
				map = pagination(currentPage, qnaService.selectSearchCount(paging));

				paging.put("startrow", map.get("startrow"));
				paging.put("endrow", map.get("endrow"));
				
				mv.addObject("list", qnaService.selectSearchKeyword(paging));
			
			//기본 목록 출력
			}else{
				
				map = pagination(currentPage, qnaService.selectCountListAdmin());
				
				paging.put("startrow", map.get("startrow"));
				paging.put("endrow", map.get("endrow"));
				
				mv.addObject("list", qnaService.selectQnaList(paging));
			}
		}
		mv.addAllObjects(map);
		mv.setViewName("admin/adminQna");
		return mv;
	}
	
	//qna 답변 작성/수정
	@RequestMapping(value = "adminQnaWrite", method = RequestMethod.POST)
	public String insertQnaAnswer(QnaDto qna){
		qnaService.insertQnaAnswer(qna);
		return "redirect:/AdminQna";
	}
	
	//qna 답글 삭제
	@RequestMapping(value = "adminQnaDelete", method = RequestMethod.GET)
	public String deleteQnaAnswer(@RequestParam(value="no") int no){
		qnaService.deleteQnaAnswer(no);
		return "redirect:/AdminQna";
	}
	
	
	//////////////////페이지네이션//////////////////
	public HashMap<String, Integer> pagination(int page, int total){
		HashMap<String, Integer> paging = new HashMap<>();
		int countList = 10, countPage = 10, currentPage = page, totalCount = total;
		int maxPage = totalCount / countList;
		if(totalCount % countList > 0)
			maxPage++;
		
		currentPage = (maxPage < currentPage) ? maxPage : currentPage;
		
		int startPage = ((currentPage - 1) / countPage) * countPage + 1;
		int endPage = startPage + countPage - 1;
		
		endPage = (endPage > maxPage) ? maxPage : endPage;
		
		int startrow = (currentPage - 1) * countList + 1;
		int endrow = startrow + countList - 1;
			
		paging.put("currentPage", currentPage);
		paging.put("maxPage", maxPage);
		paging.put("startPage", startPage);
		paging.put("endPage", endPage);
		paging.put("startrow", startrow);
		paging.put("endrow", endrow);
		
		return paging;
	}

}
