package teamgyodong.myky.donation.model;

import lombok.Data;

@Data
public class donation {
	private String centerId;
	private String centerName;
	private String address;
	private String tel;
	private String websiteUrl;
	private String description;
	private String imageUrl;
	
	private String donationId;
	private String amount;
	private String donationDate;
	private String message;
	private String userId;
	private String anonymousYn;
}
