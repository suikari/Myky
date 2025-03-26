package teamgyodong.myky.manager.model;

import lombok.Data;

@Data
public class mDonation {
	private String centerId;
	private String centerName;
	private String address;
	private String tel;
	private String websiteUrl;
	private String description;
	private String imageUrl;
	private int donationTotalCnt;
	
	private String donationId;
	private String amount;
	private String donationDate;
	private String message;
	private String userId;
}
