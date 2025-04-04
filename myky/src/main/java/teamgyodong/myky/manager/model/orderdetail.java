package teamgyodong.myky.manager.model;

import lombok.Data;

@Data
public class orderdetail {

    private String orderDetailId;
    private String productId;
    private String quantity;
    private String price;
    private String orderId;
    private String trackingNumber;
    private String refundRequestDate;
    private String returnDate;
    private String refundReason;
    private String refundReasonDetail;
    private String refundStatus;
	
    
    
    
	private String productName;
	private String categoryId;
	private String registrationDate;
	private String manufacturer;
	private String productType;
	private String description;
	private String productCode;
	private int productTotalCnt;
	private String DeleteYn;
	private String discount;
	private String shippingFee;
	private String shippingFreeMinimum;
	private String deleteYn;
    
	private String fileId;
	private String filePath;
	private String fileName;
	private String thumbNail;
	private String fileSize;
	private String fileType;
}
