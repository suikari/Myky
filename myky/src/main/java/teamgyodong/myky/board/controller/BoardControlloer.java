package teamgyodong.myky.board.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import teamgyodong.myky.board.dao.BoardService;

@Controller
public class BoardControlloer {

	@Autowired
	BoardService boardService;
	
	@RequestMapping("/board/list.do") 
    public String list(Model model) throws Exception{

        return "board/board-list";
    }
	@RequestMapping("/board/view.do") 
	public String view(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception{
			
		request.setAttribute("map", map);
		
        return "board/board-view";
    }
	
	@RequestMapping(value = "board/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getBoardList(map);
		
		return new Gson().toJson(resultMap);
	}
	@RequestMapping(value = "board/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.boardView(map);
		
		return new Gson().toJson(resultMap);
	}
	
}
