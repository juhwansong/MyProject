package com.kh.viewnimal.lab.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.web.multipart.MultipartFile;

import com.kh.viewnimal.lab.model.dto.LabDto;

public interface LabService {

	// 연구소 리스트
	ArrayList<LabDto> selectLabList(HashMap<String, Integer> paging);
	
	// 연구소 상세페이지
	LabDto selectLabDetail(int no);
	
	// 연구소 글 작성
	int insertLab(LabDto labDto);
	
	// 연구소 글 수정
	int updateLab(LabDto lab);
	
	// 연구소 글 삭제
	int deleteLab(int no);
	
	// 연구소 글 검색
	ArrayList<LabDto> selectSearchLab(HashMap<String, String> search);
	
	// 연구소 게시글 총 갯수
	int selectCountLab();
	
	// 연구소 검색 결과 갯수
	int selectCountSearchLab(HashMap<String, String> searchCount);

}
