package teamgyodong.myky.product.model;

import lombok.Data;

@Data
public class Qna {
	private String qnaId;
	private String productId;
	private String userId;
	private String title;
	private String questionText;
	private String answerText;
	private String createdAt;
	private String answeredAt;
}
