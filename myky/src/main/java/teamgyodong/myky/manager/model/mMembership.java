package teamgyodong.myky.manager.model;

import lombok.Data;

@Data
public class mMembership {
	
	private String membershipId;
	private String membershipType;
	private String expirationDate;
	private String renewalDate;
	private String isCanceled;
	private String userId;
	private String donationYn;
	    
}
