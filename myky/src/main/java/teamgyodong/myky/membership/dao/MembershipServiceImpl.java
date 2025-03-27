package teamgyodong.myky.membership.dao;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import teamgyodong.myky.membership.mapper.MembershipMapper;
import teamgyodong.myky.membership.model.Membership;


@Service
public class MembershipServiceImpl implements MembershipService {
	
	@Autowired
	MembershipMapper membershipMapper;

	@Override
	public HashMap<String, Object> getMembershipInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			Membership info = membershipMapper.selectMembershipInfo(map);
			
			resultMap.put("info", info);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
}
