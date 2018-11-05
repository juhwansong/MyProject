package com.kh.viewnimal.streaming.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class StreamingReplyDto implements Serializable{

	private static final long serialVersionUID = 1020L;
	
	private int reply_no;				// 댓글 번호
	private int no;						// 글 번호
	private String id;					// 댓글 작성자 아이디
	private Date write_date;			// 작성 날짜
	private String reply_content;		// 댓글 내용
	
	private String nickname;			// 댓글 작성자 닉넴
	private String write_date_format;	// 댓글 작성시간 포멧
	
	
	private int current_page;
	private int count_list;
	private int start_row;
	private int end_row;
	
	public StreamingReplyDto() {
		// TODO Auto-generated constructor stub
	}
}
