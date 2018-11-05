package com.kh.viewnimal.adoption.model.dto;

public class AdoptionReviewReplyDto implements java.io.Serializable{

	private static final long serialVersionUID = 1004L;

	private int no;
	private String write_date;
	private String content;
	private String writer;
	private int origin_no;
	
	public AdoptionReviewReplyDto(){
		
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getOrigin_no() {
		return origin_no;
	}
	public void setOrigin_no(int origin_no) {
		this.origin_no = origin_no;
	}
	
		
}
