package com.kh.viewnimal.lab.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class LabDto  implements Serializable{

	private static final long serialVersionUID = 1013L;

	private int no;                     // 글번호
	private String title;				// 제목
	private Date write_date;			// 작성일
	private String content;				// 내용
	private String content_tag;			// 태그포함 내용
	private String thumbnail;			// 썸네일
	private String lab_tag;				// 태그
	private String id;					// 아이디
	
	
	private String nickname;			// 닉네임
	
	public LabDto() {
	
	}
	
}
