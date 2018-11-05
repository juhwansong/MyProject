package com.kh.viewnimal.adoption.model.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class AdoptionPetReviewDto implements java.io.Serializable{
	
	private static final long serialVersionUID = 1005L;
	
	private int no;
	private String pet_id;
	private Date write_date;
	private int count;
	private String id;
	private String address;
	private String image; //리뷰 이미지
	private String content; //리뷰 내용
	private char active;
	
	//private String pet_id;
	private String name;
	private char gender;
	private double weight;
	private double age;
	private char neuter;
	private String breed;
	//private String image;
	//private String content;
	private String bdetail;
	//private char active;
	
	public AdoptionPetReviewDto(){
		
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

	public Date getWrite_date() {
		return write_date;
	}

	public void setWrite_date(Date write_date) {
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public char getGender() {
		return gender;
	}

	public void setGender(char gender) {
		this.gender = gender;
	}

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	public double getAge() {
		return age;
	}

	public void setAge(double age) {
		this.age = age;
	}

	public char getNeuter() {
		return neuter;
	}

	public void setNeuter(char neuter) {
		this.neuter = neuter;
	}

	public String getBreed() {
		return breed;
	}

	public void setBreed(String breed) {
		this.breed = breed;
	}

	public String getBdetail() {
		return bdetail;
	}

	public void setBdetail(String bdetail) {
		this.bdetail = bdetail;
	}
	

}
