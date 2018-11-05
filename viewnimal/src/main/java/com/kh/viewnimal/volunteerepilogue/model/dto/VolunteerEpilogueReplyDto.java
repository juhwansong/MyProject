package com.kh.viewnimal.volunteerepilogue.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter @Setter @ToString
public class VolunteerEpilogueReplyDto implements Serializable{

	private static final long serialVersionUID = 1024L;
	
	private int no; //글번호
	private int reply_no; //댓글번호
	private String reply_content; //댓글 내용
	private String id; //댓글 작성자 아이디
	private String nickname; //댓글 작성자 닉네임
	private Date write_date; //댓글 작성시간
	private String write_date_format; //댓글 작성시간 포맷
	
	//리스트 검색용 필드
	private int current_page;
	private int count_list;
	private int start_row;
	private int end_row;
}
