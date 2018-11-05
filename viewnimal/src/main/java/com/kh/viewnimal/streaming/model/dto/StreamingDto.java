package com.kh.viewnimal.streaming.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class StreamingDto implements Serializable{

	private static final long serialVersionUID = 1019L;
	
	private int no;
	private String title;
	private String content;
	private String content_tag;
	private Date write_date;
	private String id;
	private String thumbnail;
	private String active;
	
	private String reply_count;
	
	
	//리스트 검색용 필드
	private int current_page;
	private int count_list;
	private int start_row;
	private int end_row;
	
	public StreamingDto() {
		// TODO Auto-generated constructor stub
	}
}
