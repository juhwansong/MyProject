package com.kh.viewnimal.product.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.basket.model.dto.BasketDto;
import com.kh.viewnimal.product.model.dao.ProductDao;
import com.kh.viewnimal.product.model.dto.ProductDto;

@Service("productService")
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDao productDao;
	
	public ProductServiceImpl() {}

	@Override
	public int selectGetListCount(String category) {
		
		return productDao.selectGetListCount(category);
	}
	
	@Override
	public ArrayList<ProductDto> selectProductAllList(int currentPage, int limit, String category, String productArrayList) {
		
		return productDao.selectProductAllList(currentPage, limit, category, productArrayList);
	}

	@Override
	public ArrayList<ProductDto> selectCategoryProductList(ProductDto productDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductDto selectMoveProductDetailPage(String productId) {
		
		return productDao.selectMoveProductDetailPage(productId);
	}

	@Override
	public ArrayList<ProductDto> selectBasketPageMove(String id) {
		
		return productDao.selectBasketPageMove(id);
	}
	
	@Override
	public ArrayList<ProductDto> allOrderPageMove(ArrayList<String> list, String id) {
		
		return productDao.allOrderPageMove(list, id);
	}
	
	@Override
	public ArrayList<ProductDto> selectPagePayComplete(ArrayList<ProductDto> productList, String id) {
		
		return productDao.selectPagePayComplete(productList, id);
	}
	
	@Override
	public ArrayList<ProductDto> selectBuyNow(ProductDto productDto) {
		
		return productDao.selectBuyNow(productDto);
	}
	
	@Override
	public ArrayList<ProductDto> selectMoveBasketListPage(BasketDto basketDto) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ProductDto selectMoveOrderOnePage(String product_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertProduct(ProductDto productDto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateProduct(ProductDto productDto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteProduct(ProductDto productDto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<ProductDto> selectSearchProduct(String searchWord) {
		// TODO Auto-generated method stub
		return null;
	}
}
