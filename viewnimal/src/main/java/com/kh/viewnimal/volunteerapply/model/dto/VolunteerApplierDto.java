package com.kh.viewnimal.volunteerapply.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class VolunteerApplierDto implements Serializable{

	private static final long serialVersionUID = 1021L;
	
	private String volunteer_date; //봉사날짜
	private String id; //신청자 아이디
	private String email; //신청자 이메일
	private String nickname; //신청자 닉네임
	private String phone; //신청자 휴대폰 번호
	private Date apply_date; //신청 날짜
	private String join_state; //해당 봉사 참가 상태
	private String epilogue_write_state; //후기글 작성 여부
	private String apply_date_format; //신청 날짜 포맷
	private String no; //신청자 순번 표시용
	
	// 페이지네이션 관련 필드
	private int count_list;
	private int current_page;
	private int start_row;
	private int end_row;
	private int applier_count;
	private int start_page;
	private int max_page;
	private int end_page;
}
