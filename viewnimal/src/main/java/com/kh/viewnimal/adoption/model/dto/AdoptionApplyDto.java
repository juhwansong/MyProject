package com.kh.viewnimal.adoption.model.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class AdoptionApplyDto implements java.io.Serializable{

	private static final long serialVersionUID = 1001L;
	
	private int no;
	private String id;
	private String pet_id;
	private Date request_date;
	private String state;
	private String content;
	private String phone;
	private String username;
	
	public AdoptionApplyDto(){
		
	}
}
