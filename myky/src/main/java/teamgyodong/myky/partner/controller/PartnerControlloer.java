package teamgyodong.myky.partner.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import ch.qos.logback.core.model.Model;
import teamgyodong.myky.board.dao.BoardService;
import teamgyodong.myky.partner.dao.PartnerService;

@Controller
public class PartnerControlloer {
	
	@Autowired
	PartnerService partnerService;
	
	@RequestMapping("/partner/list.do") 
    public String map(Model model) throws Exception{
		

        return "partner/partner"; //폴더안에 있어서 폴더위치도 경로에 해줘야함
    }
	
	
	@RequestMapping(value = "partner/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		//System.out.print(map);
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = partnerService.getPartnerDetailList(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value ="favorites/hospital/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String favoriteshosInsert(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = partnerService.favoritesHospitalInsert(map);

		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value ="favorites/partner/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String favoritesparInsert(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap = partnerService.favoritesPartnerInsert(map);
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value ="favorites/hospital/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String favoritesRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = partnerService.favoritesHospitalRemove(map);

		
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value ="favorites/partner/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String favoritesPartnerRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap = partnerService.favoritesPartnerRemove(map);
		
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value ="favorites/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String favoritesList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = partnerService.favoritesList(map);
		
		
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value ="partner/alllist.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String allhosList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		System.out.println(map);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = partnerService.allhosList(map);
		
		
		return new Gson().toJson(resultMap);
	}
}
