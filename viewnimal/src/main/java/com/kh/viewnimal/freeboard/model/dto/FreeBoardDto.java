package com.kh.viewnimal.freeboard.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class FreeBoardDto implements Serializable {

	private static final long serialVersionUID = 1009L;
	
	private int no;						//글번호
	private String id; 					//작성자
	private Date write_date; 			//작성일
	private String category; 			//말머리
	private String title; 				//제목
	private String content; 			//내용텍스트
	private String content_tag; 		//내용태그
	private int read_count; 			//조회수
	private int group_no; 				//그룹번호
	private int parent_no; 				//부모번호
	private int group_order;			//그룹내순서
	private int board_level;			//글레벨
	private String type;				//게시판 타입
	private String active;				//공개여부
	private String nickname;			//닉네임
}
