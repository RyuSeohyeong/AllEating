package com.spring.alleating.order.vo;

import java.sql.Date;


import org.springframework.stereotype.Component;

@Component("allEatingOrderVO")
public class AllEatingOrderVO {
	private String orderId;
	private String id;
	//주문자 정보
	private String orderName;
	private String orderHp;
	//받는 사람 및 주소
	private String receiverName;
	private String receiverHp;
	private String zipcode;
	private String address;
	private String address2;
	private String addressDetail;
	
	private String delivery_request;
	private int userPoint;
	private String couponId;
	private int totalPrice;
	private String card_com_name;
	private String card_pay_month;
	private String orderStatus;
	private Date payDate;
	//예약상품 일자
	private String thunderDate;
	private String thunderTime;
	
	//대표 상품 정보
	private String productName;
	private String cateCode;
	private String fileName;
	private int productId;
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOrderName() {
		return orderName;
	}
	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}
	public String getOrderHp() {
		return orderHp;
	}
	public void setOrderHp(String orderHp) {
		this.orderHp = orderHp;
	}
	public String getReceiverName() {
		return receiverName;
	}
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}
	public String getReceiverHp() {
		return receiverHp;
	}
	public void setReceiverHp(String receiverHp) {
		this.receiverHp = receiverHp;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getAddressDetail() {
		return addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
	public String getDelivery_request() {
		return delivery_request;
	}
	public void setDelivery_request(String delivery_request) {
		this.delivery_request = delivery_request;
	}
	public int getUserPoint() {
		return userPoint;
	}
	public void setUserPoint(int userPoint) {
		this.userPoint = userPoint;
	}
	public String getCouponId() {
		return couponId;
	}
	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
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
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public Date getPayDate() {
		return payDate;
	}
	public void setPayDate(Date payDate) {
		this.payDate = payDate;
	}
	public String getThunderDate() {
		return thunderDate;
	}
	public void setThunderDate(String thunderDate) {
		this.thunderDate = thunderDate;
	}
	public String getThunderTime() {
		return thunderTime;
	}
	public void setThunderTime(String thunderTime) {
		this.thunderTime = thunderTime;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getCateCode() {
		return cateCode;
	}
	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	
	
	
}
	
	
	

