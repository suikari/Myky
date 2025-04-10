package teamgyodong.myky.Main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.Main.dao.MainService;
import teamgyodong.myky.donation.dao.DonationService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@Controller
public class MainController {
	
	@Autowired
	MainService mainService;
	
	
    private static final Logger logger = LoggerFactory.getLogger(MainController.class);

    
	@RequestMapping("main.do") 
    public String main(HttpServletRequest request, HttpSession session, Model model)throws Exception{

		    // Flash Attribute를 JSP에서 사용할 수 있도록 처리
		    String alertMessage = (String) request.getAttribute("alertMessage");
		    if (alertMessage != null) {
		        model.addAttribute("alertMessage", alertMessage);
		    }
		    
		//session.removeAttribute("firstVisit");
		
		 // 세션을 통해 첫 방문 여부 확인

        return "index";
    }
	
	@RequestMapping("/common/termsList.do")
	public String termsList(@RequestParam("type") String type, Model model) throws Exception {


	    return "common/termsList";
	}
	
	@RequestMapping("/common/companyIntro.do")
	public String companyIntro(Model model) throws Exception {


	    return "common/companyIntro";
	}
	
    @RequestMapping("/member/logout.do") 
    public String login(HttpSession session, Model model) throws Exception{
		
    	session.removeAttribute("sessionId");	
    	session.removeAttribute("sessionName");	
    	session.removeAttribute("sessionRole");	
    	return "redirect:/main.do"; // 로그인 페이지로 이동
    }
	
	
    
    
    
	// centerList
	@RequestMapping(value = "/menuList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String menuList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = mainService.selectCategoryList(map);
		return new Gson().toJson(resultMap);
	}
    
    
	// centerList
	@RequestMapping(value = "/insertSearch.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String insertSearch(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = mainService.insertSearchHistory(map);
		return new Gson().toJson(resultMap);
	}
	
	
	// centerList
	@RequestMapping(value = "/Notification.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String Notification(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = mainService.selectNotificationList(map);
		return new Gson().toJson(resultMap);
	}

	@RequestMapping(value = "/updateNoti.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String updateNoti(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = mainService.updateNotification(map);
		return new Gson().toJson(resultMap);
	}
	
 
}
