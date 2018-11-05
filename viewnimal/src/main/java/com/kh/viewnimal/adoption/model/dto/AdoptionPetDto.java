package com.kh.viewnimal.adoption.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

public class AdoptionPetDto implements java.io.Serializable{

	private static final long serialVersionUID = 1002L;

	private String pet_id;
	private String name;
	private char gender;
	private double weight;
	private double age;
	private char neuter;
	private String breed;
	private String image;
	private String content;
	private char active;
	private String bdetail;
	private char channel_active;
	
	public AdoptionPetDto(){
		
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

	public String getBdetail() {
		return bdetail;
	}

	public void setBdetail(String bdetail) {
		this.bdetail = bdetail;
	}

	public char getChannel_active() {
		return channel_active;
	}

	public void setChannel_active(char channel_active) {
		this.channel_active = channel_active;
	}

}
