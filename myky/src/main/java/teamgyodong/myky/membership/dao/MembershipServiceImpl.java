package teamgyodong.myky.membership.dao;

import java.util.HashMap;
import java.util.List;
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
import teamgyodong.myky.pay.mapper.PayMapper;


@Service
public class MembershipServiceImpl implements MembershipService {
	
	@Autowired
	MembershipMapper membershipMapper;
	
	@Autowired
	PayMapper payMapper;

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
	
	//멤버십 멤버 구독 개월 수 총 기부금 
	public HashMap<String, Object> getMembershipTotalDonation(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int membershipDonationSum = membershipMapper.getMembershipTotalAmount(map);
			
			resultMap.put("membershipDonationSum", membershipDonationSum);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	//유저 회원수
	public HashMap<String, Object> getTotalUserCnt(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int totalUserCnt = membershipMapper.selectTotalUserCnt(map);
			
			resultMap.put("totalUserCnt", totalUserCnt);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	//회원 전체 기부금 
	public HashMap<String, Object> getUserTotalDonation(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int userDonationSum = membershipMapper.getUserTotalAmount(map);
			
			resultMap.put("userDonationSum", userDonationSum);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	//멤버십 가입
	public HashMap<String, Object> getJoinMember(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			membershipMapper.getJoinMEmber(map);
			
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	//멤버십 이용 약관 동의
	public HashMap<String, Object> getTermsList(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<>();

	    try {
	    	List<Membership> termsList = membershipMapper.selectTermsList(map);
	    	
	    	resultMap.put("list", termsList);
	        resultMap.put("result", "success");
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        resultMap.put("result", "fail");
	    }

	    return resultMap;
	}
	//
	public HashMap<String, Object> addMembership(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<>();
	    try {
	        membershipMapper.insertMembership(map);  


	        resultMap.put("membershipId", map.get("membershipId"));
	        resultMap.put("result", "success");

	    } catch (Exception e) {
	        e.printStackTrace();
	        resultMap.put("result", "fail");
	    }
	    return resultMap;
	}


	
}
