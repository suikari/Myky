package teamgyodong.myky.product.model;

import lombok.Data;

@Data

public class Review {
	private String reviewId;
	private String userId;
	private String rating;
	private String reviewText;
	private String createdAt;
	private String productId;
	private String title;
	private int helpCnt;
	private String deleteYn;
	
	
	private String fileNo;
	private String filePath ;
	private String fileName ;
	private String fileOrgname ;
	private String fileSize ;
	private String fileEtc;
	private String thumbYn ;
}
