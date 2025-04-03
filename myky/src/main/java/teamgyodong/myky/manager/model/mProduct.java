package teamgyodong.myky.manager.model;

import lombok.Data;

@Data

public class mProduct {
	private String productId;
	private String productName;
	private String categoryId;
	private int price ;
	private String quantity;
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
	private String filePath ;
	private String fileName ;
	private String thumbNail ;
	private String fileSize ;
	private String fileType;
}
