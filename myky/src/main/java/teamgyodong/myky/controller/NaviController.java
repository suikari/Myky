package teamgyodong.myky.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ch.qos.logback.core.model.Model;

@Controller
public class NaviController {

	@RequestMapping("navi/main.do") 
    public String blist(Model model) throws Exception{

        return "navi/index";
    }
	
}
