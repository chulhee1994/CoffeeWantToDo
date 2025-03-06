package com.myspring.team.order.vo;

import java.io.Serializable;
import java.sql.Clob;
import java.sql.Date;
import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import com.myspring.team.cart.vo.CartVO;
import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.goods.vo.ImageFileVO;
import com.myspring.team.member.vo.MemberVO;

@Component("orderVO")
public class OrderVO implements Serializable {
    private static final long serialVersionUID = 1L;
    
    //OrderVO
    private int seq_order_id;  // 예시로 int 타입을 가정
	private int order_id;
	private String mem_id;
	private int goods_id;
	private String orderer_name;
	private String goods_name;
	private int order_goods_qty;
	private int goods_sales_price;
	private int order_total_price;
	private int final_total_price;
	private String orderer_hp1;
	private String orderer_hp2;
	private String orderer_hp3;
	private String goods_fileName;
	private String receiver_name;
	private String receiver_tel1;
	private String receiver_tel2;
	private String receiver_tel3;
	private int address_id;
	private String delivery_address;
	private String delivery_method;
	private String delivery_message;
	private String gift_wrapping;
	private String pay_method;
	private String card_com_name;
	private String card_pay_month;
	private String pay_orderer_hp_num;
	private String delivery_state;
	private Date pay_order_time;
	private String review_status;
	private Timestamp complete_time;
    private String merchant_uid;
    private String t_id;

	private String imp_uid;
	private int goods_stock;
	private int goods_point;
	//OrderVO
	//포근
		private Date orderDate;  // 수정된 부분
		private double totalSales;
		private String month;  // 추가된 필드
		private String seller_id;
		


	//CartVO
	private CartVO cartVO;
	//CartVO
	
	//GoodsVO	
	private GoodsVO goodsVO;
	//GoodsVO
	
	//C_member
	private MemberVO memberVO;
	
	//imageFileVO
	private ImageFileVO imageFileVO;
	
	
	public String getSeller_id() {
		return seller_id;
	}

	public void setSeller_id(String seller_id) {
		this.seller_id = seller_id;
	}
	
	public Timestamp getComplete_time() {
		return complete_time;
	}

	public void setComplete_time(Timestamp complete_time) {
		this.complete_time = complete_time;
	}

	public String getMerchant_uid() {
		return merchant_uid;
	}

	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}

	public String getT_id() {
		return t_id;
	}

	public void setT_id(String t_id) {
		this.t_id = t_id;
	}
	public String getImp_uid() {
		return imp_uid;
	}

	public void setImp_uid(String imp_uid) {
		this.imp_uid = imp_uid;
	}

	public int getGoods_stock() {
		return goods_stock;
	}

	public void setGoods_stock(int goods_stock) {
		this.goods_stock = goods_stock;
	}

	public int getGoods_point() {
		return goods_point;
	}

	public void setGoods_point(int goods_point) {
		this.goods_point = goods_point;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String getMonth() {
	    return month;
	}

	public void setMonth(String month) {
	    this.month = month;
	}

	// Getters and Setters
	public Date getOrderDate() {
	    return orderDate;
	}

	public void setOrderDate(Date orderDate) {
	    this.orderDate = orderDate;
	}

	public double getTotalSales() {
	    return totalSales;
	}

	public void setTotalSales(double totalSales) {
	    this.totalSales = totalSales;
	}

	public int getSeq_order_id() {
		return seq_order_id;
	}
	public void setSeq_order_id(int seq_order_id) {
		this.seq_order_id = seq_order_id;
	}
	public int getOrder_id() {
		return order_id;
	}
	public void setOrder_id(int order_id) {
		this.order_id = order_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getGoods_id() {
		return goods_id;
	}
	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}
	public String getOrderer_name() {
		return orderer_name;
	}
	public void setOrderer_name(String orderer_name) {
		this.orderer_name = orderer_name;
	}
	public String getGoods_name() {
		return goods_name;
	}
	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	public int getOrder_goods_qty() {
		return order_goods_qty;
	}
	public void setOrder_goods_qty(int order_goods_qty) {
		this.order_goods_qty = order_goods_qty;
	}
	public int getGoods_sales_price() {
		return goods_sales_price;
	}
	public void setGoods_sales_price(int goods_sales_price) {
		this.goods_sales_price = goods_sales_price;
	}
	public int getOrder_total_price() {
		return order_total_price;
	}
	public void setOrder_total_price(int order_total_price) {
		this.order_total_price = order_total_price;
	}
	public int getFinal_total_price() {
		return final_total_price;
	}
	public void setFinal_total_price(int final_total_price) {
		this.final_total_price = final_total_price;
		
	}
	public String getOrderer_hp1() {
		return orderer_hp1;
	}
	public void setOrderer_hp1(String orderer_hp1) {
		this.orderer_hp1 = orderer_hp1;
	}
	public String getOrderer_hp2() {
		return orderer_hp2;
	}
	public void setOrderer_hp2(String orderer_hp2) {
		this.orderer_hp2 = orderer_hp2;
	}
	public String getOrderer_hp3() {
		return orderer_hp3;
	}
	public void setOrderer_hp3(String orderer_hp3) {
		this.orderer_hp3 = orderer_hp3;
	}
	
	
	

	
	
	
	
	public String getGoods_fileName() {
		return goods_fileName;
	}
	public void setGoods_fileName(String goods_fileName) {
		this.goods_fileName = goods_fileName;
	}
	public String getReceiver_name() {
		return receiver_name;
	}
	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}
	public String getReceiver_tel1() {
		return receiver_tel1;
	}
	public void setReceiver_tel1(String receiver_tel1) {
		this.receiver_tel1 = receiver_tel1;
	}
	public String getReceiver_tel2() {
		return receiver_tel2;
	}
	public void setReceiver_tel2(String receiver_tel2) {
		this.receiver_tel2 = receiver_tel2;
	}
	public String getReceiver_tel3() {
		return receiver_tel3;
	}
	public void setReceiver_tel3(String receiver_tel3) {
		this.receiver_tel3 = receiver_tel3;
	}
	public int getAddress_id() {
		return address_id;
	}
	public void setAddress_id(int address_id) {
		this.address_id = address_id;
	}
	public String getDelivery_address() {
		return delivery_address;
	}
	public void setDelivery_address(String delivery_address) {
		this.delivery_address = delivery_address;
	}
	public String getDelivery_method() {
		return delivery_method;
	}
	public void setDelivery_method(String delivery_method) {
		this.delivery_method = delivery_method;
	}


	
	
	
	
	public String getDelivery_message() {
		return delivery_message;
	}
	public void setDelivery_message(String delivery_message) {
		this.delivery_message = delivery_message;
	}
	public String getGift_wrapping() {
		return gift_wrapping;
	}
	public void setGift_wrapping(String gift_wrapping) {
		this.gift_wrapping = gift_wrapping;
	}
	public String getPay_method() {
		return pay_method;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}
	public String getCard_com_name() {
		return card_com_name;
	}
	public void setCard_com_name(String card_com_name) {
		this.card_com_name = card_com_name;
	}
	public String getCard_pay_month() {
		return card_pay_month;
	}
	public void setCard_pay_month(String card_pay_month) {
		this.card_pay_month = card_pay_month;
	}
	public String getPay_orderer_hp_num() {
		return pay_orderer_hp_num;
	}
	public void setPay_orderer_hp_num(String pay_orderer_hp_num) {
		this.pay_orderer_hp_num = pay_orderer_hp_num;
	}
	public String getDelivery_state() {
		return delivery_state;
	}
	public void setDelivery_state(String delivery_state) {
		this.delivery_state = delivery_state;
	}
	public Date getPay_order_time() {
		return pay_order_time;
	}
	public void setPay_order_time(Date pay_order_time) {
		this.pay_order_time = pay_order_time;
	}
	public String getReview_status() {
		return review_status;
	}
	public void setReview_status(String review_status) {
		this.review_status = review_status;
	}
	
	
	
	
	
	
	
	public CartVO getCartVO() {
		return cartVO;
	}
	public void setCartVO(CartVO cartVO) {
		this.cartVO = cartVO;
	}
	public GoodsVO getGoodsVO() {
		return goodsVO;
	}
	public void setGoodsVO(GoodsVO goodsVO) {
		this.goodsVO = goodsVO;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	
	
	public ImageFileVO getImageFileVO() {
		return imageFileVO;
	}
	public void setImageFileVO(ImageFileVO imageFileVO) {
		this.imageFileVO = imageFileVO;
	}
	
	@Override
	public String toString() {
		return "OrderVO [seq_order_id=" + seq_order_id + ", order_id=" + order_id + ", mem_id=" + mem_id + ", goods_id="
				+ goods_id + ", orderer_name=" + orderer_name + ", goods_name=" + goods_name + ", order_goods_qty="
				+ order_goods_qty + ", goods_sales_price=" + goods_sales_price + ", order_total_price="
				+ order_total_price + ", final_total_price=" + final_total_price + ", orderer_hp1=" + orderer_hp1
				+ ", orderer_hp2=" + orderer_hp2 + ", orderer_hp3=" + orderer_hp3 + ", goods_fileName=" + goods_fileName
				+ ", receiver_name=" + receiver_name + ", receiver_tel1=" + receiver_tel1 + ", receiver_tel2="
				+ receiver_tel2 + ", receiver_tel3=" + receiver_tel3 + ", address_id=" + address_id
				+ ", delivery_address=" + delivery_address + ", delivery_method=" + delivery_method
				+ ", delivery_message=" + delivery_message + ", gift_wrapping=" + gift_wrapping + ", pay_method="
				+ pay_method + ", card_com_name=" + card_com_name + ", card_pay_month=" + card_pay_month
				+ ", pay_orderer_hp_num=" + pay_orderer_hp_num + ", delivery_state=" + delivery_state
				+ ", pay_order_time=" + pay_order_time + ", review_status=" + review_status + ", cartVO=" + cartVO
				+ ", goodsVO=" + goodsVO + ", memberVO=" + memberVO + ", imageFileVO=" + imageFileVO + "]";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	
	

}
