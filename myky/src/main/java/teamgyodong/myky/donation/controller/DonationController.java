package teamgyodong.myky.donation.controller;

import java.util.HashMap;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.*;

import org.springframework.web.client.RestTemplate;
import org.springframework.util.MultiValueMap;
import org.springframework.util.LinkedMultiValueMap;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.donation.dao.DonationService;


@Controller
public class DonationController {

	@Autowired
	DonationService donationService;
	
	@RequestMapping("/center.do") 
	public String center(Model model) throws Exception{
		
		return "donation/center";
	}
	
	@RequestMapping("/donation.do") 
	public String donation(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession();
        String sessionId = (String) session.getAttribute("sessionId");
        
		request.setAttribute("map", map);
		return "donation/donation";
	}

	@RequestMapping("/donation/complete.do") 
	public String donationComplete(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession();
        String sessionId = (String) session.getAttribute("sessionId");
        
        if (sessionId == null) {
            return "redirect:/user/login.do";
        }
        
		request.setAttribute("map", map);
		return "donation/donationSummary";
	}
	
	// centerList
	@RequestMapping(value = "/center/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = donationService.getCenterList(map);
		return new Gson().toJson(resultMap);
	}
	
	// 보호소 정보 조회
	@RequestMapping(value = "/center/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String info(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = donationService.getCenterInfo(map);
		return new Gson().toJson(resultMap);
	}

	// 후원하기
	@RequestMapping(value = "/center/donate.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String donate(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = donationService.addDonate(map);
		return new Gson().toJson(resultMap);
	}
	
	// 후원 내역 조회 (전체 조회)
	@RequestMapping(value = "/donation/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String donationInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = donationService.getDonationInfo(map);
		return new Gson().toJson(resultMap);
	}

	// 후원 내역 조회 (userId로 조회)
	@RequestMapping(value = "/donation/complete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String donationComplete(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = donationService.getUserDonationInfo(map);
		return new Gson().toJson(resultMap);
	}
}
