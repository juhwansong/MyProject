package com.kh.viewnimal.adoption.controller;

import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.adoption.model.dto.AdoptionAdminDto;
import com.kh.viewnimal.adoption.model.dto.AdoptionApplyDto;
import com.kh.viewnimal.adoption.model.service.AdoptionApplyService;

@Controller
public class AdoptionApplyController {
	@Autowired
	private AdoptionApplyService adoptionApplyService;

	// 입양 신청
	@RequestMapping(value="ApplyAdoption", method={RequestMethod.POST, RequestMethod.GET})
	public ModelAndView insertApplyAdoption(AdoptionApplyDto applyDto, ModelAndView mv) {
		System.out.println(">>>>>>>>>>>>command : " + applyDto);
		adoptionApplyService.insertAdoption(applyDto);
		
		mv.setViewName("client/adoption/adoptionPetList");
		
		return mv;		
	}

	// 입양 신청 상세글 조회
	public ModelAndView selectApplyAdoption(ModelAndView mv) {
		return mv;
	}

	// 입양 신청 상태 수정
	@RequestMapping(value="UpdateState", method=RequestMethod.POST)
	public ModelAndView updateAdoption(ModelAndView mv, HashMap<String, Object> hmap,
			@RequestParam(name="no") int no,
			@RequestParam(name="state") String state) {
		
		System.out.println(no+","+state);
		hmap.put("no", no);
		hmap.put("state",state);
		
		int result = adoptionApplyService.updateState(hmap);
		
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	// 입양 신청 삭제
	@RequestMapping(value="DeleteApply", method=RequestMethod.POST)
	public ModelAndView deleteApply(ModelAndView mv,
			@RequestParam(name="no") int no){
	
		int result = adoptionApplyService.deleteApply(no);
		
		mv.addObject("result", result);
		mv.setViewName("jsonView");
		
		return mv;
	}
	

	// 관리자 입양 신청 관리 페이지로 이동
	@RequestMapping("AdminAdoption")
	public ModelAndView moveAdminAdoption(ModelAndView mv, HashMap<String, Integer> hmap) {
		
		int currentPage = 1;
		int limit = 10;
		int listCount = adoptionApplyService.getAdminListCount();
		int totalPage = (int) ((double) listCount / limit + 0.95);
		int startPage = (((int) ((double) currentPage / 10 + 0.9)) - 1) * 10 + 1;
		int endPage = startPage + 9;
		if (endPage > totalPage)
			endPage = totalPage;
		if(endPage > totalPage)
			endPage = totalPage;
		boolean next = true;

		hmap.put("currentPage", currentPage);
		hmap.put("limit", limit);
		
		mv.addObject("applyList", adoptionApplyService.selectAdminList(hmap));
		mv.addObject("adoptedPet", adoptionApplyService.selectAdoptedPet());
		mv.addObject("currentPage", currentPage);
		mv.addObject("limit", limit);
		mv.addObject("listCount", listCount);
		mv.addObject("totalPage", totalPage);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("next", next);

		mv.setViewName("admin/adminAdoptionApplyList");

		return mv;
	}
	
	// 관리자 입양 신청 페이징
	@RequestMapping("AdminAdoptionPage")
	public ModelAndView pagingAdminAdoptionPage(ModelAndView mv, HashMap<String, Integer> hmap,
			@RequestParam(name="currentPage") int currentPage,
			@RequestParam(name="limit") int limit){
		
		int listCount = adoptionApplyService.getAdminListCount();
		
		int totalPage = listCount / limit; //전페 페이지 수
		if((listCount % limit) > 0)
			totalPage ++;
		
		int currentBlock = currentPage / 10; //현재 페이지 블록
		if((currentPage % 10) > 0)
			currentBlock ++;
		
		int lastBlock = listCount / (10 * limit); //마지막 페이지 블록
		if((listCount % (10 * limit)) > 0)
			lastBlock ++;
		
		int startPage = (currentBlock * 10) - 9; //현재 블록의 시작 페이지
		
		int endPage = startPage + 9; //현재 블록의 끝 페이지
		if(currentBlock == lastBlock)
			endPage = totalPage;
		
		boolean prev = false; //이전 페이지
		boolean next; //다음 페이지
		if(currentPage >=1 && currentPage <=10){
			prev = false;
			next = true;
		}else if(lastBlock == currentBlock){
			prev = true;
			next = false;
		}else{
			prev = true;
			next = true;
		}
		
		hmap.put("currentPage", currentPage);
		hmap.put("limit", limit);
		
		mv.addObject("applyList", adoptionApplyService.selectAdminList(hmap));
		mv.addObject("adoptedPet", adoptionApplyService.selectAdoptedPet());
		mv.addObject("listCount", listCount);
		mv.addObject("totalPage", totalPage);
		mv.addObject("currentBlock", currentBlock);
		mv.addObject("lastBlock", lastBlock);
		mv.addObject("startPage", startPage);
		mv.addObject("endPage", endPage);
		mv.addObject("prev", prev);
		mv.addObject("next", next);
		
		mv.setViewName("admin/adminAdoptionApplyList");
		
		return mv;
	}
	
	// 관리자 검색 기능
	@RequestMapping("AdminSearch")
	public ModelAndView adminSearch(ModelAndView mv, HashMap<String, Object> hmap,
			@RequestParam(name="category") String category,
			@RequestParam(name="content") String content){
		
		hmap.put("category", category);
		hmap.put("content", content);
		//hmap.put("listCount", listCount);
		
		List<AdoptionAdminDto> list = adoptionApplyService.adminSearch(hmap);
		
		JSONArray jar = new JSONArray();
		
		for(AdoptionAdminDto adminDto : list){
			
			JSONObject job = new JSONObject();
			
			job.put("no", adminDto.getNo());
			job.put("id", adminDto.getId());
			job.put("username", adminDto.getusername());
			job.put("name", adminDto.getName());
			job.put("phone", adminDto.getPhone());
			job.put("request_date", adminDto.getRequest_date());
			job.put("state", adminDto.getState());
			job.put("review", adminDto.getReview());
			
			jar.add(job);
		}
		
		mv.addObject("list", jar);
		mv.setViewName("jsonView");
		
		return mv;
	}
	
}
