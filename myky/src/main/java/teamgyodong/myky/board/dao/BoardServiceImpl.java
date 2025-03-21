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
	//게시글 목록 출력
	public HashMap<String, Object> getBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String result = "";
		
		try {
			
			List<board> board = boardMapper.selectBoardList(map);			
			board count = boardMapper.selectBoardCnt(map);

			resultMap.put("count", count);
			resultMap.put("result", "success");			
			resultMap.put("board", board);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			

		}

		return resultMap;
	}
	//게시글 상세보기
		public HashMap<String, Object> boardView(HashMap<String, Object> map) {
			// TODO Auto-generated method stub
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
			board info = boardMapper.selectBoard(map);
			
			resultMap.put("info", info);
			resultMap.put("result", "success");
			return resultMap;
		}
}
