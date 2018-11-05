package com.kh.viewnimal.product.model.service;

import java.util.ArrayList;

import com.kh.viewnimal.basket.model.dto.BasketDto;
import com.kh.viewnimal.product.model.dto.ProductDto;

public interface ProductService {

	int selectGetListCount(String category);
	
	ArrayList<ProductDto> selectProductAllList(int currentPage, int limit, String category, String productArrayList);
	
	ArrayList<ProductDto> selectCategoryProductList(ProductDto productDto);
	
	ProductDto selectMoveProductDetailPage(String productId);
	
	ArrayList<ProductDto> selectMoveBasketListPage(BasketDto basketDto);
	
	ProductDto selectMoveOrderOnePage(String product_id);
	
	int insertProduct(ProductDto productDto);
	
	int updateProduct(ProductDto productDto);
	
	int deleteProduct(ProductDto productDto);
	
	ArrayList<ProductDto> selectSearchProduct(String searchWord);

	ArrayList<ProductDto> selectBasketPageMove(String id);

	ArrayList<ProductDto> allOrderPageMove(ArrayList<String> list, String id);

	ArrayList<ProductDto> selectPagePayComplete(ArrayList<ProductDto> productList, String id);

	ArrayList<ProductDto> selectBuyNow(ProductDto productDto);
}
