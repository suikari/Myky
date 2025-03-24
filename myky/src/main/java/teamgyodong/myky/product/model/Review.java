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
}
