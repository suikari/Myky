package teamgyodong.myky.board.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.board.model.board;

@Mapper
public interface BoardMapper {
	List<board> getFreeBoard(HashMap<String, Object> map);

}
