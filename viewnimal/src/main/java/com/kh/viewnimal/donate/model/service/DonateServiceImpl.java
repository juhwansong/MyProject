package com.kh.viewnimal.donate.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.donate.model.dao.DonateDao;
import com.kh.viewnimal.donate.model.dto.DonateDto;

@Service("donateService")
public class DonateServiceImpl implements DonateService {

	@Autowired
	private DonateDao donateDao;

	public DonateServiceImpl() {}

	// ---------------------------------------------------------------- SELECT
	// 후원내역 카운트
	public int selectListCount( HashMap<String, Object> searchMap ) {
		return donateDao.selectListCount( searchMap );
	}
	
	// 후원내역 조회
	public ArrayList<DonateDto> selectList( HashMap<String, Object> searchMap ) {
		return (ArrayList<DonateDto>) donateDao.selectList( searchMap );
	}

	// ---------------------------------------------------------------- INSERT
	// 후원내역 등록
	public int insertDonate( JSONArray jsonArr ) {
		int result = 1;

		for ( int i = 0, ilen = jsonArr.size(); i < ilen; i += 1 ) {
			JSONObject 		jsonObj 	= (JSONObject) jsonArr.get(i);
			DonateDto 		donateDto 	= new DonateDto();
			java.sql.Date 	sqlDate 	= java.sql.Date.valueOf( (String) jsonObj.get("donate_date") );

			donateDto.setWriter 		( (String) jsonObj.get("writer") );
			donateDto.setAccount_no 	( (String) jsonObj.get("account_no") );
			donateDto.setAccount_host 	( (String) jsonObj.get("account_host") );
			donateDto.setBank 			( (String) jsonObj.get("bank") );
			donateDto.setDonation 		( ((Long) jsonObj.get("donation")).intValue() );
			donateDto.setDonate_date 	( sqlDate );
			donateDto.setSupporter_id 	( (String) jsonObj.get("supporter_id") );

			result &= donateDao.insertDonate( donateDto );
		}

		return result;
	}

	// ---------------------------------------------------------------- UPDATE
	// 후원내역 업데이트
	public int updateDonate( JSONArray jsonArr ) {
		int result = 1;

		for ( int i = 0, ilen = jsonArr.size(); i < ilen; i += 1 ) {
			JSONObject 		jsonObj 	= (JSONObject) jsonArr.get(i);
			DonateDto 		donateDto 	= new DonateDto();
			java.sql.Date 	sqlDate 	= java.sql.Date.valueOf( (String) jsonObj.get("donate_date") );

			donateDto.setNo 			( ((Long) jsonObj.get("no")).intValue() );
			donateDto.setAccount_no 	( (String) jsonObj.get("account_no") );
			donateDto.setAccount_host 	( (String) jsonObj.get("account_host") );
			donateDto.setBank 			( (String) jsonObj.get("bank") );
			donateDto.setDonation 		( ((Long) jsonObj.get("donation")).intValue() );
			donateDto.setDonate_date 	( sqlDate );
			donateDto.setSupporter_id 	( (String) jsonObj.get("supporter_id") );

			result &= donateDao.updateDonate( donateDto );
		}

		return result;
	}

	// ---------------------------------------------------------------- DELETE
	// 후원내역 삭제
	public int deleteDonate( JSONArray jsonArr ) {
		int result = 1;

		for ( int i = 0, ilen = jsonArr.size(); i < ilen; i += 1 ) {
			JSONObject 	jsonObj 	= (JSONObject) jsonArr.get(i);
			DonateDto 	donateDto 	= new DonateDto();

			donateDto.setNo( ((Long) jsonObj.get("no")).intValue() );

			result &= donateDao.deleteDonate( donateDto );
		}

		return result;
	}

}
