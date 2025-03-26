package teamgyodong.myky.manager.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.util.MultiValueMap;
import org.springframework.util.LinkedMultiValueMap;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.Main.dao.MainService;
import teamgyodong.myky.manager.dao.ManagerService;


@Controller
public class ManagerController {
	
	@Autowired
	ManagerService managerService;
	
	@RequestMapping("manager/main.do") 
    public String main(HttpServletRequest request, HttpSession session, Model model ,RedirectAttributes redirectAttributes) throws Exception{
		
		
		String sessionId = (String) session.getAttribute("sessionId");
		 
		 if (sessionId == null) {
	            // Flash 속성을 사용하여 alert 메시지 전달
	            redirectAttributes.addFlashAttribute("alertMessage", "비정상적인 접근입니다.");
	            return "redirect:/main.do"; // 로그인 페이지로 이동
	     } 
		 
	        return "manager/index";
		
		
    }
	
	
	// centerList
	@RequestMapping(value = "/admin/mainList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String mainList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectMainList(map);
		return new Gson().toJson(resultMap);
	}
    
	
    
	// centerList
	@RequestMapping(value = "/admin/LogList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String LogList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectLogBrowserList(map);
		return new Gson().toJson(resultMap);
	}
    
}
