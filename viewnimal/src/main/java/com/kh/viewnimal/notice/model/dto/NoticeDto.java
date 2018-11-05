package com.kh.viewnimal.notice.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class NoticeDto implements java.io.Serializable{
	private static final long serialVersionUID = 1015L;
	
	private int no;						//글번호
	private String title;				//제목
	private String content;				//내용
	private String id;					//작성자
	private int read_count;				//조회수
//	private Date write_date;			//작성일
	private String write_date;
	private String original_file_name;	//원본파일명
	private String rename_file_name;	//수정된파일명
	private String active;				//공개여부
	
	private String nickname;			//닉네임
	
	private int pre_no;					//이전 글번호
	private String pre_title;			//이전 글 제목
//	private Date pre_write_date;		//이전 글 작성일
	private String pre_write_date;
	private int next_no;				//다음 글번호
	private String next_title;			//다음 글 제목
//	private Date next_write_date;		//다음 글 작성일
	private String next_write_date;
	
	public NoticeDto(){}

}
