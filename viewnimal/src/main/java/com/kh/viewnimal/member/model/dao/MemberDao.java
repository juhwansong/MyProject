package com.kh.viewnimal.member.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.member.model.dto.MemberDto;

@Repository("memberDao")
public class MemberDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public MemberDao() {}

	// ---------------------------------------------------------------- SELECT
	// 회원 리스트 카운트
	public int selectListCount() {
		return sqlSession.selectOne( "memberMapper.selectListCount" );
	}

	// 회원 리스트 조회
	public List<MemberDto> selectList() {
		return sqlSession.selectList( "memberMapper.selectList" );
	}

	// 로그인
	public MemberDto selectLogin( MemberDto memberDto ) {
		return (MemberDto) sqlSession.selectOne( "memberMapper.selectLogin", memberDto );
	}

	// 이메일 중복체크
	public int selectCheckId( String id ) {
		return (int) sqlSession.selectOne( "memberMapper.selectCheckId", id );
	}

	// 닉네임 중복체크
	public int selectCheckNickname( HashMap<String, String> nicknameMap ) {
		return (int) sqlSession.selectOne( "memberMapper.selectCheckNickname", nicknameMap );
	}

	// 개인정보 체크
	public MemberDto selectCheckInfo( MemberDto memberDto ) {
		return (MemberDto) sqlSession.selectOne( "memberMapper.selectCheckInfo", memberDto );
	}

	// ---------------------------------------------------------------- INSERT
	// 회원가입
	public int insertMember( MemberDto memberDto ) {
		return sqlSession.insert( "memberMapper.insertMember", memberDto );
	}

	// ---------------------------------------------------------------- UPDATE
	// 회원정보 업데이트
	public int updateMember( MemberDto memberDto ) {
		return sqlSession.update( "memberMapper.updateMember", memberDto );
	}

	// 회원정보 리스트 업데이트
	public int updateMemberList( MemberDto memberDto ) {
		return sqlSession.update( "memberMapper.updateMember", memberDto );
	}

	// 회원정보 삭제
	/*public int updateStateMember( String id ) {
		return sqlSession.update( "memberMapper.updateStateMember", id );
	}*/

}
