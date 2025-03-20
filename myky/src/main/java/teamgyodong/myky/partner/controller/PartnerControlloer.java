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
	
	@RequestMapping(value = "partner/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		//System.out.print(map);
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = partnerService.getPartnerDetailList(map);
		
		return new Gson().toJson(resultMap);
	}
}
