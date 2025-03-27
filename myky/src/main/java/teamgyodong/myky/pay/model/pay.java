package teamgyodong.myky.pay.model;

import lombok.Data;

@Data
public class pay {
	private String paymentId;
	private String paymentCode;
	private String description;
	private String amount;
	private String paymentMethod;
	private String installment;
	private String subscriptionPeriod;
	private String paymentDate;
	private String paymentStatus;
	private String isCanceled;
	private String cancelDate;
	private String productId;
	private String donationId;
	private String userId;
	
	// product
	private String productName;
	private String categoryId;
	private int price ;
	private String quantity;
	private String registrationDate;
	private String manufacturer;
	private String productType;
	private String productCode;
	
	// users
	private String userName;
	private String address;
	private String password;
	private String nickName;
	private String email;
	private String profileImage;
	private String phoneNumber;
	private String birthDate;
	private String role;

	// point
	private String pointId;
	private String usageDate;
	private String usePoint;
	private String currentPoint;
	private String remarks;
	
}
