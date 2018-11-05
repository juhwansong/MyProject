package com.kh.viewnimal.donate.model.dto;

import java.sql.Date;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class DonateDto implements java.io.Serializable {
	private static final long serialVersionUID = 1008L;

	private int 	rnum; 				// ROWNUM
	private int 	no; 				// 인덱스
	private String 	writer; 			// 작성자
	private String 	account_no; 		// 계좌번호
	private String 	account_host; 		// 예금주
	private String 	bank; 				// 은행
	private int 	donation; 			// 금액
	private Date 	donate_date; 		// 입금날짜
	private String 	donate_date_str; 	// 입금날짜 (for JSON)
	private String 	supporter_id; 		// 입금자

	public DonateDto() {}

}
