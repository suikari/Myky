package teamgyodong.myky.Main.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.Main.model.Category;
import teamgyodong.myky.manager.model.Visit;
import teamgyodong.myky.manager.model.mPay;
import teamgyodong.myky.manager.model.mProduct;
import teamgyodong.myky.manager.model.mUser;



@Mapper
public interface MainMapper {
	
	
	int insertVisitLog(HashMap<String, Object> map);
	int insertSearchHistory(HashMap<String, Object> map);

	
	List<Category> selectCategoryList(HashMap<String, Object> map);

	
	
}
