package com.kh.viewnimal.volunteerapply.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class VolunteerApplyDto implements Serializable {
	
	private static final long serialVersionUID = 1022L;
	
	private String volunteer_date; //봉사날짜
	private String limit_date; //모집기한
	private String volunteer_area; //봉사지역
	private String id; //작성자 아이디
	private String nickname; //작성자 닉네임
	private String phone; //작성자 휴대폰 번호
	private Date write_date; //작성날짜 (insert 시 필요한 작성날짜)
	private String write_date_format; //작성날짜(select 시 필요한 작성날짜) : 객체로 ajax통신 시 date타입 전송 불가능하기 때문에
	private String title; //글제목
	private String content; //텍스트 내용
	private String content_tag; //태그 포함 내용
	private String thumbnail; //썸네일
	private int apply_max_count; //최대 모집 인원
	private int apply_count; //현재 신청한 인원(쿼리문에서 계산 후 변수 선언 시 별칭 이름 apply_count로 동일하게)
	private String apply_state; //모집상태
	private String url; //해당 게시글 클릭했을 시 해당 url로 디테일 뷰
	
	private int insertImgCount; //이미지 지우기 용 카운트 변수
}
