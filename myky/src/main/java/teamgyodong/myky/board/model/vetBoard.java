package teamgyodong.myky.board.model;

import java.util.List;

import lombok.Data;

@Data
public class vetBoard {
	
	private String vetBoardId;
	private String vetId;
	private String boardId;
	private String title;
	private String content;
	private String points;
	private String isAccepted;
	private String ipAddress;
	private String userId;
	private String updatedTime;
	private String createdAt;
	private String updatedAt;
	private String nickName;
	private String isSecret;
	private String isDeleted;
	private String commentCount;
	private String cnt;
	
	private String currentPoint;
	
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
