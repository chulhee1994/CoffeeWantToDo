package com.myspring.team.recipe.vo;

import java.sql.Date;

public class ImageFileVO {
	private int image_id;
	private String fileName;
	private Date creDate;
	private int recipe_no;
	
	public ImageFileVO() {}
	public ImageFileVO(int image_id, String fileName, Date creDate, int recipe_no) {
		super();
		this.image_id = image_id;
		this.fileName = fileName;
		this.creDate = creDate;
		this.recipe_no = recipe_no;
	}
	public int getImage_id() {
		return image_id;
	}
	public void setImage_id(int image_id) {
		this.image_id = image_id;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Date getCreDate() {
		return creDate;
	}
	public void setCreDate(Date creDate) {
		this.creDate = creDate;
	}
	public int getRecipe_no() {
		return recipe_no;
	}
	public void setRecipe_no(int recipe_no) {
		this.recipe_no = recipe_no;
	}
	@Override
	public String toString() {
		return "ImageFileVO [image_id=" + image_id + ", fileName=" + fileName + ", creDate=" + creDate + ", recipe_no="
				+ recipe_no + "]";
	}
	
	
	
}
