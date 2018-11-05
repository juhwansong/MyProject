package com.kh.viewnimal.order.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.viewnimal.order.model.dao.OrderDao;
import com.kh.viewnimal.order.model.dto.OrderDto;

@Service("orderService")
public class OrderServiceImpl implements OrderService {

	public OrderServiceImpl() {}
	
	@Autowired
	private OrderDao orderDao;

	@Override
	public int insertOrder(ArrayList<OrderDto> list) {
		
		return orderDao.insertOrder(list);
	}
}
