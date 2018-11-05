package com.kh.viewnimal.donate.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.donate.model.dto.DonateDto;
import com.kh.viewnimal.member.model.dto.MemberDto;

@Repository("donateDao")
public class DonateDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public DonateDao() {}

	// ---------------------------------------------------------------- SELECT
	// 후원내역 카운트
	public int selectListCount( HashMap<String, Object> searchMap ) {
		return (int) sqlSession.selectOne( "donateMapper.selectListCount", searchMap );
	}
	
	// 후원내역 조회
	public List<DonateDto> selectList( HashMap<String, Object> searchMap ) {
		return sqlSession.selectList( "donateMapper.selectList", searchMap );
	}

	// ---------------------------------------------------------------- INSERT
	// 후원내역 등록
	public int insertDonate( DonateDto donateDto ) {
		return sqlSession.insert( "donateMapper.insertDonate", donateDto );
	}

	// ---------------------------------------------------------------- UPDATE
	// 후원내역 업데이트
	public int updateDonate( DonateDto donateDto ) {
		return sqlSession.update( "donateMapper.updateDonate", donateDto );
	}

	// ---------------------------------------------------------------- DELETE
	// 후원내역 삭제
	public int deleteDonate( DonateDto donateDto ) {
		return sqlSession.delete( "donateMapper.deleteDonate", donateDto );
	}

}