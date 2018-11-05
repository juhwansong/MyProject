package com.kh.viewnimal.basket.model.service;

import java.util.ArrayList;
import java.util.prefs.BackingStoreException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.basket.model.dao.BasketDao;
import com.kh.viewnimal.basket.model.dto.BasketDto;

@Service("basketService")
public class BasketServiceImpl implements BasketService {

	@Autowired
	private BasketDao basketDao;

	public BasketServiceImpl() {}
	
	@Override
	public int insertCartBasket(BasketDto basketDto) {
		
		return basketDao.insertCartBasket(basketDto);
	}

	@Override
	public int deleteOneBasket(BasketDto basketDto) {
		
		return basketDao.deleteOneBasket(basketDto);
	}
	
	@Override
	public int deleteAllBasket(String id) {
		
		return basketDao.deleteAllBasket(id);
	}
	
	@Override
	public int deleteCheckBasket(ArrayList<String> proIdList, String id) {
		
		return basketDao.deleteCheckBasket(proIdList, id);
	}
	
	@Override
	public int completeBasketDelete(ArrayList<BasketDto> list, String id) {
		
		return basketDao.completeBasketDelete(list, id);
	}
	
	@Override
	public int updateBasketCount(BasketDto basketDto) {
		
		return basketDao.updateBasketCount(basketDto);
	}
	
	@Override
	public int deleteBasket(BasketDto basketDto) {
		
		return 0;
	}

	@Override
	public ArrayList<BasketDto> selectAllProductOrder(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<BasketDto> selectProductOrder(BasketDto basketDto) {
		// TODO Auto-generated method stub
		return null;
	}
}
