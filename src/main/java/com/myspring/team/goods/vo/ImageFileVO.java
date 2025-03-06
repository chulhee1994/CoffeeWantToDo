package com.myspring.team.goods.vo;

import java.sql.Date;

public class ImageFileVO {
	private int image_id; // 이미지 ID
    private int goods_id; // 상품 ID (외래키)
    private String fileName; // 파일 이름
    private String fileType; // 파일 타입
    private Date credate; // 생성 날짜 (기본값: sysdate)

	 public int getImage_id() {
		return image_id;
	}
	public void setImage_id(int image_id) {
		this.image_id = image_id;
	}
	public int getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
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
	public Date getCredate() {
		return credate;
	}
	public void setCredate(Date credate) {
		this.credate = credate;
	}
	@Override
	public String toString() {
		return "ImageFileVO [image_id=" + image_id + ", goods_id=" + goods_id + ", fileName=" + fileName + ", fileType="
				+ fileType + ", credate=" + credate + "]";
	}

	
	
}
