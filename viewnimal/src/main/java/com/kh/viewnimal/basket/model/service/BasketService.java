package com.kh.viewnimal.basket.model.service;

import java.util.ArrayList;

import com.kh.viewnimal.basket.model.dto.BasketDto;

public interface BasketService {

	int insertCartBasket(BasketDto basketDto);
	
	int deleteBasket(BasketDto basketDto);
	
	ArrayList<BasketDto> selectAllProductOrder(String id);
	
	ArrayList<BasketDto> selectProductOrder(BasketDto basketDto);

	int deleteOneBasket(BasketDto basketDto);

	int deleteAllBasket(String id);

	int deleteCheckBasket(ArrayList<String> proIdList, String id);

	int completeBasketDelete(ArrayList<BasketDto> list, String id);

	int updateBasketCount(BasketDto basketDto);
}
