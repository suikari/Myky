package teamgyodong.myky.board.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.board.model.board;
import teamgyodong.myky.board.model.boardFile;
import teamgyodong.myky.board.model.boardLikeLog;
import teamgyodong.myky.board.model.comment;
import teamgyodong.myky.board.model.vetAnswer;
import teamgyodong.myky.board.model.vetBoard;

@Mapper
public interface BoardMapper {
	
	List<board> selectBoardList(HashMap<String, Object> map);

	int selectBoardCnt(HashMap<String, Object> map);

	List<board> selectBoard(HashMap<String, Object> map);

	void insertBoard(HashMap<String, Object> map);

	void updateBoard(HashMap<String, Object> map);

	int updateRemoveBoard(HashMap<String, Object> map);

	void insertComment(HashMap<String, Object> map);

	void updateCnt(HashMap<String, Object> map);

	List<comment> selectCmtList(HashMap<String, Object> map);

	void commentUpdate(HashMap<String, Object> map);

	void deleteComment(HashMap<String, Object> map);

	void updateComment(HashMap<String, Object> map);

	List<board> countComment(HashMap<String, Object> map);

	void insertBoardFile(HashMap<String, Object> map);

	List<boardFile> selectBoardImg(HashMap<String, Object> map);

	int deleteFile(HashMap<String, Object> map);

	void insertReply(Map<String, Object> map);
	
	List<comment> selectParentCmtList(HashMap<String, Object> map);

	boardLikeLog selectLike(HashMap<String, Object> map);

	int insertLikelog(HashMap<String, Object> map);

	int deleteStatus(HashMap<String, Object> map);
	
	void updatelikeCntBoard (HashMap<String, Object> map);

	List<vetBoard> selectVetBoardList(HashMap<String, Object> map);

	int selectVetBoardCnt(HashMap<String, Object> map);

	List<vetAnswer> selectVetAnList(HashMap<String, Object> map);

	vetBoard selectVetBoard(HashMap<String, Object> map);

	void updateVetBoardCnt(HashMap<String, Object> map);

	void insertVetBoard(HashMap<String, Object> map);

	void updateVetBoard(HashMap<String, Object> map);

	int updateRemoveVetBoard(HashMap<String, Object> map);
	



}
