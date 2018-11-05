package com.kh.viewnimal.basket.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.basket.model.dto.BasketDto;
import com.kh.viewnimal.basket.model.service.BasketService;
import com.kh.viewnimal.member.model.dto.MemberDto;

@Controller
public class BasketController {

	@Autowired
	private BasketService basketService;
	
	/////////////// 상품 상세 페이지 ////////////////////
	// cart 클릭시
	@RequestMapping(value="addCart", method=RequestMethod.POST)
	public ModelAndView InsertCartBasket(ModelAndView mav, BasketDto basketDto) {
		
		System.out.println(basketDto);
		
		String okAndFail = "fail";
		
		if(basketService.insertCartBasket(basketDto) > 0) {
			okAndFail = "ok";
		}
		
		System.out.println("okAndFail = " + okAndFail);
		mav.addObject("okAndFail", okAndFail);
		
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	/////////////// 장바구니 페이지 /////////////////////////
	
	// 삭제하기 클릭시(하나 삭제)
	@RequestMapping(value="deleteOneBasket", method=RequestMethod.POST)
	public ModelAndView deleteOneBasket(ModelAndView mav, BasketDto basketDto) {
		System.out.println(basketDto);
		String okAndFail = "fail";
		
		if(basketService.deleteOneBasket(basketDto) > 0) {
			okAndFail = "ok";
		}
		
		mav.addObject("okAndFail", okAndFail);
		
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	// 전체 상품 삭제하기
	@RequestMapping(value="deleteAllBasket", method=RequestMethod.POST)
	public ModelAndView deleteAllBasket(ModelAndView mav, @RequestParam(value="id") String id) {
		
		String okAndFail = "fail";
		System.out.println(id);
		if(basketService.deleteAllBasket(id) > 0) {
			okAndFail = "ok";
		}
		
		mav.addObject("okAndFail", okAndFail);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	// check 상품 삭제하기
	@RequestMapping(value="deleteCheckBasket", method=RequestMethod.POST)
	public ModelAndView deleteCheckBasket(ModelAndView mav, @RequestParam(value="json") String param, 
									@RequestParam(value="id") String id) throws Exception {
		
		System.out.println("param = " + param);
		JSONParser jparser = new JSONParser();
		JSONArray jarr = (JSONArray) jparser.parse(param);
		System.out.println("jarr size : " + jarr.size());
		System.out.println("id = " + id);
		
		ArrayList<String> proIdList = new ArrayList<String>();
		
		for(int i = 0; i < jarr.size() - 1; i++) {
			String str = (String) jarr.get(i);
			System.out.println("str = " + str);
			proIdList.add(str);
		}
		
		String okAndFail = "fail";
		
		if(basketService.deleteCheckBasket(proIdList, id) > 0) {
			okAndFail = "ok";
		}
		
		mav.addObject("okAndFail", okAndFail);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	// 결제 완료에 따른 장바구니 삭제
	@RequestMapping(value="payCompleteBasketDelete", method=RequestMethod.POST)
	public ModelAndView completeBasketDelete(ModelAndView mav, BasketDto basketDto, HttpServletRequest request,
										HttpServletResponse response) {
		System.out.println("basketDto = " + basketDto);
		
		MemberDto memberDto = (MemberDto) request.getSession().getAttribute("loginMemberDto");
		
		ArrayList<BasketDto> list = new ArrayList<BasketDto>();
		
		String[] product_id = basketDto.getProduct_id().split(",");
		
		for(int i = 0; i < product_id.length; i++) {
			BasketDto baDto = new BasketDto();
			baDto.setProduct_id(product_id[i]);
			list.add(baDto);
		}
		
		String okAndFail = "fail";
		
		if(basketService.completeBasketDelete(list, memberDto.getId()) > 0) {
			okAndFail = "ok";
		}
		
		mav.addObject("okAndFail", okAndFail);
		mav.addObject("product_id", basketDto.getProduct_id());
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	// 수량 변경
	@RequestMapping(value="countUpdate", method=RequestMethod.POST)
	public ModelAndView updateBasketCount(ModelAndView mav, BasketDto basketDto, HttpServletRequest request,
										HttpServletResponse response) {
		
		System.out.println("basket count = " + basketDto);
		
		MemberDto memberDto = (MemberDto) request.getSession().getAttribute("loginMemberDto");
		basketDto.setId(memberDto.getId());
		
		String okAndFail = "fail";
		
		if(basketService.updateBasketCount(basketDto) > 0) {
			okAndFail = "ok";
		}
		
		mav.addObject("okAndFail", okAndFail);
		mav.setViewName("jsonView");
		
		return mav;
	}
}
