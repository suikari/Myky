package teamgyodong.myky.user.model;

import java.util.List;

import lombok.Data;

@Data
public class User {
	private String userId;
	private String userName;
	private String address;
	private String password;
	private String nickName;
	private String email;
	private String profileImage;
	private String phoneNumber;
	private String birthDate;
	private String role;
	private String agreeYn;
	private String phoneYn;
	private String emailYn;
	private String gender;
	private String deleteYn;

	
	// point
	private String pointId;
	private String usageDate;
	private String usePoint;
	private String currentPoint;
	private String remarks;

	
	// coupon
	private String couponId;
	private String serialNumber;
	private String couponName;
	private String createdAt;
	private String usedDate;
	private String expirationDate;
	private String discountRate;
	private String minimumSpend;
	private String maxDiscountAmount;
	


}
