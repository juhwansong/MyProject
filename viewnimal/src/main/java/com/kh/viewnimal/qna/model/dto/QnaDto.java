package com.kh.viewnimal.qna.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class QnaDto implements java.io.Serializable{
	private static final long serialVersionUID = 1018L;
	
	private int no;					//글번호
	private String category;		//문의 종류
	private String title;			//제목
	private String content;			//내용
	private String id;				//작성자
//	private Date write_date;		//작성일
	private String write_date;
	private String answer_content;	//답변내용
	private String answer_id;		//답변작성자
//	private Date answer_write_date;	//답변작성일
	private String answer_write_date;
	private String state;			//답변처리상태
	private String active;			//공개여부
	
	private String nickname;		//작성자 닉네임
	private String answer_nickname;	//답변자 닉네임
	
	public QnaDto(){}

}
