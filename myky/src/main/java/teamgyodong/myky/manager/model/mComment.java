package teamgyodong.myky.manager.model;

import java.util.List;

import lombok.Data;

@Data
public class mComment {
	
	private String title;
	private String createdAt;
	private String deleteDate;
	private String viewCount;
	private String dislikes;
	private String likes;
	private String isSecret;
	private String category;
	private String cnt;
	private String commentCount;
	
	
	
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
    private List<mComment> replies;

    // Getter/Setter 포함
    public List<mComment> getReplies() {
        return replies;
    }

    public void setReplies(List<mComment> replies) {
        this.replies = replies;
    }
}
