package teamgyodong.myky.partner.dao;

import java.util.HashMap;



public interface PartnerService {

	HashMap<String, Object> getPartnerDetailList(HashMap<String, Object> map); //지도 동물병원 목록 리스트


	HashMap<String, Object> favoritesInsert(HashMap<String, Object> map); //즐겨찾기 추가


	HashMap<String, Object> favoritesRemove(HashMap<String, Object> map); //즐겨찾기 삭제


	HashMap<String, Object> favoritesList(HashMap<String, Object> map);



	
}
