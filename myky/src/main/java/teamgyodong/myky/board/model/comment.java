package teamgyodong.myky.board.model;

import java.util.List;

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
	private String updatedTime;
	
	private String nickName;

	
    // ✅ 추가
    private List<comment> replies;

    // Getter/Setter 포함
    public List<comment> getReplies() {
        return replies;
    }

    public void setReplies(List<comment> replies) {
        this.replies = replies;
    }
}
