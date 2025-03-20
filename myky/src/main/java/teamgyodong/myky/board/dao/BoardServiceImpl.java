package teamgyodong.myky.board.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teamgyodong.myky.board.mapper.BoardMapper;
import teamgyodong.myky.board.model.board;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public HashMap<String, Object> getFreeBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String result = "";
		
		try {
			List<board> board = boardMapper.getFreeBoard(map);
			
			//result = board != null ? "success" : "fail";
			//System.out.print(result);
			 
			resultMap.put("result", "success");			
			resultMap.put("board", board);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			

		}
				



		return resultMap;
	}
}
