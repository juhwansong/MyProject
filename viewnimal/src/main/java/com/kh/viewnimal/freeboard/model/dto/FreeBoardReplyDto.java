package com.kh.viewnimal.freeboard.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class FreeBoardReplyDto implements Serializable {

	private static final long serialVersionUID =	 1010L;
	
	private int no;
	private int board_no;
	private String id;
	private Date write_date;
	private String reply_content;
	private int group_no;
	private int parent_no;
	private int reply_level;
	private String type;
	private String nickname;
}
