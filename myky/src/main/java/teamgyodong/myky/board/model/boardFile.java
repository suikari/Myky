package teamgyodong.myky.board.model;

import lombok.Data;

@Data
public class boardFile {

	private int fileId;
	private int boardId;
	private String fileName;
	private String filePath;
	private String originalName;
	private String fileExt;
	private String createdAt;
	private int fileSize;
	
}
