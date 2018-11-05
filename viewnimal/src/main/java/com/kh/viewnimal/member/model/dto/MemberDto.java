package com.kh.viewnimal.member.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class MemberDto implements java.io.Serializable {
	private static final long serialVersionUID = 1014L;

	private int 	rnum; 		// ROWNUM
	private String 	id; 		// 아이디
	private String 	password; 	// 비밀번호
	private String 	nickname; 	// 닉네임
	private String 	email; 		// 이메일
	private String 	phone; 		// 번호
	private String 	type; 		// 회원타입
	private String 	state; 		// 계정상태
	private String 	id_type; 	// 계정타입
	private String 	token; 		// 토큰

	public MemberDto() {}
}
