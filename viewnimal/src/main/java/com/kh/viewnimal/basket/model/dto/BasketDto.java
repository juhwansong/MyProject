package com.kh.viewnimal.basket.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class BasketDto implements Serializable {

	private static final long serialVersionUID = 1005L;

	private String product_id;		// 상품코드
	private int amount;				// 수량
	private String id;				// 사용자
	
	private String temporarilyAmount;	// 임시로 수량 정보 저장
	
	public BasketDto() {}
}
