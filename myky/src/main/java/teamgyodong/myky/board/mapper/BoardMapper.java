package teamgyodong.myky.board.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.board.model.board;

@Mapper
public interface BoardMapper {
	
	List<board> selectBoardList(HashMap<String, Object> map);

	int selectBoardCnt(HashMap<String, Object> map);

	List<board> selectBoard(HashMap<String, Object> map);

	void insertBoard(HashMap<String, Object> map);


}
