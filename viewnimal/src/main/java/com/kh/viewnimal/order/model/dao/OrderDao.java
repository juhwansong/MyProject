package com.kh.viewnimal.order.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.viewnimal.order.model.dto.OrderDto;

@Repository("orderDao")
public class OrderDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public OrderDao() {}
	
	public int insertOrder(ArrayList<OrderDto> list) {
		
		return sqlSession.insert("orderMapper.orderInsertComplete", list);
	}
}
