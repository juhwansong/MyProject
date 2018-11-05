package com.kh.viewnimal.order.model.service;

import java.util.ArrayList;

import com.kh.viewnimal.order.model.dto.OrderDto;

public interface OrderService {

	int insertOrder(ArrayList<OrderDto> list);
}
