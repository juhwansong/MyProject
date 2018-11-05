package com.kh.viewnimal.volunteerepilogue.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class VolunteerEpilogueDto implements Serializable {

	private static final long serialVersionUID = 1023L;
	
	private int no; //글번호
	private String volunteer_date; //봉사날짜
	private String volunteer_area; //봉사지역
	private String id; //작성자 아이디
	private String nickname; //작성자 닉네임
	private Date write_date; //작성 날짜
	private String write_date_format; //작성 날짜 포맷
	private String title; //제목
	private String content; //텍스트 내용
	private String content_tag; //태그 포함 내용
	private int read_count; //조회수
	private String thumbnail; //썸네일
	private String active; //해당 글 공개여부(유저가 삭제 시)
	private String reply_count; //댓글 수(쿼리문에서 계산 후 변수 선언 시 별칭 이름 reply_count로 동일하게)
	
	private int insertImgCount;
	
	//리스트 검색용 필드
	private int current_page;
	private String date_keword;
	private String myboard_search;
	private int count_list;
	private int start_row;
	private int end_row;
}
