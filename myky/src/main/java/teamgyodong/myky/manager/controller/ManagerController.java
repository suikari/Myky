package teamgyodong.myky.manager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
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
	@RequestMapping(value = "/admin/cmtList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String cmtList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectAllCmtList(map);
		return new Gson().toJson(resultMap);
	}
    
	
	// centerList
	@RequestMapping(value = "/admin/memberList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectAllUserList(map);
		return new Gson().toJson(resultMap);
	}
    
	
	// centerList
	@RequestMapping(value = "/admin/searchList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectSearchRanking(map);
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
	// centerList
	@RequestMapping(value = "/admin/fristBuyer.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String fristBuyer(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectLogFristJoinBuy(map);
		return new Gson().toJson(resultMap);
	}
	
	// centerList
	@RequestMapping(value = "/admin/VetList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String VetList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectAllVetList(map);
		return new Gson().toJson(resultMap);
	}
	
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/remove-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		System.out.println(list);
		
		resultMap = managerService.deleteBoardList(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/remove-cmt-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeCmtList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		System.out.println(list);
		
		resultMap = managerService.deleteBoardCmtList(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/updateUser.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String updateUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.updateUser(map);
		return new Gson().toJson(resultMap);
	}
	
}
