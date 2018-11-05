package com.kh.viewnimal.donate.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.json.simple.JSONArray;

import com.kh.viewnimal.donate.model.dto.DonateDto;

public interface DonateService {

	// ---------------------------------------------------------------- SELECT
	// 후원내역 카운트
	public int selectListCount( HashMap<String, Object> searchMap );
	
	// 후원내역 조회
	public ArrayList<DonateDto> selectList( HashMap<String, Object> searchMap );

	// ---------------------------------------------------------------- INSERT
	// 후원내역 등록
	public int insertDonate( JSONArray jsonArr );

	// ---------------------------------------------------------------- UPDATE
	// 후원내역 업데이트
	public int updateDonate( JSONArray jsonArr );

	// ---------------------------------------------------------------- DELETE
	// 후원내역 삭제
	public int deleteDonate( JSONArray jsonArr );

}
