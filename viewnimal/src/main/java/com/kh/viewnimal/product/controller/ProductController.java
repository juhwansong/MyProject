package com.kh.viewnimal.product.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.basket.model.dto.BasketDto;
import com.kh.viewnimal.member.model.dto.MemberDto;
import com.kh.viewnimal.product.model.dto.ProductDto;
import com.kh.viewnimal.product.model.service.ProductService;

@Controller
public class ProductController {

	@Autowired
	private ProductService productService;
	
	///////////////////상품 리스트 페이지/////////////////
		
	// 상품 리스트
	@RequestMapping("ProductList")
	public ModelAndView selectProductAllList( ModelAndView mav, HttpServletRequest request, HttpServletResponse response ) {
		
		int currentPage = 1;
		
		int limit = 12;
		
		if(request.getParameter("page") != null){
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		String category = request.getParameter("category");
		System.out.println("category = " + category);
		
		int listCount = productService.selectGetListCount(category);
		
		String productList = request.getParameter("productList");
		System.out.println("productArrayList = " + productList);
		
		ArrayList<ProductDto> list = productService.selectProductAllList(currentPage, limit, category, productList);
		
		int maxPage = (int) Math.ceil(((double)listCount / limit));
		
		int startPage = (((int)((double)currentPage / (limit - 2) + 0.9)) - 1) * (limit - 2) + 1;
		System.out.println("startPage = " + startPage);
		
		int endPage = startPage + (limit - 2) - 1;
		
		if(maxPage < endPage) {
			endPage = maxPage;
		}
		System.out.println("endPage" + endPage);

		// Code By Lee
		// 카테고리가 null이면 "all"로 바꿔서 넘겨줌
		category = null == category ? "전체" : category;

		mav.setViewName("client/product/shopProductList");
		mav.addObject("pageMainType", "shop");
		mav.addObject("currentPage", currentPage);
		mav.addObject("list", list);
		mav.addObject("maxPage", maxPage);
		mav.addObject("startPage", startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("listCount", listCount);
		mav.addObject("category", category);
		mav.addObject("productList", productList);
		
		return mav;
	}
	
	// 분류에 따른 상품 리스트
	@RequestMapping("categoryProductList")
	public ModelAndView selectCategoryProductList() {
	
		return null;
	}
	
	// 하나의 상품 상세 페이지 이동
	@RequestMapping("ProductDetail")
	public ModelAndView selectMoveProductDetailPage(ModelAndView mav, ProductDto proDto, 
								@RequestParam(value="productId") String productId) {
		
		proDto = productService.selectMoveProductDetailPage(productId);
		
		mav.setViewName("client/product/shopProductDetail");
		mav.addObject("productDto", proDto);
		mav.addObject("pageMainType", "shop");
		
		return mav;
	}
	
	//////////////////장바구니에서 제품 리스트 불러오기//////////////////////////
	@RequestMapping(value="SelectCart")
	public ModelAndView selectBasketPageMove(HttpServletRequest request, HttpServletResponse response,
								ModelAndView mav) {
	
		MemberDto memberDto = (MemberDto) request.getSession().getAttribute("loginMemberDto");
		ArrayList<ProductDto> list = productService.selectBasketPageMove(memberDto.getId());
		System.out.println("selectCart = " + list);
		int totalPrice = 0;
		if(!list.equals(null)) {
			for(ProductDto p : list) {
				totalPrice += (p.getPrice() * p.getAmount());
			}
		}
		
		mav.setViewName("client/basket/shopBasket");
		mav.addObject("list", list);
		mav.addObject("totalPrice", totalPrice);
		mav.addObject("pageMainType", "shop");
		
		return mav;
	}
	
	// 장바구니에서 하나 상품 결제 페이지 이동
	@RequestMapping("OrderProductOne")
	public ModelAndView selectMoveOrderOnePage(ModelAndView mav, ProductDto productDto) {
		System.out.println("productDto = " + productDto);
		mav.setViewName("client/payment/shopPayment");
		ArrayList<ProductDto> list = new ArrayList<ProductDto>();
		
		list.add(productDto);
		
		mav.addObject("list", list);
		
		int totalPrice = productDto.getPrice() * productDto.getAmount();
		
		mav.addObject("totalPrice", totalPrice);
		mav.addObject("pageMainType", "shop");
		
		return mav;
	}
	
	//////////////////////////상품 결제 페이지 이동 ////////////////////////
	@RequestMapping(value="AllOrder")
	public ModelAndView allOrderPageMove(ModelAndView mav, ProductDto productDto,
										HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("AllOrder productDto = " + productDto);
		
		MemberDto memberDto = (MemberDto) request.getSession().getAttribute("loginMemberDto");
		
		String[] idArray = productDto.getProduct_id().split(",");
		
		ArrayList<String> product_id = new ArrayList<String>();
		
		for(String s : idArray) {
			product_id.add(s);
		}
		
		ArrayList<ProductDto> list = productService.allOrderPageMove(product_id, memberDto.getId());
		
		mav.setViewName("client/payment/shopPayment");
		mav.addObject("list", list);
		System.out.println("list = " + list);
		int totalPrice = 0;
		
		for(ProductDto p : list) {
			totalPrice += (p.getAmount() * p.getPrice());
		}
		
		mav.addObject("totalPrice", totalPrice);
		mav.addObject("pageMainType", "shop");
		
		return mav;
	}
	
	// 바로 결제 가기 //
	@RequestMapping("NowOrder")
	public ModelAndView selectBuyNow(ModelAndView mav, ProductDto productDto, @RequestParam(value="now") String now) {
		
		ArrayList<ProductDto> list = productService.selectBuyNow(productDto);
		
		
		mav.setViewName("client/payment/shopPayment");
		
		list.get(0).setAmount(productDto.getAmount());
		mav.addObject("list", list);
		mav.addObject("totalPrice", productDto.getAmount() * list.get(0).getPrice());
		mav.addObject("pageMainType", "shop");
		mav.addObject("now", now);
		
		return mav;
	}
	
	//////////////////////////결제 완료 페이지 이동 ///////////////////////
	@RequestMapping("PayComplete")
	public ModelAndView selectPagePayComplete(ModelAndView mav, ProductDto productDto,
										HttpServletRequest request, HttpServletResponse response,
										@RequestParam(value="methodpay") int methodpay,
										@RequestParam(value="totalPrice") int totalPrice) {
		System.out.println("productDto = " + productDto);
		
		MemberDto memberDto = (MemberDto) request.getSession().getAttribute("loginMemberDto");
		
		String[] product_id = productDto.getProduct_id().split(",");
		
		ArrayList<ProductDto> productList = new ArrayList<ProductDto>();
		
		for(int i = 0; i < product_id.length; i++) {
			ProductDto proDto = new ProductDto();
			proDto.setProduct_id(product_id[i]);
			productList.add(proDto);
		}
		
		ArrayList<ProductDto> list = productService.selectPagePayComplete(productList, memberDto.getId());
		System.out.println("complete list = " + list);
		
		mav.setViewName("client/payment/shopPaymentComplete");
		mav.addObject("list", list);
		
		ArrayList<String> noList = new ArrayList<String>();
		for(ProductDto p : list) {
			noList.add(p.getOrder_no());
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");		
		
		Collections.sort(noList);
		System.out.println("noList = " + noList);
		System.out.println("noList sort = " + noList.get(noList.size() - 1));
		mav.addObject("order_no", noList.get(noList.size() - 1));
		System.out.println("request.getParameter = " + request.getParameter("methodpay"));
		System.out.println("methodpay = " + methodpay);
		mav.addObject("methodpay", request.getParameter("methodpay"));
		mav.addObject("totalPrice", totalPrice);
		mav.addObject("pageMainType", "shop");
		mav.addObject("payDate", sdf.format(new java.util.Date()));
		
		return mav;
	}
	
	////////////////////////// 관리자 페이지 //////////////////////////
	
	// 상품 등록
	public ModelAndView insertProduct() {
	
		return null;
	}
	
	// 상품 수정
	public ModelAndView updateProduct() {
	
		return null;
	}
	
	// 상품 삭제
	public ModelAndView deleteProduct() {
	
		return null;
	}
	
	// 상품검색
	public ModelAndView selectSearchProduct() {
	
		return null;
	}
}