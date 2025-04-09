package teamgyodong.myky.board.model;

import java.util.List;

import lombok.Data;
import teamgyodong.myky.manager.model.orderdetail;

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

	
    // ✅ 추가
    private List<vetAnswer> vetAnswerdetail;

    // Getter/Setter 포함
    public List<vetAnswer> getVetAnswerdetail() {
        return vetAnswerdetail;
    }

    public void setVetAnswerdetail(List<vetAnswer> detail) {
        this.vetAnswerdetail = detail;
    }
    
	
}
