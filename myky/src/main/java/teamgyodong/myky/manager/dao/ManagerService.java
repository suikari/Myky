package teamgyodong.myky.manager.dao;

import java.util.HashMap;

public interface ManagerService {
	
	HashMap<String, Object> selectLogBrowserList(HashMap<String, Object> map);
	
	HashMap<String, Object> selectMainList(HashMap<String, Object> map);
	
	HashMap<String, Object> deleteBoardList(HashMap<String, Object> map);
	
	HashMap<String, Object> selectAllCmtList(HashMap<String, Object> map);

}
