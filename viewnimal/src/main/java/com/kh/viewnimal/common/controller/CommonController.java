package com.kh.viewnimal.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.channel.model.dto.ChannelDto;
import com.kh.viewnimal.common.model.dto.Trie;
import com.kh.viewnimal.common.model.service.CommonService;
import com.kh.viewnimal.freeboard.model.dto.FreeBoardDto;
import com.kh.viewnimal.volunteerapply.model.dto.VolunteerApplyDto;
import com.kh.viewnimal.volunteerepilogue.model.dto.VolunteerEpilogueDto;

@Controller
public class CommonController {

	@Autowired
	private JavaMailSenderImpl mailSender;

	@Autowired
	private CommonService commonService;
	
	/**
	 * 사용할 파라미터 리스트
	 *
	 * HttpServletRequest request
	 * HttpServletResponse response
	 * ModelAndView mav
	 * MemberDto memberDto
	 * @RequestBody String param
	 */

	// ---------------------------------------------------------------- 에러 페이지
	@RequestMapping(value = "TestError", method = RequestMethod.GET)
	public ModelAndView moveErrorPage(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav, Model model
	) {
		mav.setViewName("error/error");

		return mav;
	}

	@RequestMapping(value = "Test404", method = RequestMethod.GET)
	public ModelAndView move404Page(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav, Model model
	) {
		mav.setViewName("error/404");

		return mav;
	}

	// ---------------------------------------------------------------- 페이지
	@RequestMapping(value = "Main", method = RequestMethod.GET)
	public ModelAndView moveMainPage(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav, Model model
	) {
		// 이메일 변경 컨트롤러에서 넘어온 경우
		Map<String, Object> modelMap 			= model.asMap();
		// addFlashAttribute 로 넘어온 속성은 새로고침 할 경우 사라짐 :)
		Object 				keyIsUpdatePassword = modelMap.get("isUpdatePassword");
		
		if ( null != keyIsUpdatePassword ) {
			mav.addObject( "isUpdatePassword", (boolean) keyIsUpdatePassword );
		}

		mav.addObject( "pageSubType", "Main" );
		mav.setViewName("client/main");

		return mav;
	}

	@RequestMapping(value = "SearchAll", method = RequestMethod.GET)
	public ModelAndView moveSearchAllPage(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav
	) {
		String 		keyword 		= request.getParameter("keyword");
		String 		queryKeyword 	= "";
		String 		filterStr 		= "%_@";
		String[] 	strArr 			= keyword.split("");

		// 특수문자 검색을 위해 % _ @ 는 앞에 @ 붙여줌 ' 는 '하나 더 붙여줌
		for ( int i = 0, ilen = strArr.length; i < ilen; i += 1 ) {
			String str = strArr[i];

			if 		( filterStr.contains( str ) ) 	{ str = "@" + str; }
			else if ( "'".contains( str ) ) 		{ str = "'" + str; }

			strArr[i] = str;
		}

		queryKeyword = String.join( "", strArr );

		// (홀,쌍 따옴표가 문제임 - 해결불가 !)
		// 콘솔에 찍히는 쿼리를 sql developer 에서 실행하면 잘 나오는데 마이바티스에서는 못 가져옴
		/*
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>");
			System.out.println("파라미터 값 : " + keyword);
			System.out.println("쿼리날릴 값 : " + queryKeyword);
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>");
		*/

		// 통합검색
		ArrayList<ChannelDto> 			channelList 			= commonService.selectChannel			( queryKeyword );
		ArrayList<FreeBoardDto> 		freeBoardList 			= commonService.selectFreeBoard			( queryKeyword );
		ArrayList<VolunteerApplyDto> 	volunteerApplyList 		= commonService.selectVolunteerApply	( queryKeyword );
		ArrayList<VolunteerEpilogueDto> volunteerEpilogueList 	= commonService.selectVolunteerEpilogue	( queryKeyword );

		HashMap<String, ArrayList<?>>  boardList = new HashMap<String, ArrayList<?>>() {{
			put( "channelList", 			channelList ) ;
			put( "freeBoardList", 			freeBoardList ) ;
			put( "volunteerApplyList", 		volunteerApplyList ) ;
			put( "volunteerEpilogueList", 	volunteerEpilogueList ) ;
		}};

		mav.addObject( "boardList", boardList );

		mav.setViewName("client/searchAll");

		return mav;
	}

	@RequestMapping(value = "AdminMain", method = RequestMethod.GET)
	public ModelAndView moveAdminMainPage(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav
	) {
		HashMap<String, Integer> memberCountMap = commonService.selectMemberCount();
		HashMap<String, Integer> productCountMap = commonService.selectProductCount();
		HashMap<String, Integer> channelCountMap = commonService.selectChannelCount();
		HashMap<String, Integer> streamingCountMap = commonService.selectStreamingCount();
		HashMap<String, Integer> labCountMap = commonService.selectLabCount();
		HashMap<String, Integer> noticeCountMap = commonService.selectNoticeCount();
		HashMap<String, Integer> volunteerApplyCountMap = commonService.selectVolunteerApplyCount();
		HashMap<String, Integer> volunteerEpilogueCountMap = commonService.selectVolunteerEpilogueCount();
		HashMap<String, Integer> adoptionApplyCountMap = commonService.selectAdoptionApplyCount();
		HashMap<String, Integer> adoptionReviewCountMap = commonService.selectAdoptionReviewCount();
		HashMap<String, Integer> freeBoardCountMap = commonService.selectFreeBoardCount();

		ArrayList<HashMap<String, Object>> selectVolunteerApplyGraphList = commonService.selectVolunteerApplyGraph();

		mav.addObject( "memberCountMap", memberCountMap );
		mav.addObject( "productCountMap", productCountMap );
		mav.addObject( "channelCountMap", channelCountMap );
		mav.addObject( "streamingCountMap", streamingCountMap );
		mav.addObject( "labCountMap", labCountMap );
		mav.addObject( "noticeCountMap", noticeCountMap );
		mav.addObject( "volunteerApplyCountMap", volunteerApplyCountMap );
		mav.addObject( "volunteerEpilogueCountMap", volunteerEpilogueCountMap );
		mav.addObject( "adoptionApplyCountMap", adoptionApplyCountMap );
		mav.addObject( "adoptionReviewCountMap", adoptionReviewCountMap );
		mav.addObject( "freeBoardCountMap", freeBoardCountMap );
		
		mav.addObject( "selectVolunteerApplyGraphList", selectVolunteerApplyGraphList );
;
		mav.setViewName("admin/adminMain");

		return mav;
	}

	// ---------------------------------------------------------------- 기능
	@RequestMapping("common/removeSession")
	public ModelAndView testRemoveSession( HttpServletRequest request, HttpServletResponse response, ModelAndView mav, SessionStatus session ) {
		request.getSession( false ).invalidate();

		mav.setViewName( "jsonView" );
		
		return mav;
	}

	@RequestMapping(value = "autoComplete", method = RequestMethod.POST)
	public ModelAndView matchAutoCompleteDataList(ModelAndView mav, HttpServletRequest request){
		
		String keword = request.getParameter("keword");

		if(request.getSession().getServletContext().getAttribute("trie") != null){
			Trie trie = (Trie)request.getSession().getServletContext().getAttribute("trie");	//웹 어플리케이션 생성 시에 서블릿컨텍스트에 setattribute 한 값 가져오기			
			List<String> autoKewordList = trie.search(keword);
			trie.setKewordCount(0); //list 갯수 초기화
			
			if(autoKewordList != null && autoKewordList.size() > 0 )	//매칭되는 단어가 있을 때
			{
				mav.addObject("autoKewordList", autoKewordList);
			}
		}
		
		mav.setViewName("jsonView");
		
		return mav;
	}
	
}
