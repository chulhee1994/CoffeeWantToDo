package com.myspring.team.review.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import org.springframework.stereotype.Component;

@Component("reviewVO")
public class ReviewVO {
	
	private int rownum;
	private int level;
	
	private int review_no;
	private int goods_id;
	private String review_title;
	private String review_content;
	private Timestamp review_writedate;
	private int review_star;
	private int goods_like;
	private String mem_id;
	private int views;
	
	 // 추가된 이미지 리스트
    private List<ImageFileVO> imageList;  // 이미지 목록 필드 추가
    
    
	
	public List<ImageFileVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<ImageFileVO> imageList) {
		this.imageList = imageList;
	}

	//상품 테이블 정보
	private String goods_name;
	private int goods_price;
	private int goods_sales_price;
	private int goods_stock;
	private Date goods_create_date;
	
	//상품 이미지 테이블 정보
	private String fileName;    // 상품 이미지 파일명 추가
	private String fileType;
	
	public ReviewVO() {}

	public ReviewVO(int rownum, int level, int review_no, int goods_id, String review_title, String review_content,
			Timestamp review_writedate, int review_star, int goods_like, String mem_id, int views, String goods_name,
			int goods_price, int goods_sales_price, int goods_stock, Date goods_create_date, String fileName,
			String fileType) {
		super();
		this.rownum = rownum;
		this.level = level;
		this.review_no = review_no;
		this.goods_id = goods_id;
		this.review_title = review_title;
		this.review_content = review_content;
		this.review_writedate = review_writedate;
		this.review_star = review_star;
		this.goods_like = goods_like;
		this.mem_id = mem_id;
		this.views = views;
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

	public int getReview_no() {
		return review_no;
	}

	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}

	public int getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}

	public String getReview_title() {
		return review_title;
	}

	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}

	public String getReview_content() {
		return review_content;
	}

	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}

	public Timestamp getReview_writedate() {
		return review_writedate;
	}

	public void setReview_writedate(Timestamp review_writedate) {
		this.review_writedate = review_writedate;
	}

	public int getReview_star() {
		return review_star;
	}

	public void setReview_star(int review_star) {
		this.review_star = review_star;
	}

	public int getGoods_like() {
		return goods_like;
	}

	public void setGoods_like(int goods_like) {
		this.goods_like = goods_like;
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
		return "ReviewVO [rownum=" + rownum + ", level=" + level + ", review_no=" + review_no + ", goods_id=" + goods_id
				+ ", review_title=" + review_title + ", review_content=" + review_content + ", review_writedate="
				+ review_writedate + ", review_star=" + review_star + ", goods_like=" + goods_like + ", mem_id="
				+ mem_id + ", views=" + views + ", goods_name=" + goods_name + ", goods_price=" + goods_price
				+ ", goods_sales_price=" + goods_sales_price + ", goods_stock=" + goods_stock + ", goods_create_date="
				+ goods_create_date + ", fileName=" + fileName + ", fileType=" + fileType + "]";
	}

	
}
