package teamgyodong.myky.board.dao;

import java.util.HashMap;

public interface BoardService {
	
	HashMap<String, Object> getBoardList(HashMap<String, Object> map);

	HashMap<String, Object> boardView(HashMap<String, Object> map);

	HashMap<String, Object> boardAdd(HashMap<String, Object> map);


}
