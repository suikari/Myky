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

	board selectBoard(HashMap<String, Object> map);

	int insertBoard(HashMap<String, Object> map);

	int updateBoard(HashMap<String, Object> map);

	int updateRemoveBoard(HashMap<String, Object> map);

	int insertComment(HashMap<String, Object> map);

	void updateCnt(HashMap<String, Object> map);

	List<comment> selectCmtList(HashMap<String, Object> map);

	int commentUpdate(HashMap<String, Object> map);

	int deleteComment(HashMap<String, Object> map);

	int updateComment(HashMap<String, Object> map);

	List<board> countComment(HashMap<String, Object> map);

	void insertBoardFile(HashMap<String, Object> map);

	List<boardFile> selectBoardImg(HashMap<String, Object> map);

	int deleteFile(HashMap<String, Object> map);

	void insertReply(HashMap<String, Object> map);
	
	List<comment> selectParentCmtList(HashMap<String, Object> map);

	boardLikeLog selectLike(HashMap<String, Object> map);

	int insertLikelog(HashMap<String, Object> map);

	int deleteStatus(HashMap<String, Object> map);
	
	int updatelikeCntBoard (HashMap<String, Object> map);

	List<vetBoard> selectVetBoardList(HashMap<String, Object> map);

	int selectVetBoardCnt(HashMap<String, Object> map);

	List<vetAnswer> selectVetAnList(HashMap<String, Object> map);

	vetBoard selectVetBoard(HashMap<String, Object> map);

	void updateVetBoardCnt(HashMap<String, Object> map);

	int insertVetBoard(HashMap<String, Object> map);

	int updateVetBoard(HashMap<String, Object> map);

	int updateRemoveVetBoard(HashMap<String, Object> map);

	int insertVetAnReply(HashMap<String, Object> map);

	int updateAnEdit(HashMap<String, Object> map);

	void updateVetAnSelect(HashMap<String, Object> map);

	int deleteVetBoardAn(HashMap<String, Object> map);

	int checkDuplicateVetAnswer(HashMap<String, Object> map);

	void updateVetBoardStats(HashMap<String, Object> map);

	List<vetAnswer> selectVetRating(HashMap<String, Object> map);


	



}
