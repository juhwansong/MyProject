package com.kh.viewnimal.order.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.viewnimal.order.model.dto.OrderDto;
import com.kh.viewnimal.order.model.service.OrderService;
import com.kh.viewnimal.product.model.dto.ProductDto;

@Controller
public class OrderController {

	@Autowired
	private OrderService orderService;
	
	// 주문 완료
	@RequestMapping("payOrder")
	public ModelAndView insertOrder(ModelAndView mav, HttpServletRequest request, HttpServletResponse response,
								OrderDto orderDto) throws ParseException {
		
		System.out.println("orderDto = " + orderDto);
		
		ArrayList<OrderDto> list = new ArrayList<OrderDto>();
		
		String[] productId = orderDto.getProduct_id().split(",");
		String[] temporarilyAmount = orderDto.getTemporarilyAmount().split(",");
		String[] addressArray = orderDto.getAddress().split(",");
		String address = "(" + addressArray[0] + ")" + addressArray[1] + " " + addressArray[2];
		
		for(int i = 0; i < productId.length; i++) {
			OrderDto orDto = new OrderDto();
			orDto.setProduct_id(productId[i]);
			orDto.setAmount(Integer.parseInt(temporarilyAmount[i]));
			orDto.setId(orderDto.getId());
			orDto.setAddress(address);
			list.add(orDto);
		}
		
		String okAndFail = "fail";
		
		if(orderService.insertOrder(list) > 0) {
			okAndFail = "ok";
		}
		
		mav.addObject("okAndFail", okAndFail);
		mav.setViewName("jsonView");
		mav.addObject("pageMainType", "shop");
		
		return mav;
	}
	
}
