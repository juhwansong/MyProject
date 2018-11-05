package com.kh.viewnimal.lab.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kh.viewnimal.lab.model.dto.LabDto;

@Repository("labDao")
public class LabDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	public LabDao() {
	}
	
	// 연구소 리스트
	public ArrayList<LabDto> selectLabList(HashMap<String, Integer> paging){
		
		return (ArrayList)sqlSession.selectList("labMapper.selectLabList", paging);
	}
	
	// 연구소 상세페이지
	public LabDto selectLabDetail(int no) {
		
		return (LabDto)sqlSession.selectOne("labMapper.selectLab", no);
	}
	
	// 연구소 글 작성
	public int insertLab(LabDto labDto) {
		return sqlSession.insert("labMapper.insertLab", labDto);
	}
	
	// 연구소 글 수정
	public int updateLab(LabDto lab) {
		return sqlSession.update("labMapper.updateLab", lab);
	}
	
	// 연구소 글 삭제
	public int deleteLab(int no) {
		
		int test = (int) sqlSession.delete("labMapper.deleteLab", no);
		System.out.println(">>>>>>>>>>>>>test : " + test);
		return test;
	}
	
	// 연구소 글 검색
	public ArrayList<LabDto> selectSearchLab(HashMap<String, String> search) {
		// TODO Auto-generated method stub
		return null;
	}
	
	// 연구소 게시글 총 갯수
	public int selectCountLab() {
		return (int)sqlSession.selectOne("labMapper.selectCountLab");
	}
	
	// 연구소 검색 결과 갯수
	public int selectCountSearchLab(HashMap<String, String> searchCount) {
		// TODO Auto-generated method stub
		return 0;
	}

}
