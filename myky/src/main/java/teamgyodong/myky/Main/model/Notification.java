package teamgyodong.myky.Main.model;

import lombok.Data;

@Data
public class Notification {
    private String id;
    private String message;
    private String boardId;
    private String vetBoardId;
    private String orderId;
    private String qnaId;
    private String readYn;
    private String createdAt;
    private String userId;
    private String productId;
    private String commentId;
    private String parentCommentId;
}
