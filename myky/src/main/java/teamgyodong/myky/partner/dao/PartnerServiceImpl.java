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
			List<partnerdetail> board = partnerMapper.getPartnerDetailList(map);
			
			//result = board != null ? "success" : "fail";
			//System.out.print(result);
			 
			resultMap.put("result", "success");			
			resultMap.put("board", board);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			

		}
				



		return resultMap;
	}
	
}
