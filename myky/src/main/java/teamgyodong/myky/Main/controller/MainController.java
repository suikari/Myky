package teamgyodong.myky.Main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ch.qos.logback.core.model.Model;

@Controller
public class MainController {

	@RequestMapping("main.do") 
    public String blist(Model model) throws Exception{

        return "index";
    }
	
}
