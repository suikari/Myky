package teamgyodong.myky.Main.model;

import lombok.Data;

@Data
public class Category {
	private String categoryId;
	private String parentId;
	private String categoryName;
	private String menuUrl;
	private String del;
	private String depth;
}
