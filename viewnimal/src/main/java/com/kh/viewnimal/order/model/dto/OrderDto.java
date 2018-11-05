package com.kh.viewnimal.order.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class OrderDto implements Serializable {

	private static final long serialVersionUID = 1016L;
	
	private String order_no;		// 주문번호
	private String product_id;		// 상품코드
	private String id;				// 아이디
	private int amount;				// 수량
	private Date order_date;		// 주문날짜
	private String order_state;		//주문상태
	private String ship_state;		//배송상태
	private String address;			// 배송주소
	
	private String temporarilyAmount;	// 임시로 수량 정보 저장
	
	public OrderDto() {}
}
