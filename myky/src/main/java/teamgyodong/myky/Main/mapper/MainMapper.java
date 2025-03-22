package teamgyodong.myky.Main.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface MainMapper {
	
	
	int insertVisitLog(HashMap<String, Object> map);

}
