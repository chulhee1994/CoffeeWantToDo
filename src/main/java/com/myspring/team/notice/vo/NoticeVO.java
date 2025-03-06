package com.myspring.team.notice.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("noticeVO")
public class NoticeVO {
	
	@Override
	public String toString() {
		return "NoticeVO [rownum=" + rownum + ", level=" + level + ", notice_no=" + notice_no + ", notice_head="
				+ notice_head + ", notice_title=" + notice_title + ", notice_content=" + notice_content
				+ ", notice_writedate=" + notice_writedate + ", fileName=" + fileName + ", mem_id=" + mem_id
				+ ", views=" + views + "]";
	}
	private int rownum;
	private int level;
	private int notice_no;
	private String notice_head;
	private String notice_title;
	private String notice_content;
	private Date notice_writedate;
	private String fileName;
	private String mem_id;
	private int views;
	
	
	public NoticeVO() {
		super();
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public int getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}
	public String getNotice_head() {
		return notice_head;
	}
	public void setNotice_head(String notice_head) {
		this.notice_head = notice_head;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public Date getNotice_writedate() {
		return notice_writedate;
	}
	public void setNotice_writedate(Date notice_writedate) {
		this.notice_writedate = notice_writedate;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	
	
}
