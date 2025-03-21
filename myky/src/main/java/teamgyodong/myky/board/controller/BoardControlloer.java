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

import teamgyodong.myky.board.dao.BoardService;
import teamgyodong.myky.board.mapper.BoardMapper;

@Controller
public class BoardControlloer {//..

	@Autowired
	BoardService boardService;
	
	@RequestMapping(value = "board/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardupdate(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		//System.out.print(map);
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getFreeBoard(map);
		
		return new Gson().toJson(resultMap);
	}
	
}
