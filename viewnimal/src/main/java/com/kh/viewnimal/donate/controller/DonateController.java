package com.kh.viewnimal.donate.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.donate.model.dto.DonateDto;
import com.kh.viewnimal.donate.model.service.DonateService;
import com.kh.viewnimal.member.model.dto.MemberDto;

@Controller
public class DonateController {

	@Autowired
	private DonateService donateService;

	/**
	 * 사용할 파라미터 리스트
	 *
	 * HttpServletRequest request
	 * HttpServletResponse response
	 * ModelAndView mav
	 * MemberDto memberDto
	 * @RequestBody String param
	 */

	// ---------------------------------------------------------------- 페이지
	@RequestMapping( value = "AdminDonationList", method = RequestMethod.GET )
	public ModelAndView moveAdminMemberPage(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav
	) {
		int 					totalBoard 		= donateService.selectListCount( new HashMap<String, Object>() );
		ArrayList<DonateDto> 	donateDtoList 	= donateService.selectList( new HashMap<String, Object>() );

		mav.addObject("totalBoard", totalBoard);
		mav.addObject("donateDtoList", donateDtoList);
		mav.setViewName("admin/adminDonationList");

		return mav;
	}

	@RequestMapping( value = "DonateList", method = RequestMethod.GET )
	public ModelAndView moveDonateListPage(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav
	) {
		// 세션
		HttpSession session = request.getSession( false );

		if ( null != session ) {
			MemberDto nowLoginMemberDto = (MemberDto) session.getAttribute("loginMemberDto");

			if ( null != nowLoginMemberDto ) {
				// 쿼리 검색을 위한 객체
				HashMap<String, Object> searchMap = new HashMap<String, Object>() {{
					put( "supporter_id", nowLoginMemberDto.getId() );
				}};

				String category = request.getParameter("category");
				String keyword 	= request.getParameter("keyword");

				if ( null != category && null != keyword ) {
					searchMap.put( "category", category.toUpperCase() );
					searchMap.put( "keyword", keyword );
				}

				// 총 게시물 수
				int totalBoard 	= donateService.selectListCount( searchMap );

				// 1개 이상 있을 때
				if ( totalBoard > 0 ) {
					String 	paramPage 	= request.getParameter("page");
					int 	page 		= null != paramPage ? Integer.parseInt( paramPage ) : 1;

					// 쿼리 및 ui 구성을 위한 정보 가져오기
					HashMap<String, Integer> pageInfo = getPageInfo( page, totalBoard );

					searchMap.put( "startRow", 	pageInfo.get("startRow") );
					searchMap.put( "endRow", 	pageInfo.get("endRow") );

					// 게시물 가져오기
					ArrayList<DonateDto> donateDtoList = donateService.selectList( searchMap );

					// 보여지는 No(순번) 세팅
					for ( DonateDto e : donateDtoList ) {
						e.setRnum( (totalBoard + 1) - e.getRnum() );
					}

					mav.addAllObjects( pageInfo );
					mav.addObject( "donateDtoList", donateDtoList );
				}

				mav.addObject( "totalBoard", totalBoard );
			}
		}

		mav.addObject( "pageSubType", "DonateList" );
		mav.setViewName("client/mypage/donateList");

		return mav;
	}

	@RequestMapping( value = "donate/listSearch", method = RequestMethod.POST )
	public ModelAndView listSearch(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav
	) {
		// Command 객체 처리
		mav.addObject( "modelAndView", null );

		// 세션
		HttpSession session = request.getSession( false );

		if ( null != session ) {
			MemberDto nowLoginMemberDto = (MemberDto) session.getAttribute("loginMemberDto");

			if ( null != nowLoginMemberDto ) {
				// 쿼리 검색을 위한 객체
				HashMap<String, Object> searchMap = new HashMap<String, Object>() {{
					put( "supporter_id", nowLoginMemberDto.getId() );
				}};

				String category = request.getParameter("category");
				String keyword 	= request.getParameter("keyword");

				if ( null != category && null != keyword ) {
					searchMap.put( "category", category.toUpperCase() );
					searchMap.put( "keyword", keyword );
				}

				// 총 게시물 수
				int totalBoard = donateService.selectListCount( searchMap );

				// 1개 이상 있을 때
				if ( totalBoard > 0 ) {
					String 	paramPage 	= request.getParameter("page");
					int 	page 		= null != paramPage ? Integer.parseInt( paramPage ) : 1;

					// 쿼리 및 ui 구성을 위한 정보 가져오기
					HashMap<String, Integer> pageInfo = getPageInfo( page, totalBoard );

					searchMap.put( "startRow", 	pageInfo.get("startRow") );
					searchMap.put( "endRow", 	pageInfo.get("endRow") );

					// 게시물 가져오기
					ArrayList<DonateDto> donateDtoList = donateService.selectList( searchMap );

					// 보여지는 No(순번) 세팅
					for ( DonateDto e : donateDtoList ) {
						e.setRnum( (totalBoard + 1) - e.getRnum() );
						e.setDonate_date_str( e.getDonate_date().toString() );
						e.setDonate_date( null );
					}

					searchMap.put( "category", category );

					mav.addAllObjects( searchMap );
					mav.addAllObjects( pageInfo );
					mav.addObject( "donateDtoList", donateDtoList );
				}

				mav.addObject( "totalBoard", totalBoard );
			}
		}

		mav.setViewName( "jsonView" );

		return mav;
	}

	// 쿼리 및 ui 구성을 위한 정보 가져오기
	public HashMap<String, Integer> getPageInfo( int currentPage, int totalBoard ) {
		HashMap<String, Integer> map = new HashMap<String, Integer>();

		int countBoard 			= 10; // 한 페이지당 게시물 개수
		int countPagination 	= 10; // pagination 표시 개수

		int maxPage 			= (totalBoard / countBoard) + (totalBoard % countBoard != 0 ? 1 : 0);
		
		if( maxPage < currentPage ) { currentPage = maxPage; }
		
		int startPage 	= ((currentPage - 1) / countPagination) * countPagination + 1;
		int endPage 	= startPage + countPagination - 1;
		
		if( endPage > maxPage ) { endPage = maxPage; }
		
		int startRow 	= (currentPage - 1) * countBoard + 1;
		int endRow 		= startRow + countBoard - 1;
			
		map.put( "currentPage", currentPage );
		map.put( "maxPage", 	maxPage );
		map.put( "startPage", 	startPage );
		map.put( "endPage", 	endPage );
		map.put( "startRow", 	startRow );
		map.put( "endRow", 		endRow );
		
		return map;
	}

	// ---------------------------------------------------------------- SELECT

	// ---------------------------------------------------------------- INSERT
	// 후원내역 등록
	@RequestMapping( value = "donate/insertList", method = RequestMethod.POST )
	public ModelAndView insertList(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav
	) throws Exception {
		// Command 객체 처리
		mav.addObject( "modelAndView", null );

		String donateList = request.getParameter("donateList");

		JSONParser 	jsonParser 	= new JSONParser();
		JSONArray 	jsonArr 	= (JSONArray) jsonParser.parse( donateList );

		int result = donateService.insertDonate( jsonArr );

		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );

		return mav;
	}

	// ---------------------------------------------------------------- UPDATE
	// 후원내역 수정
	@RequestMapping( value = "donate/updateList", method = RequestMethod.POST )
	public ModelAndView updateList(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav
	) throws Exception {
		// Command 객체 처리
		mav.addObject( "modelAndView", null );

		String donateList = request.getParameter("donateList");

		JSONParser 	jsonParser 	= new JSONParser();
		JSONArray 	jsonArr 	= (JSONArray) jsonParser.parse( donateList );

		int result = donateService.updateDonate( jsonArr );

		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );

		return mav;
	}

	// ---------------------------------------------------------------- DELETE
	// 후원내역 삭제
	@RequestMapping( value = "donate/deleteList", method = RequestMethod.POST )
	public ModelAndView deleteList(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav
	) throws Exception {
		// Command 객체 처리
		mav.addObject( "modelAndView", null );

		String donateList = request.getParameter("donateList");

		JSONParser 	jsonParser 	= new JSONParser();
		JSONArray 	jsonArr 	= (JSONArray) jsonParser.parse( donateList );

		int result = donateService.deleteDonate( jsonArr );

		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );

		return mav;
	}

}
