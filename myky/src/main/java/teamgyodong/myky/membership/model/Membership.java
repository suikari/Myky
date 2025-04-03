package teamgyodong.myky.membership.model;

import lombok.Data;

@Data
public class Membership {
	
	private String membershipId;
	private String membershipType;
	private String expirationDate;
	private String renewalDate;
	private String isCanceled;
	private String userId;
	private String donationYn;
	
	//DONATION
	private String donationId;
	private String amount;
	private String donationDate;
	private String message;
	private String anonymousYn;
}
