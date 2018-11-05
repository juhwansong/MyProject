package com.kh.viewnimal.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.json.simple.JSONArray;

import com.kh.viewnimal.member.model.dto.MemberDto;

public interface MemberService {

	// ---------------------------------------------------------------- SELECT
	// 회원 리스트 카운트
	public abstract int selectListCount();

	// 회원 리스트 조회
	public abstract ArrayList<MemberDto> selectList();

	// 로그인
	public abstract MemberDto selectLogin( MemberDto memberDto );

	// 이메일 중복체크
	public abstract int selectCheckId( String id );

	// 닉네임 중복체크
	public abstract int selectCheckNickname( HashMap<String, String> nicknameMap );

	// 개인정보 체크
	public abstract MemberDto selectCheckInfo( MemberDto memberDto );

	// ---------------------------------------------------------------- INSERT
	// 회원가입
	public abstract int insertMember( MemberDto memberDto );

	// ---------------------------------------------------------------- UPDATE
	// 회원정보 업데이트
	public abstract int updateMember( MemberDto memberDto );

	// 회원정보 리스트 업데이트
	public abstract int updateMemberList( JSONArray jsonArr );

	// 회원정보 삭제
	// public abstract int updateStateMember( String id );

}
