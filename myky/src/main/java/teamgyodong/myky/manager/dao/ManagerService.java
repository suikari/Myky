package teamgyodong.myky.manager.dao;

import java.util.HashMap;

public interface ManagerService {
	
	HashMap<String, Object> selectLogBrowserList(HashMap<String, Object> map);
	HashMap<String, Object> selectLogFristJoinBuy(HashMap<String, Object> map);
	HashMap<String, Object> selectMembershipVal(HashMap<String, Object> map);
	HashMap<String, Object> selectMainList(HashMap<String, Object> map);
	HashMap<String, Object> selectSearchRanking(HashMap<String, Object> map);

	
	
	HashMap<String, Object> deleteBoardList(HashMap<String, Object> map);
	HashMap<String, Object> deleteBoardCmtList(HashMap<String, Object> map);
	HashMap<String, Object> deleteProductImg(HashMap<String, Object> map);
	HashMap<String, Object> deletePartnerList(HashMap<String, Object> map);
	
	HashMap<String, Object> deleteVet(HashMap<String, Object> map);
	HashMap<String, Object> deleteProduct(HashMap<String, Object> map);

	
	
	
	HashMap<String, Object> selectAllnotVetList(HashMap<String, Object> map);
	HashMap<String, Object> selectAllCmtList(HashMap<String, Object> map);
	HashMap<String, Object> selectAllUserList(HashMap<String, Object> map);
	HashMap<String, Object> selectAllVetList(HashMap<String, Object> map);
	HashMap<String, Object> selectAllMembershipList(HashMap<String, Object> map);
	HashMap<String, Object> selectAllBoardList(HashMap<String, Object> map);
	HashMap<String, Object> selectAllProductList(HashMap<String, Object> map);
	HashMap<String, Object> selectAllOrderList(HashMap<String, Object> map);
	HashMap<String, Object> selectAllPartnerList(HashMap<String, Object> map);

	
	
	
	HashMap<String, Object> selectProduct(HashMap<String, Object> map);
	HashMap<String, Object> selectBestSellProduct(HashMap<String, Object> map);

	
	
	HashMap<String, Object> updateUser(HashMap<String, Object> map);
	HashMap<String, Object> updateVet(HashMap<String, Object> map);
	HashMap<String, Object> updateProduct(HashMap<String, Object> map);
	HashMap<String, Object> updateOrder(HashMap<String, Object> map);
	HashMap<String, Object> updateOrderDetail(HashMap<String, Object> map);
	HashMap<String, Object> updatePartnerDetail(HashMap<String, Object> map);
	HashMap<String, Object> UpdateAdminQna(HashMap<String, Object> map);

	
	
	
	
	
	HashMap<String, Object> insertVet(HashMap<String, Object> map);
	HashMap<String, Object> insertProduct(HashMap<String, Object> map);
	HashMap<String, Object> insertProductFile(HashMap<String, Object> map);
	HashMap<String, Object> insertBoard(HashMap<String, Object> map);
	HashMap<String, Object> insertPartnerDetail(HashMap<String, Object> map);

	
	
	
	
}
	
	
