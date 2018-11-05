package com.kh.viewnimal.infoboard.model.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class InfoBoardReplyDto {

	private static final long serialVersionUID = 1012L;
	
	private int no;
	private int board_no;
	private String id;
	private Date write_date;
	private String reply_content;
	private int group_no;
	private int parent_no;
	private int reply_level;
	
	public InfoBoardReplyDto() {
		// TODO Auto-generated constructor stub
	}
	
	
}
