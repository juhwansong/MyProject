package com.kh.viewnimal.channel.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class ChannelDto implements Serializable{
	
	private static final long serialVersionUID = 1006L;
	
	private int no; 
	private String title;
	private Date write_date;
	private String content;
	private String content_tag;
	private String thumbnail;
	private int read_count;
	private String active;
	private String animal_id;
	private String id;
	
	//펫정보
	private String name;
	private	String image;
	private String pet_content;
	
	//페이징처리
	private int startRow;
	private int endRow;
	
}
