package com.myspring.team.goods.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

@Component("GoodsVO")
public class GoodsVO {
	private int goods_id; // 상품 ID
	private String goods_name; // 상품 이름
    private String goods_category; // 상품 카테고리
    private int goods_price; // 가격
    private int goods_sales_price; // 할인 가격
    private int goods_stock; // 상품 재고
    private int goods_like; // 좋아요 수
    private String mem_id; // 판매자 ID (member 테이블 외래키)
    private Date goods_roasting_date; // 제조 날짜
    private Date goods_create_date; // 상품 등록 날짜
    private String goods_w_filter; // 날씨
    private String goods_c_roasting; // 로스팅 방법
    private String goods_c_blending; // 블렌딩 유무
    private Integer goods_c_gram; // 그램 수
    private String goods_c_note; // 커피 맛
    private String goods_c_det_note; // 커피 향
    private String goods_origin1; // 원산지 1
    private String goods_origin2; // 원산지 2
    private String goods_origin3; // 원산지 3
    private int goods_point; // 포인트
    private String goods_m_filter; // 필터
    private String goods_status; //판매중 y,n
    private String fileName;
    private String fileType;
    private String mainImage;  // 메인 이미지
    private String detailImage1;  // 디테일 이미지 1
    private String detailImage2;  // 디테일 이미지 2
    private String detailImage3;  // 디테일 이미지 3
    private int goods_delivery_price; //배송비
    private int  order_goods_qty; //카트
    private String seller_id;
    
    
    
    public String getSeller_id() {
		return seller_id;
	}
	public void setSeller_id(String seller_id) {
		this.seller_id = seller_id;
	}
	private String goods_mem_id;
    private int goods_goods_id;
    
	public int getGoods_goods_id() {
		return goods_goods_id;
	}
	public void setGoods_goods_id(int goods_goods_id) {
		this.goods_goods_id = goods_goods_id;
	}
	public String getGoods_mem_id() {
		return goods_mem_id;
	}
	public void setGoods_mem_id(String goods_mem_id) {
		this.goods_mem_id = goods_mem_id;
	}
	public int getOrder_goods_qty() {
		return order_goods_qty;
	}
	public void setOrder_goods_qty(int order_goods_qty) {
		this.order_goods_qty = order_goods_qty;
	}
	public int getGoods_delivery_price() {
		return goods_delivery_price;
	}
	public void setGoods_delivery_price(int goods_delivery_price) {
		this.goods_delivery_price = goods_delivery_price;
	}
	public String getMainImage() {
		return mainImage;
	}
	public void setMainImage(String mainImage) {
		this.mainImage = mainImage;
	}
	public String getDetailImage1() {
		return detailImage1;
	}
	public void setDetailImage1(String detailImage1) {
		this.detailImage1 = detailImage1;
	}
	public String getDetailImage2() {
		return detailImage2;
	}
	public void setDetailImage2(String detailImage2) {
		this.detailImage2 = detailImage2;
	}
	public String getDetailImage3() {
		return detailImage3;
	}
	public void setDetailImage3(String detailImage3) {
		this.detailImage3 = detailImage3;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getGoods_status() {
		return goods_status;
	}
	public void setGoods_status(String goods_status) {
		this.goods_status = goods_status;
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
	public String getGoods_category() {
		return goods_category;
	}
	public void setGoods_category(String goods_category) {
		this.goods_category = goods_category;
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
	public Date getGoods_roasting_date() {
		return goods_roasting_date;
	}
	public void setGoods_roasting_date(Date goods_roasting_date) {
		this.goods_roasting_date = goods_roasting_date;
	}
	public Date getGoods_create_date() {
		return goods_create_date;
	}
	public void setGoods_create_date(Date goods_create_date) {
		this.goods_create_date = goods_create_date;
	}
	public String getGoods_w_filter() {
		return goods_w_filter;
	}
	public void setGoods_w_filter(String goods_w_filter) {
		this.goods_w_filter = goods_w_filter;
	}
	public String getGoods_c_roasting() {
		return goods_c_roasting;
	}
	public void setGoods_c_roasting(String goods_c_roasting) {
		this.goods_c_roasting = goods_c_roasting;
	}
	public String getGoods_c_blending() {
		return goods_c_blending;
	}
	public void setGoods_c_blending(String goods_c_blending) {
		this.goods_c_blending = goods_c_blending;
	}
	public Integer getGoods_c_gram() {
		return goods_c_gram;
	}
	public void setGoods_c_gram(Integer goods_c_gram) {
		this.goods_c_gram = goods_c_gram;
	}
	public String getGoods_c_note() {
		return goods_c_note;
	}
	public void setGoods_c_note(String goods_c_note) {
		this.goods_c_note = goods_c_note;
	}
	public String getGoods_c_det_note() {
		return goods_c_det_note;
	}
	public void setGoods_c_det_note(String goods_c_det_note) {
		this.goods_c_det_note = goods_c_det_note;
	}
	public String getGoods_origin1() {
		return goods_origin1;
	}
	public void setGoods_origin1(String goods_origin1) {
		this.goods_origin1 = goods_origin1;
	}
	public String getGoods_origin2() {
		return goods_origin2;
	}
	public void setGoods_origin2(String goods_origin2) {
		this.goods_origin2 = goods_origin2;
	}
	public String getGoods_origin3() {
		return goods_origin3;
	}
	public void setGoods_origin3(String goods_origin3) {
		this.goods_origin3 = goods_origin3;
	}
	public String getGoods_m_filter() {
		return goods_m_filter;
	}
	public void setGoods_m_filter(String goods_m_filter) {
		this.goods_m_filter = goods_m_filter;
	}

    public int getGoods_point() {
		return goods_point;
	}
	public void setGoods_point(int goods_point) {
		this.goods_point = goods_point;
	}
	@Override
	public String toString() {
		return "GoodsVO [goods_id=" + goods_id + ", goods_name=" + goods_name + ", goods_category=" + goods_category
				+ ", goods_price=" + goods_price + ", goods_sales_price=" + goods_sales_price + ", goods_stock="
				+ goods_stock + ", goods_like=" + goods_like + ", mem_id=" + goods_mem_id + ", goods_roasting_date="
				+ goods_roasting_date + ", goods_create_date=" + goods_create_date + ", goods_w_filter="
				+ goods_w_filter + ", goods_c_roasting=" + goods_c_roasting + ", goods_c_blending=" + goods_c_blending
				+ ", goods_c_gram=" + goods_c_gram + ", goods_c_note=" + goods_c_note + ", goods_c_det_note="
				+ goods_c_det_note + ", goods_origin1=" + goods_origin1 + ", goods_origin2=" + goods_origin2
				+ ", goods_origin3=" + goods_origin3 + ", goods_point=" + goods_point + ", goods_m_filter="
				+ goods_m_filter + ", goods_status=" + goods_status + ", fileName=" + fileName + ", fileType="
				+ fileType + ", mainImage=" + mainImage + ", detailImage1=" + detailImage1 + ", detailImage2="
				+ detailImage2 + ", detailImage3=" + detailImage3 + ", goods_delivery_price=" + goods_delivery_price
				+ ", order_goods_qty=" + order_goods_qty + "]";
	}
	
	
}
