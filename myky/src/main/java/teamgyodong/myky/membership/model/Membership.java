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
	
	
	//TERMS
	private String termId;
	private String title;
	private String content;
	private String requiredYn;
	private int displayOrder;
	private String category;
}
