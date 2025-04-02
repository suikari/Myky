package teamgyodong.myky.partner.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teamgyodong.myky.partner.mapper.PartnerMapper;
import teamgyodong.myky.partner.model.partnerdetail;

@Service
public class PartnerServiceImpl implements PartnerService {

	
	@Autowired
	PartnerMapper partnerMapper;

	
	@Override
	public HashMap<String, Object> getPartnerDetailList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String result = "";
		
		try {
			List<partnerdetail> gulist = partnerMapper.getPartnerGuList(map);
			List<partnerdetail> donglist = partnerMapper.getPartnerDongList(map);
			List<partnerdetail> silist = partnerMapper.getPartnerSiList(map);
			List<partnerdetail> hoslist = partnerMapper.getPartnerHosList(map); //병원리스트
			List<partnerdetail> partnerlist = partnerMapper.getPartnerList(map); //제휴리스트
			List<partnerdetail> favoriteList = partnerMapper.getfavoriteList(map);
			List<partnerdetail> categoryCode = partnerMapper.getcategoryCode(map);
			

			resultMap.put("categoryCode", categoryCode); 
			resultMap.put("partnerlist", partnerlist);
			resultMap.put("hoslist", hoslist);
			resultMap.put("gulist", gulist);
			resultMap.put("donglist", donglist);
			resultMap.put("silist", silist);
			resultMap.put("favoriteList", favoriteList);
			resultMap.put("result", "success");			
			
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			

		}
				
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> favoritesHospitalInsert(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		partnerMapper.addfavoritesHospital(map);

		System.out.println("key ==> " + map.get("hospitalNo"));
		resultMap.put("result", "success");
		resultMap.put("hospitalNo", map.get("hospitalNo"));
		System.out.println(map);
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> favoritesPartnerInsert(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		partnerMapper.addfavoritesPartner(map);

		System.out.println("key ==> " + map.get("partnerdetailId"));
		resultMap.put("result", "success");
		resultMap.put("partnerdetailId", map.get("partnerdetailId"));
		System.out.println(map);
		return resultMap;
	}

	@Override
	public HashMap<String, Object> favoritesHospitalRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		partnerMapper.favoritesHospitalDelete(map);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> favoritesPartnerRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		partnerMapper.favoritesPartnerDelete(map);
		resultMap.put("result", "success");
		return resultMap;
	}

	
	@Override
	public HashMap<String, Object> favoritesList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String result = "";
		
		try {
			List<partnerdetail> favorList = partnerMapper.favorList(map);
			

			 
			
			resultMap.put("favorList", favorList);
			resultMap.put("result", "success");			
			
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			

		}

		partnerMapper.favorList(map);
		resultMap.put("result", "success");
		return resultMap;
	}


	

}
