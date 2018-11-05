package com.kh.viewnimal.product.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.basket.model.dto.BasketDto;
import com.kh.viewnimal.product.model.dto.ProductDto;

@Repository("productDao")
public class ProductDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ProductDao() {}
	
	public int selectGetListCount(String category) {
		System.out.println("DAO category = " + category);
		return sqlSession.selectOne("productMapper.getListCount", category);
	}
	
	public ArrayList<ProductDto> selectProductAllList(int currentPage, int limit, String category, String productArrayList) {
		
		HashMap<String, Object> pageNo = new HashMap<String, Object>();
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		pageNo.put("startRow", startRow);
		pageNo.put("endRow", endRow);
		pageNo.put("category", category);
		pageNo.put("productArrayList", productArrayList);
		
		return (ArrayList) sqlSession.selectList("productMapper.selectProductList", pageNo);
	}

	public ArrayList<ProductDto> selectCategoryProductList(ProductDto productDto) {
		
		return null;
	}

	public ProductDto selectMoveProductDetailPage(String productId) {
		
		return sqlSession.selectOne("productMapper.selectProductDetail", productId);
	}

	public ArrayList<ProductDto> selectBasketPageMove(String id) {
		
		return (ArrayList) sqlSession.selectList("productMapper.selectBasketList", id);
	}
	
	public ArrayList<ProductDto> allOrderPageMove(ArrayList<String> list, String id) {
		HashMap<String, Object> productBasketSelect = new HashMap<String, Object>();
		
		productBasketSelect.put("list", list);
		productBasketSelect.put("id", id);
		
		return (ArrayList) sqlSession.selectList("productMapper.allOrder", productBasketSelect);
	}

	public ArrayList<ProductDto> selectPagePayComplete(ArrayList<ProductDto> productList, String id) {
		HashMap<String, Object> productSelect = new HashMap<String, Object>();
		
		productSelect.put("list", productList);
		productSelect.put("id", id);
		
		
		return (ArrayList) sqlSession.selectList("productMapper.selectComplete", productSelect);
	}
	
	public ArrayList<ProductDto> selectBuyNow(ProductDto productDto) {
		
		return (ArrayList) sqlSession.selectList("productMapper.selectNow", productDto);
	}
	
	public ProductDto selectMoveOrderOnePage(String product_id) {
		
		return null;
	}

	public int insertProduct(ProductDto productDto) {
		
		return 0;
	}

	public int updateProduct(ProductDto productDto) {
		
		return 0;
	}

	public int deleteProduct(ProductDto productDto) {
		
		return 0;
	}

	public ArrayList<ProductDto> selectSearchProduct(String searchWord) {
		
		return null;
	}
}
