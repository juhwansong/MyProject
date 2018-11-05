package com.kh.viewnimal.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.viewnimal.member.model.dto.MemberDto;
import com.kh.viewnimal.member.model.service.MemberService;

@Controller
@SessionAttributes("loginMemberDto")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptEncoder;

	@Autowired
	private JavaMailSenderImpl mailSender;

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
	@RequestMapping( value = "AdminMember", method = RequestMethod.GET )
	public ModelAndView moveAdminMemberPage(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav
	) {
		int 					totalUser 		= memberService.selectListCount();
		ArrayList<MemberDto> 	memberDtoList 	= memberService.selectList();

		mav.addObject("totalUser", totalUser);
		mav.addObject("memberDtoList", memberDtoList);
		mav.setViewName("admin/adminMember");

		return mav;
	}

	@RequestMapping( value = "MyProfile", method = RequestMethod.GET )
	public ModelAndView moveMyProfilePage(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav
	) {
		mav.addObject( "pageSubType", "MyProfile" );
		mav.setViewName("client/mypage/myProfile");

		return mav;
	}

	// ---------------------------------------------------------------- SELECT
	// 로그인
	@RequestMapping( value = "member/login", method = RequestMethod.POST )
	public ModelAndView login(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav, MemberDto memberDto
	) {
		// Command 객체 처리
		mav.addObject( "modelAndView", null );
		mav.addObject( "memberDto", null );

		// 소셜 로그인은 클라이언트에서 파라미터로 id_type 값을 던져줌
		if ( null != memberDto.getId_type() ) {
			memberDto.setPassword( memberDto.getId() );
		}
		
		MemberDto 	result 		= memberService.selectLogin( memberDto );
		boolean 	ifStatement = null != result && bCryptEncoder.matches( memberDto.getPassword(), result.getPassword() );
		
		if ( ifStatement ) {
			result.setPassword(null);
			mav.addObject( "loginMemberDto", result );
		}
		
		mav.setViewName( "jsonView" );

		return mav;
	}

	// 이메일 중복체크
	@RequestMapping( value = "member/checkId", method = RequestMethod.POST )
	public ModelAndView checkId(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav, MemberDto memberDto
	) {
		// Command 객체 처리
		mav.addObject( "modelAndView", null );
		mav.addObject( "memberDto", null );

		int result = memberService.selectCheckId( memberDto.getId() );

		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );

		return mav;
	}

	// 닉네임 중복체크
	@RequestMapping( value = "member/checkNickname", method = RequestMethod.POST )
	public ModelAndView checkNickname(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav, MemberDto memberDto
	) {
		// Command 객체 처리
		mav.addObject( "modelAndView", null );
		mav.addObject( "memberDto", null );

		HashMap<String, String> nicknameMap = new HashMap<String, String>() {{
			put( "nickname", memberDto.getNickname() );
		}};

		// 세션
		HttpSession session 			= request.getSession( false );
		MemberDto 	nowLoginMemberDto 	= (MemberDto) session.getAttribute("loginMemberDto");

		// 로그인 상태
		if ( null != nowLoginMemberDto ) {
			nicknameMap.put( "withoutNickname", nowLoginMemberDto.getNickname() );
		}
		
		int result = memberService.selectCheckNickname( nicknameMap );

		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );

		return mav;
	}

	// 메일 보내기
	@RequestMapping( value = "member/sendMailInitPw", method = RequestMethod.POST )
	public ModelAndView sendMailInitPw(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav, MemberDto memberDto
	) {
		// Command 객체 처리
		mav.addObject( "modelAndView", null );
		mav.addObject( "memberDto", null );

		// 개인정보 체크
		MemberDto result = memberService.selectCheckInfo( memberDto );

		// 메일 보내기
		if ( null != result ) {
			String initPw 		= UUID.randomUUID().toString().replace("-", "").substring(0, 12);

			// 새 비밀번호를 암호화하여 토큰으로 저장
			result.setToken( bCryptEncoder.encode( initPw ) );
			
			// 토큰 업데이트 성공 시 메일 보냄
			if ( 1 == memberService.updateMember( result ) ) {
				String fromEmail 	= "khviewnimal@gmail.com";
				String toEmail 		= result.getEmail();
				String title 		= "Viewnimal 고객센터 - 새 비밀번호 발급";
				String html 		= "";
				String domain 		= "";
				String localName 	= request.getLocalName();

				if ( "localhost".equals(localName) ) 	{ domain = "http://" + localName + ":" + request.getLocalPort() + "/"; }
				else 									{ domain = "http://www.viewnimal.com/"; }

				html += "<form target='_blank' action='" + domain + "member/initPw' method='post' style='overflow: hidden; margin: 0 auto; padding: 0 30px; box-sizing: border-box;line-height: 100%;max-width: 700px;border: 1px solid #aaa;border-radius: 10px'>";
				html += "	<input type='hidden' name='id' value='" + result.getId() + "' />";
				html += "	<input type='hidden' name='password' value='" + initPw + "' />";
				html += "	<div class='img' style='height: 300px; margin: 0 auto;padding: 0;box-sizing: border-box;line-height: 100%;text-align: center'>";
				html += "		<img src='https://i.pinimg.com/originals/a5/5f/3f/a55f3fe0ea24f03c467d968d40bf5511.jpg' alt='' style='margin: 0;padding: 0;box-sizing: border-box;line-height: 100%;height: 100%;vertical-align: top'/>";
				html += "	</div>";
				html += "	<div class='content' style='margin: 0 auto;padding: 20px 0 50px;box-sizing: border-box;line-height: 100%'>";
				html += "		<div class='headline' style='margin: 0;padding: 0;box-sizing: border-box;line-height: 100%;padding-bottom: 10px;border-bottom: 3px solid #333;color: #3a3a3a;font-size: 40px;font-weight: 600'>VIEWNIM@L</div>";
				html += "		<div class='section' style='margin: 0;padding: 0;box-sizing: border-box;line-height: 100%;margin-top: 40px'>";
				html += "			<div class='title' style='margin: 0;padding: 0;box-sizing: border-box;line-height: 100%;color: #555;font-size: 30px'>새 비밀번호 발급</div>";
				html += "			<div class='article' style='margin: 0;padding: 20px 0;box-sizing: border-box;line-height: 40px;margin-top: 20px;border: 0 solid #aaa;border-width: 1px 0;color: #666;font-size: 16px'>";
				html += 				result.getId() + " 님의 발급 예정인 새 비밀번호입니다.<br style='margin: 0;padding: 0;box-sizing: border-box;line-height: 100%'/>";
				html += "				새 비밀번호 : <span class='em' style='margin: 0;padding: 0;box-sizing: border-box;line-height: 100%;display: inline-block;color: #5e72e4;font-size: 20px;font-weight: 600'>";
				html += 					initPw;
				html += "				</span><br style='margin: 0;padding: 0;box-sizing: border-box;line-height: 100%'/>";
				html += "				하단의 버튼을 클릭하면 새 비밀번호로 변경됩니다.";
				html += "			</div>";
				html += "		</div>";
				html += "		<button class='submit' type='submit' style='margin: 0;padding: 20px 50px;box-sizing: border-box;line-height: 100%;margin-top: 40px;border: 0;border-radius: 4px;background-color: #2f2f2f;color: #fff;font-size: 20px'>비밀번호 변경</button>";
				html += "	</div>";
				html += "</form>";
		
				
				final String text = html;

				MimeMessagePreparator preparator = new MimeMessagePreparator() {
					@Override
					public void prepare( MimeMessage mimeMessage ) {
						try {
							MimeMessageHelper mmh = new MimeMessageHelper( mimeMessage, true, "UTF-8" );
							
							mmh.setFrom		( fromEmail );
							mmh.setTo		( toEmail );
							mmh.setSubject	( title );
							mmh.setText		( text , true );
							
							// 단지 보낼 뿐 존재하지 않는 주소로 보내서 반송된 경우는 처리 불가
							mav.addObject( "isSend", true );
						}
						catch ( Exception e ) { e.printStackTrace(); }
					}
				};

				mailSender.send( preparator );
			}

			// 성공이든 실패든 반드시 처리해야할 부분
			// 다음번 작업 땐 쿼리에서 걸러서 뽑는게 안전해보임
			result.setPassword(null);
			result.setToken(null);
		}

		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );

		return mav;
	}

	// ---------------------------------------------------------------- INSERT
	// 회원가입
	@RequestMapping( value = "member/join", method = RequestMethod.POST )
	public ModelAndView join(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav, MemberDto memberDto
	) {
		// Command 객체 처리
		mav.addObject( "modelAndView", null );
		mav.addObject( "memberDto", null );

		// 소셜 가입은 클라이언트에서 파라미터로 id_type 값을 던져줌
		if ( null != memberDto.getId_type() ) {
			memberDto.setPassword( memberDto.getId() );
		}

		// 암호화
		memberDto.setPassword( bCryptEncoder.encode( memberDto.getPassword() ) );
		
		int result = memberService.insertMember( memberDto );
		
		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );

		return mav;
	}

	// ---------------------------------------------------------------- UPDATE
	// 새 비밀번호로 업데이트
	@RequestMapping( value = "member/initPw", method = RequestMethod.POST )
	public ModelAndView initPw(
		HttpServletRequest request, HttpServletResponse response
		, ModelAndView mav, RedirectAttributes ra, MemberDto memberDto
	) {
		int result = 0;

		// ID 를 통해 조회
		MemberDto 	checkMemberDto 	= memberService.selectLogin( memberDto );

		// ID 가 존재하며, 토큰 값과 새 비밀번호가 일치할 경우
		boolean ifStatement = null != checkMemberDto && bCryptEncoder.matches( memberDto.getPassword(), checkMemberDto.getToken() );

		// 업데이트
		if ( ifStatement ) {
			// 한번 사용한 토큰은 NULL 처리하여 재사용 못 하게 함
			// 빈 문자열로 날려 매퍼에서 동적쿼리로 NULL 처리
			memberDto.setToken("");

			// 암호화
			memberDto.setPassword( bCryptEncoder.encode( memberDto.getPassword() ) );

			result = memberService.updateMember( memberDto );
		}

		ra.addFlashAttribute( "isUpdatePassword", 1 == result ? true : false );
		mav.setViewName("redirect:/");

		return mav;
	}

	// 회원정보 업데이트
	@RequestMapping( value = "member/update", method = RequestMethod.POST )
	public ModelAndView update(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav, MemberDto memberDto
	) {
		// Command 객체 처리
		mav.addObject( "modelAndView", null );
		mav.addObject( "memberDto", null );

		int result = 0;

		// 세션
		HttpSession session 			= request.getSession( false );
		MemberDto 	nowLoginMemberDto 	= (MemberDto) session.getAttribute("loginMemberDto");

		// 입력받는 정보를 제외한 나머지는 세션에서 가져옴
		memberDto.setId			( nowLoginMemberDto.getId() );
		memberDto.setState		( nowLoginMemberDto.getState() );
		memberDto.setType		( nowLoginMemberDto.getType() );
		memberDto.setId_type	( nowLoginMemberDto.getId_type() );

		// 소셜 계정
		if ( ! "NORMAL".equals( memberDto.getId_type() ) ) {
			memberDto.setPassword( memberDto.getId() );
		}

		// 아이디를 통해 계정 정보 조회
		MemberDto checkMemberDto = memberService.selectLogin( memberDto );

		// 세션에 있는 계정의 id 를 가진 db 가 존재하며, 사용자가 입력한 비밀번호와 일치할 경우
		boolean ifStatement = null != checkMemberDto && bCryptEncoder.matches( memberDto.getPassword(), checkMemberDto.getPassword() );

		// 커맨드 객체 비밀번호 null 처리
		memberDto.setPassword(null);

		// 계정 정보 업데이트
		if ( ifStatement ) {
			// 일반 계정
			if ( "NORMAL".equals( checkMemberDto.getId_type() ) ) {
				String newPassword = request.getParameter("newPassword");
				
				// 새 비밀번호 값이 있을 경우에만 커맨드 객체에 암호화된 비밀번호를 넣는다
				if ( ! "".equals( newPassword ) ) {
					// 암호화
					memberDto.setPassword( bCryptEncoder.encode( newPassword ) );
				}
			}

			result = memberService.updateMember( memberDto );
		}

		// 업데이트 성공일 경우 세션 정보 업데이트
		if ( 1 == result ) {
			memberDto.setPassword(null);
			mav.addObject( "loginMemberDto", memberDto );
		}
		
		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );

		return mav;
	}

	// 회원정보 리스트 업데이트
	@RequestMapping( value = "member/updateList", method = RequestMethod.POST )
	public ModelAndView updateList(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav
	) throws Exception {
		// Command 객체 처리
		mav.addObject( "modelAndView", null );

		String memberList = request.getParameter("memberList");

		JSONParser 	jsonParser 	= new JSONParser();
		JSONArray 	jsonArr 	= (JSONArray) jsonParser.parse( memberList );

		int result = memberService.updateMemberList( jsonArr );

		mav.addObject( "result", result );
		mav.setViewName( "jsonView" );

		return mav;
	}


	// 회원정보 삭제
	/*@RequestMapping( value = "member/deleteMember", method = RequestMethod.POST )
	public ModelAndView updateStateMember(
		HttpServletRequest request, HttpServletResponse response, ModelAndView mav
	) {
		return mav;
	}*/
	
}