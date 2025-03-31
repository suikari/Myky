package teamgyodong.myky.manager.dao;

import java.util.HashMap;

public interface ManagerService {
	
	HashMap<String, Object> selectLogBrowserList(HashMap<String, Object> map);
	HashMap<String, Object> selectLogFristJoinBuy(HashMap<String, Object> map);

	HashMap<String, Object> selectMainList(HashMap<String, Object> map);
	
	HashMap<String, Object> deleteBoardList(HashMap<String, Object> map);
	HashMap<String, Object> deleteBoardCmtList(HashMap<String, Object> map);
	HashMap<String, Object> selectAllnotVetList(HashMap<String, Object> map);

	
	HashMap<String, Object> selectAllCmtList(HashMap<String, Object> map);
	
	HashMap<String, Object> selectSearchRanking(HashMap<String, Object> map);
	
	
	
	HashMap<String, Object> selectAllUserList(HashMap<String, Object> map);
	HashMap<String, Object> selectAllVetList(HashMap<String, Object> map);

	
	HashMap<String, Object> updateUser(HashMap<String, Object> map);
	
	HashMap<String, Object> updateVet(HashMap<String, Object> map);
	
	HashMap<String, Object> insertVet(HashMap<String, Object> map);

	
	
}
	
	
