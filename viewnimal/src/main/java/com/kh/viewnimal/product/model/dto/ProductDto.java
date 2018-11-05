package com.kh.viewnimal.product.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class ProductDto implements Serializable {

	private static final long serialVersionUID = 1017L;
	
	private String product_id;			// 상품코드
	private int price;					// 판매가
	private String name;				// 상품명
	private String production;			// 제조사
	private String origin;				// 원산지
	private String explain;				// 상품설명
	private String category;			// 분류
	private String main_img_name;		// 메인이미지
	private String detail_img_name;		// 상세이미지
	private Date reg_date;				// 등록일자
	
	private int amount;					// 장바구니 상품 수량
	
	private String temporarilyPrice;	// 임시로 가격 정보 저장
	private String temporarilyAmount;	// 임시로 수량 정보 저장
	
	private String order_no;			// 주문 번호
	private String address;				// 주소

	public ProductDto() {}
}
