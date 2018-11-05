package com.kh.viewnimal.infoboard.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class InfoBoardDto implements Serializable{

	private static final long serialVersionUID = 1011L;
	
	private int no;
	private String id;
	private Date write_date;
	private String category;
	private String title;
	private String content;
	private String content_tag;
	private int read_count;
	private int group_no;
	private int parent_no;
	private int group_order;
	private int board_level;
	private String type;
	private String active;
	
	public InfoBoardDto() {
		// TODO Auto-generated constructor stub
	}
	
}
