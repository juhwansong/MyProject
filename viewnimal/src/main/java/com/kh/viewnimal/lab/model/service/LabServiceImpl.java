package com.kh.viewnimal.lab.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kh.viewnimal.lab.model.dao.LabDao;
import com.kh.viewnimal.lab.model.dto.LabDto;

@Service("labService")
public class LabServiceImpl implements LabService{

	@Autowired
	private LabDao labDao;
	
	public LabServiceImpl() {}
	
	// 연구소 리스트
	@Override
	public ArrayList<LabDto> selectLabList(HashMap<String, Integer> paging){
		
		return labDao.selectLabList(paging);
	}
	
	// 연구소 상세페이지
	@Override
	public LabDto selectLabDetail(int no) {
		return labDao.selectLabDetail(no);
	}
	
	// 연구소 글 작성
	@Override
	public int insertLab(LabDto labDto) {
		return labDao.insertLab(labDto);
	}
	
	// 연구소 글 수정
	@Override
	public int updateLab(LabDto lab) {
		return labDao.updateLab(lab);
	}
	
	// 연구소 글 삭제
	@Override
	public int deleteLab(int no) {
		int test2 = labDao.deleteLab(no);
		System.out.println(">>>>>>>> lm : " + test2);
		return test2;
	}
	
	// 연구소 글 검색
	@Override
	public ArrayList<LabDto> selectSearchLab(HashMap<String, String> search) {
		// TODO Auto-generated method stub
		return labDao.selectSearchLab(search);
	}
	
	// 연구소 게시글 총 갯수
	@Override
	public int selectCountLab() {
		return labDao.selectCountLab();
	}
	
	// 연구소 검색 결과 갯수
	@Override
	public int selectCountSearchLab(HashMap<String, String> searchCount) {
		// TODO Auto-generated method stub
		return labDao.selectCountSearchLab(searchCount);
	}

	
}
