package teamgyodong.myky.partner.dao;

import java.util.HashMap;



public interface PartnerService {

	HashMap<String, Object> getPartnerDetailList(HashMap<String, Object> map); //지도 동물병원 목록 리스트


	HashMap<String, Object> favoritesList(HashMap<String, Object> map);


	HashMap<String, Object> favoritesHospitalInsert(HashMap<String, Object> map);


	HashMap<String, Object> favoritesPartnerInsert(HashMap<String, Object> map);


	HashMap<String, Object> favoritesHospitalRemove(HashMap<String, Object> map);


	HashMap<String, Object> favoritesPartnerRemove(HashMap<String, Object> map);


	HashMap<String, Object> allhosList(HashMap<String, Object> map);


	



	
}
