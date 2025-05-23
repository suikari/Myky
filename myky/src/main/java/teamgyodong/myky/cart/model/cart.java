package teamgyodong.myky.cart.model;

import lombok.Data;

@Data
public class cart {

	private String cartId;
	private String createdAt;
	private String sessionId;
	private String userId;
	
	private String cartItemId;
	private String quantity;
	private String productId;
	private String shippingFee;
	private String shippingFreeMinimum;
	private String checkYn;
	
	private String productName;
	private String price;
	private String totalPrice;
	private String filepath;
	private String thumbnail;
	private int discount;
	
	private String orderId;
	private String orderDetailId;
	private String orderStatus;
	private String orderedAt;
	private String receiverName;
	private String receiverPhone;
	private String receiverAddr;
	private String paymentMethod;
	private String updatedAt;
	private String refundRequestDate;
	private String deliveryMessage;
	private String trackingNumber;
	private String reason;
	private String reasonDetail;
	private String refundStatus;

	private String name;
	private String address;
	
}
