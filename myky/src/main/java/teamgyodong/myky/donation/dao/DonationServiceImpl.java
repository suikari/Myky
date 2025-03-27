package teamgyodong.myky.donation.dao;

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

import teamgyodong.myky.donation.mapper.DonationMapper;
import teamgyodong.myky.donation.model.donation;
import teamgyodong.myky.membership.mapper.MembershipMapper;


@Service
public class DonationServiceImpl implements DonationService {

	@Autowired
	DonationMapper donationMapper;

	@Autowired
	MembershipMapper membershipMapper;
	
	@Override
	public HashMap<String, Object> getCenterList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<donation> list = donationMapper.selectCenterList(map);

			resultMap.put("list", list);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> getCenterInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			donation info = donationMapper.selectCenter(map);
			
			resultMap.put("info", info);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> addDonate(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			donationMapper.insertHistory(map);
			
			if(map.get("option").equals("membership")) {
				membershipMapper.updateDonationYn(map);
			}
			
			resultMap.put("donationId", map.get("donationId"));
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> getDonationInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<donation> info = donationMapper.selectDonationInfo(map);
			
			resultMap.put("info", info);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
}
