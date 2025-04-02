package teamgyodong.myky.membership.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import ch.qos.logback.core.model.Model;
import teamgyodong.myky.membership.dao.MembershipService;

@Controller
public class MembershipController {
	
	@Autowired
	MembershipService membershipService;
	
	@RequestMapping("/membership/main.do") 
    public String map(Model model) throws Exception{
		

        return "membership/membership"; //폴더안에 있어서 폴더위치도 경로에 해줘야함
    }
	
	// 멤버십 정보 조회
	@RequestMapping(value = "/membership/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String info(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = membershipService.getMembershipInfo(map);
		return new Gson().toJson(resultMap);
	}
	
	// 멤버십 활성화 여부 확인
	@RequestMapping(value = "/membership/active.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String active(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = membershipService.getMembershipActive(map);
		return new Gson().toJson(resultMap);
	}
	
	//멤버십 총 인원수 확인
	@RequestMapping(value = "/membership/memberCnt.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberCnt(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = membershipService.getMemberCnt(map);

		return new Gson().toJson(resultMap);
	}
	
	//멤버십 멤버 개월수 확인
	@RequestMapping(value = "/membership/getTotalDonation.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String TotalDonation(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = membershipService.getTotalDonation(map);

		return new Gson().toJson(resultMap);
	}
}
