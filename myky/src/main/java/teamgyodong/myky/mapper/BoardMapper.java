package teamgyodong.myky.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.model.board;

@Mapper
public interface BoardMapper {
	List<board> getFreeBoard(HashMap<String, Object> map);

}
