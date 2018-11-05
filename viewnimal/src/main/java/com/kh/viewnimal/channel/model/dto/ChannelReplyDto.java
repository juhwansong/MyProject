package com.kh.viewnimal.channel.model.dto;

import java.io.Serializable;
import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class ChannelReplyDto implements Serializable {

	private static final long serialVersionUID = 1007L;
	
	private int no;
	private int channel_no;
	private String id;
	private Date write_date;
	private String reply_content;
	private String nickname;
}
