package teamgyodong.myky.donation.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
	public String donation(Model model) throws Exception{
		
//		request.setAttribute("map", map);
		return "donation/donation";
	}
	
	// centerList
	@RequestMapping(value = "center/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = donationService.getCenterList(map);
		return new Gson().toJson(resultMap);
	}
}
