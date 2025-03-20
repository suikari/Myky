package teamgyodong.myky.model;

import lombok.Data;

@Data
public class board {

	
	private String boardId;
	private String title;
	private String content;
	private String creatdate;
	private String updatdate;
	private String deletedate;
	private String viewcount;
	private String dislikes;
	private String likes;
	private String isSecret;
	private String isDeleted;
	private String category;
	private String userId;
	
}
