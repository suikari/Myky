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
	
	@Override
	public HashMap<String, Object> getMembershipActive(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			Membership membership = membershipMapper.selectValidMembership(map);
			
			if(membership != null) {
				resultMap.put("membership", membership);
				resultMap.put("result", "success");
			} else {
				resultMap.put("membership", null);
				resultMap.put("result", "no_membership");				
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	//멤버십 멤버 인원 수
	public HashMap<String, Object> getMemberCnt(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int memberCnt = membershipMapper.selectMemberCnt(map);
			
			resultMap.put("memberCnt", memberCnt);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	//멤버십 멤버 구독 개월 수
	public HashMap<String, Object> getTotalDonation(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int donationSum = membershipMapper.getTotalAmount(map);
			
			resultMap.put("donationSum", donationSum);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
}
