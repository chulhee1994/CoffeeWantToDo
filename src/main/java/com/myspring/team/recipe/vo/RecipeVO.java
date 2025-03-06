package com.myspring.team.recipe.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("recipeVO")
public class RecipeVO {
	
	private int rownum;
	private int level;
	private int recipe_no;
	private String recipe_title;
	private String recipe_content;
	private Date recipe_writedate;
	private String mem_id;
	private int views;
	private int goods_id;
	
	//상품 테이블 정보
	private String goods_name;
	private int goods_price;
	private int goods_sales_price;
	private int goods_stock;
	private Date goods_create_date;
	
	//상품 이미지 테이블 정보
	private String fileName;    // 상품 이미지 파일명 추가
	private String fileType;    // 상품 이미지 타입 추가 (예: image/png)
	//상품 이미지
	public RecipeVO() {}
	public RecipeVO(int rownum, int level, int recipe_no, String recipe_title, String recipe_content,
			Date recipe_writedate, String mem_id, int views, int goods_id, String goods_name, int goods_price,
			int goods_sales_price, int goods_stock, Date goods_create_date, String fileName, String fileType) {
		super();
		this.rownum = rownum;
		this.level = level;
		this.recipe_no = recipe_no;
		this.recipe_title = recipe_title;
		this.recipe_content = recipe_content;
		this.recipe_writedate = recipe_writedate;
		this.mem_id = mem_id;
		this.views = views;
		this.goods_id = goods_id;
		this.goods_name = goods_name;
		this.goods_price = goods_price;
		this.goods_sales_price = goods_sales_price;
		this.goods_stock = goods_stock;
		this.goods_create_date = goods_create_date;
		this.fileName = fileName;
		this.fileType = fileType;
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
	public int getRecipe_no() {
		return recipe_no;
	}
	public void setRecipe_no(int recipe_no) {
		this.recipe_no = recipe_no;
	}
	public String getRecipe_title() {
		return recipe_title;
	}
	public void setRecipe_title(String recipe_title) {
		this.recipe_title = recipe_title;
	}
	public String getRecipe_content() {
		return recipe_content;
	}
	public void setRecipe_content(String recipe_content) {
		this.recipe_content = recipe_content;
	}
	public Date getRecipe_writedate() {
		return recipe_writedate;
	}
	public void setRecipe_writedate(Date recipe_writedate) {
		this.recipe_writedate = recipe_writedate;
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
	public int getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}
	public String getGoods_name() {
		return goods_name;
	}
	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	public int getGoods_price() {
		return goods_price;
	}
	public void setGoods_price(int goods_price) {
		this.goods_price = goods_price;
	}
	public int getGoods_sales_price() {
		return goods_sales_price;
	}
	public void setGoods_sales_price(int goods_sales_price) {
		this.goods_sales_price = goods_sales_price;
	}
	public int getGoods_stock() {
		return goods_stock;
	}
	public void setGoods_stock(int goods_stock) {
		this.goods_stock = goods_stock;
	}
	public Date getGoods_create_date() {
		return goods_create_date;
	}
	public void setGoods_create_date(Date goods_create_date) {
		this.goods_create_date = goods_create_date;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	@Override
	public String toString() {
		return "RecipeVO [rownum=" + rownum + ", level=" + level + ", recipe_no=" + recipe_no + ", recipe_title="
				+ recipe_title + ", recipe_content=" + recipe_content + ", recipe_writedate=" + recipe_writedate
				+ ", mem_id=" + mem_id + ", views=" + views + ", goods_id=" + goods_id + ", goods_name=" + goods_name
				+ ", goods_price=" + goods_price + ", goods_sales_price=" + goods_sales_price + ", goods_stock="
				+ goods_stock + ", goods_create_date=" + goods_create_date + ", fileName=" + fileName + ", fileType="
				+ fileType + "]";
	}
	
	
	
	
	
	
	
}

