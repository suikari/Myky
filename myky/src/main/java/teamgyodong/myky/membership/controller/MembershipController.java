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
import jakarta.servlet.http.HttpServletRequest;
import teamgyodong.myky.membership.dao.MembershipService;

@Controller
public class MembershipController {
	
	@Autowired
	MembershipService membershipService;
	
	@RequestMapping("/membership/main.do") 
    public String main(HttpServletRequest request, Model model) throws Exception{
		 String sessionId = (String) request.getSession().getAttribute("sessionId");

	    if (sessionId == null || sessionId.isEmpty()) {
	        // 로그인 안 되어 있으면 로그인 페이지로 이동
	        return "redirect:/user/login.do";
	    }

        return "membership/membership"; //폴더안에 있어서 폴더위치도 경로에 해줘야함
    }
	//멤버십 가입 약관
	@RequestMapping("/membership/terms.do") 
    public String MembershipTerms(HttpServletRequest request, Model model) throws Exception{

        return "membership/membership-terms"; 
    }
	
	//멤버십 가입- 본인확인 및 결제
	@RequestMapping("/membership/join.do") 
    public String MembershipJoin(HttpServletRequest request, Model model) throws Exception{

        return "membership/membership-join"; 
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
	
	//멤버십 멤버 기부금 확인
	@RequestMapping(value = "/membership/getMembershipDonation.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String MembershipTotalDonation(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = membershipService.getMembershipTotalDonation(map);

		return new Gson().toJson(resultMap);
	}
	//전체 회원 수
	@RequestMapping(value = "/membership/getTotalUserCnt.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String TotalUserCnt(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = membershipService.getTotalUserCnt(map);

		return new Gson().toJson(resultMap);
	}
	
	//유저 총 기부금 확인
	@RequestMapping(value = "/membership/getUserTotalDonation.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String uTotalDonation(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = membershipService.getUserTotalDonation(map);

		return new Gson().toJson(resultMap);
	}
	//멤버십 가입
	@RequestMapping(value = "/membership/join.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getJoin(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = membershipService.getJoinMember(map);

		return new Gson().toJson(resultMap);
	}
	//멤버십 이용 약관 동의
	@RequestMapping(value = "/membership/termsList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String termsList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		HashMap<String, Object> resultMap = new HashMap<>();
	    
	    resultMap = membershipService.getTermsList(map); // 서비스 호출
	    return new Gson().toJson(resultMap);
	}
	//멤버십 결제 후 회원 추가
	@RequestMapping(value = "/membership/addmember.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addMembership(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = membershipService.addMembership(map);
	    return new Gson().toJson(resultMap);
	}

	
}
