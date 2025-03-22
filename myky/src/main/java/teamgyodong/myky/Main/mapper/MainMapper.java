package teamgyodong.myky.Main.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.Main.model.Category;



@Mapper
public interface MainMapper {
	
	
	int insertVisitLog(HashMap<String, Object> map);
	List<Category> selectCategoryList(HashMap<String, Object> map);

}
