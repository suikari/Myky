package teamgyodong.myky.board.model;

import lombok.Data;

@Data
public class vetAnswer {

	private String reviewId;
	private String vetId;
	private String vetBoardId;
	private String rating;
	private String reviewText;
	private String comments;
	private String vetNickname;
	private String vetName;
	private String createdAt;
	private String updatedTime;
	private String isDeleted;
	private String userId;
	
//	users DB
	private String profileImage;
	
// veterinarian DB
	private String eMail;
	private String phoneNumber;
	private String affiliatedHospital;
	
}
