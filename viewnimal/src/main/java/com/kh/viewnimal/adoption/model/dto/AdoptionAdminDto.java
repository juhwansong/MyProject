package com.kh.viewnimal.adoption.model.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class AdoptionAdminDto implements java.io.Serializable {

	private static final long serialVersionUID = 1006L;

	private	int no;
	private String id;
	private String username;
	private String pet_id;
	private String name;
	private String phone;
	private String request_date;
	private String state;
	private char review;
	
	public AdoptionAdminDto(){
		
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getusername() {
		return username;
	}

	public void setusername(String username) {
		this.username = username;
	}

	public String getPet_id() {
		return pet_id;
	}

	public void setPet_id(String pet_id) {
		this.pet_id = pet_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRequest_date() {
		return request_date;
	}

	public void setRequest_date(String request_date) {
		this.request_date = request_date;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public char getReview() {
		return review;
	}

	public void setReview(char review) {
		this.review = review;
	}
	
	
}
