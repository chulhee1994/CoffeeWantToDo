package com.myspring.team.review.vo;

import java.sql.Date;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class ImageFileVO {
	private int image_id;
	private String fileName;
	private Date creDate;
	private int review_no;
	private String fileType;
	
	private List<ImageFileVO> imageList;  // 이미지 리스트 추가
	
	public List<ImageFileVO> getImageList() {
        return imageList;
    }

    public void setImageList(List<ImageFileVO> imageList) {
        this.imageList = imageList;
    }
	
	public ImageFileVO() {}

	public ImageFileVO(int image_id, String fileName, Date creDate, int review_no, String fileType) {
		super();
		this.image_id = image_id;
		this.fileName = fileName;
		this.creDate = creDate;
		this.review_no = review_no;
		this.fileType = fileType;
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

	public int getReview_no() {
		return review_no;
	}

	public void setReview_no(int review_no) {
		this.review_no = review_no;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	@Override
	public String toString() {
		return "ImageFileVO [image_id=" + image_id + ", fileName=" + fileName + ", creDate=" + creDate + ", review_no="
				+ review_no + ", fileType=" + fileType + "]";
	}
	
	
	
	
}
