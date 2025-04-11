package teamgyodong.myky.product.model;

import lombok.Data;

@Data

public class Product {
	private String productId;
	private String productName;
	private String categoryId;
	private String categoryName;
	private int price ;
	private String quantity;
	private String registrationDate;
	private String manufacturer;
	private String productType;
	private String description;
	private String productCode;
	private int shippingFee;
	private int shippingFreeMinimum;
	private int discount;
	private String deleteYn;
	private String thumbNail;
	
	private String fileNo;
	private String reviewId;
	private String filePath ;
	private String fileName ;
	private String fileOrgname ;
	private String fileSize ;
	private String fileEtc;
	private String thumbYn ;
	
	
	
}
