package com.kh.viewnimal.basket.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.basket.model.dto.BasketDto;

@Repository("basketDao")
public class BasketDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public BasketDao() {}
	
	public int insertCartBasket(BasketDto basketDto) {
		System.out.println("insertCartBasket");
		return sqlSession.insert("basketMapper.insertBasket", basketDto);
	}
	
	public int deleteOneBasket(BasketDto basketDto) {
		
		return sqlSession.delete("basketMapper.deleteOne", basketDto);
	}
	
	public int deleteAllBasket(String id) {
		
		return sqlSession.delete("basketMapper.deleteAll", id);
	}
	
	public int deleteCheckBasket(ArrayList<String> proIdList, String id) {
		
		HashMap<String, Object> basketMap = new HashMap<String, Object>();
		basketMap.put("list", proIdList);
		basketMap.put("id", id);
		System.out.println("basketMap = " + basketMap);
		return sqlSession.delete("basketMapper.deleteCheck", basketMap);
	}
	
	public int completeBasketDelete(ArrayList<BasketDto> list, String id) {
		
		HashMap<String, Object> basketMap = new HashMap<String, Object>();
		basketMap.put("list", list);
		basketMap.put("id", id);
		
		return sqlSession.delete("basketMapper.deletePayment", basketMap);
	}
	
	public int updateBasketCount(BasketDto basketDto) {
		
		return sqlSession.update("basketMapper.countUpdate", basketDto);
	}
	
	public int deleteBasket(BasketDto basketDto) {
		
		return 0;
	}
	
	public ArrayList<BasketDto> selectAllProductOrder(String id) {
		
		return null;
	}
	
	public ArrayList<BasketDto> selectProductOrder(BasketDto basketDto) {
		
		return null;
	}
}
