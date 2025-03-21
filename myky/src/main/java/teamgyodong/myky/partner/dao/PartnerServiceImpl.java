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
			
			//result = board != null ? "success" : "fail";
			//System.out.print(result);
			 
			resultMap.put("gulist", gulist);
			resultMap.put("donglist", donglist);
			resultMap.put("silist", silist);
			resultMap.put("result", "success");			
			
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			

		}
				



		return resultMap;
	}
	
}
