package com.myspring.team.recipe.vo;

import java.sql.Date;
import java.sql.Timestamp;

import org.springframework.stereotype.Component;

@Component("commentVO")
public class CommentVO {
	private int rownum;
	private int level;
	private int comment_no;
	private int parent_comment_no;
	private String comment_content;
	private Timestamp comment_writedate;
	private Timestamp comment_mod_writedate;
	private int recipe_no;
	private String mem_id;
	private int comment_like;
	private int comment_dislike;
	private int ratio;
	
	public CommentVO() {}

	public CommentVO(int rownum, int level, int comment_no, int parent_comment_no, String comment_content,
			Timestamp comment_writedate, Timestamp comment_mod_writedate, int recipe_no, String mem_id,
			int comment_like, int comment_dislike, int ratio) {
		super();
		this.rownum = rownum;
		this.level = level;
		this.comment_no = comment_no;
		this.parent_comment_no = parent_comment_no;
		this.comment_content = comment_content;
		this.comment_writedate = comment_writedate;
		this.comment_mod_writedate = comment_mod_writedate;
		this.recipe_no = recipe_no;
		this.mem_id = mem_id;
		this.comment_like = comment_like;
		this.comment_dislike = comment_dislike;
		this.ratio = ratio;
	}

	public int getRownum() {
		return rownum;
	}

	public void setRownum(int rownum) {
		this.rownum = rownum;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getComment_no() {
		return comment_no;
	}

	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}

	public int getParent_comment_no() {
		return parent_comment_no;
	}

	public void setParent_comment_no(int parent_comment_no) {
		this.parent_comment_no = parent_comment_no;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public Timestamp getComment_writedate() {
		return comment_writedate;
	}

	public void setComment_writedate(Timestamp comment_writedate) {
		this.comment_writedate = comment_writedate;
	}

	public Timestamp getComment_mod_writedate() {
		return comment_mod_writedate;
	}

	public void setComment_mod_writedate(Timestamp comment_mod_writedate) {
		this.comment_mod_writedate = comment_mod_writedate;
	}

	public int getRecipe_no() {
		return recipe_no;
	}

	public void setRecipe_no(int recipe_no) {
		this.recipe_no = recipe_no;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public int getComment_like() {
		return comment_like;
	}

	public void setComment_like(int comment_like) {
		this.comment_like = comment_like;
	}

	public int getComment_dislike() {
		return comment_dislike;
	}

	public void setComment_dislike(int comment_dislike) {
		this.comment_dislike = comment_dislike;
	}

	public int getRatio() {
		return ratio;
	}

	public void setRatio(int ratio) {
		this.ratio = ratio;
	}

	@Override
	public String toString() {
		return "CommentVO [rownum=" + rownum + ", level=" + level + ", comment_no=" + comment_no
				+ ", parent_comment_no=" + parent_comment_no + ", comment_content=" + comment_content
				+ ", comment_writedate=" + comment_writedate + ", comment_mod_writedate=" + comment_mod_writedate
				+ ", recipe_no=" + recipe_no + ", mem_id=" + mem_id + ", comment_like=" + comment_like
				+ ", comment_dislike=" + comment_dislike + ", ratio=" + ratio + "]";
	}
	
	
	
	
	
	
	
}
