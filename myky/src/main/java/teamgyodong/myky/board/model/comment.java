package teamgyodong.myky.board.model;

import lombok.Data;

@Data
public class comment {
	
	private int commentId;
	private int boardId;
	private String userId;	
	private int parentCommentId;
	private String content;
	private String createAt;
	private String updatedAt;
	private String isDeleted;

}
