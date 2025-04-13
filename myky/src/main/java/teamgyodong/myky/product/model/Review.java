package teamgyodong.myky.product.model;

import java.util.List;

import lombok.Data;
import teamgyodong.myky.manager.model.orderdetail;

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
	
	
    // ✅ 추가
    private List<Review> Reviews;

    // Getter/Setter 포함
    public List<Review> getReviews() {
        return Reviews;
    }

    public void setReviews(List<Review> Reviews) {
        this.Reviews = Reviews;
    }
    
}
