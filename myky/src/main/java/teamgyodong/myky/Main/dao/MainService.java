package teamgyodong.myky.Main.dao;

import java.util.HashMap;

public interface MainService {

	HashMap<String, Object> InsertVisitLog(HashMap<String, Object> map);
	HashMap<String, Object> insertSearchHistory(HashMap<String, Object> map);

	HashMap<String, Object> selectCategoryList(HashMap<String, Object> map);
	HashMap<String, Object> selectNotificationList(HashMap<String, Object> map);

	HashMap<String, Object> updateNotification(HashMap<String, Object> map);

	
	
	
}
