package com.kh.viewnimal.adoption.model.dto;

public class AdoptionReviewDto implements java.io.Serializable{

	private static final long serialVersionUID = 1003L;

	private int no;
	private String pet_id;
	private String write_date;
	private int count;
	private String id;
	private String name;
	private String address;
	private String image;
	private String content;
	private char active;
	private String username;
	
	public AdoptionReviewDto(){
		
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getPet_id() {
		return pet_id;
	}

	public void setPet_id(String pet_id) {
		this.pet_id = pet_id;
	}

	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public char getActive() {
		return active;
	}

	public void setActive(char active) {
		this.active = active;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
		
}
