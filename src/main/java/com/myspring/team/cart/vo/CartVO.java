package com.myspring.team.cart.vo;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.goods.vo.ImageFileVO;

@Component
public class CartVO {
	//카트 정보
	private int cart_id;
	private int goods_id;
	private String mem_id;
	private int order_goods_qty;
	
	//상품 정보
	private GoodsVO goodsVO;
	
	//이미지 정보
	private ImageFileVO imageFileVO;
	
	
	public CartVO() {
		
	}

	public CartVO(int cart_id, int goods_id, String mem_id, int order_goods_qty, GoodsVO goodsVO,
			ImageFileVO imageFileVO) {
		super();
		this.cart_id = cart_id;
		this.goods_id = goods_id;
		this.mem_id = mem_id;
		this.order_goods_qty = order_goods_qty;
		this.goodsVO = goodsVO;
		this.imageFileVO = imageFileVO;
	}

	public int getCart_id() {
		return cart_id;
	}

	public void setCart_id(int cart_id) {
		this.cart_id = cart_id;
	}

	public int getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public int getOrder_goods_qty() {
		return order_goods_qty;
	}

	public void setOrder_goods_qty(int order_goods_qty) {
		this.order_goods_qty = order_goods_qty;
	}

	public GoodsVO getGoodsVO() {
		return goodsVO;
	}

	public void setGoodsVO(GoodsVO goodsVO) {
		this.goodsVO = goodsVO;
	}

	public ImageFileVO getImageFileVO() {
		return imageFileVO;
	}

	public void setImageFileVO(ImageFileVO imageFileVO) {
		this.imageFileVO = imageFileVO;
	}

	@Override
	public String toString() {
		return "CartVO [cart_id=" + cart_id + ", goods_id=" + goods_id + ", mem_id=" + mem_id + ", order_goods_qty="
				+ order_goods_qty + ", goodsVO=" + goodsVO + ", imageFileVO=" + imageFileVO + "]";
	}




	
	
	
	
	
	
	
	
	
}
