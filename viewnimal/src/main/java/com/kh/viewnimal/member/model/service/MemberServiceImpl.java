package com.kh.viewnimal.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.member.model.dao.MemberDao;
import com.kh.viewnimal.member.model.dto.MemberDto;

@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	public MemberServiceImpl () {}

	// ---------------------------------------------------------------- SELECT
	// 회원 리스트 카운트
	public int selectListCount() {
		return memberDao.selectListCount();
	}

	// 회원 리스트 조회
	public ArrayList<MemberDto> selectList() {
		return (ArrayList<MemberDto>) memberDao.selectList();
	}

	// 로그인
	public MemberDto selectLogin( MemberDto memberDto ) {
		return memberDao.selectLogin( memberDto );
	}

	// 이메일 중복체크
	public int selectCheckId( String id ) {
		return memberDao.selectCheckId( id );
	}

	// 닉네임 중복체크
	public int selectCheckNickname( HashMap<String, String> nicknameMap ) {
		return memberDao.selectCheckNickname( nicknameMap );
	}

	// 개인정보 체크
	public MemberDto selectCheckInfo( MemberDto memberDto ) {
		return memberDao.selectCheckInfo( memberDto );
	}

	// ---------------------------------------------------------------- INSERT
	// 회원가입
	public int insertMember( MemberDto memberDto ) {
		return memberDao.insertMember( memberDto );
	}

	// ---------------------------------------------------------------- UPDATE
	// 회원정보 업데이트
	public int updateMember( MemberDto memberDto ) {
		return memberDao.updateMember( memberDto );
	}

	// 회원정보 업데이트
	public int updateMemberList( JSONArray jsonArr ) {
		int result = 1;

		for ( int i = 0, ilen = jsonArr.size(); i < ilen; i += 1 ) {
			JSONObject 	jsonObj 	= (JSONObject) jsonArr.get(i);
			MemberDto 	memberDto 	= new MemberDto();

			memberDto.setId 	( (String) jsonObj.get("id") );
			memberDto.setEmail 	( (String) jsonObj.get("email") );
			memberDto.setPhone 	( (String) jsonObj.get("phone") );
			memberDto.setState 	( (String) jsonObj.get("state") );

			result &= memberDao.updateMember( memberDto );
		}

		return result;
	}

	// 회원정보 삭제
	/*public int updateStateMember( String id ) {
		return memberDao.updateStateMember( id );
	}*/
	
}
