package teamgyodong.myky.board.dao;

import java.util.HashMap;
import java.util.Map;

public interface BoardService {
	
	HashMap<String, Object> getBoardList(HashMap<String, Object> map);

	HashMap<String, Object> boardView(HashMap<String, Object> map);

	HashMap<String, Object> boardAdd(HashMap<String, Object> map);

	HashMap<String, Object> boardEdit(HashMap<String, Object> map);

	HashMap<String, Object> boardRemove(HashMap<String, Object> map);

	HashMap<String, Object> CommentAdd(HashMap<String, Object> map);

	HashMap<String, Object> CommentRemove(HashMap<String, Object> map);

	HashMap<String, Object> CommentEdit(HashMap<String, Object> map);

	HashMap<String, Object> commentUpdate(HashMap<String, Object> map);

	HashMap<String, Object> CommentCount(HashMap<String, Object> map);

	void addBoardFile(HashMap<String, Object> map);

	HashMap<String, Object> boardRemoveFile(HashMap<String, Object> map);

	void insertReply(Map<String, Object> map);

	HashMap<String, Object> selectLikeButton(HashMap<String, Object> map);

	HashMap<String, Object>  addlikeCnt(HashMap<String, Object> map);

	HashMap<String, Object> RemoveCnt(HashMap<String, Object> map);

	HashMap<String, Object> addlikeCntBoard(HashMap<String, Object> map);

	HashMap<String, Object> vetBoardList(HashMap<String, Object> map);

	HashMap<String, Object> vetBoardView(HashMap<String, Object> map);

	HashMap<String, Object> vetBoardAdd(HashMap<String, Object> map);

	HashMap<String, Object> vetBoardEdit(HashMap<String, Object> map);

	HashMap<String, Object> vetBoardRemove(HashMap<String, Object> map);

	HashMap<String, Object> vetBoardAnReply(HashMap<String, Object> map);

	HashMap<String, Object> vetBoardAnEdit(HashMap<String, Object> map);

	HashMap<String, Object> vetBoardAnSelect(HashMap<String, Object> map);

	HashMap<String, Object> vetBoardAnRemove(HashMap<String, Object> map);





}
