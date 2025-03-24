package teamgyodong.myky.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teamgyodong.myky.board.mapper.BoardMapper;
import teamgyodong.myky.board.model.board;
import teamgyodong.myky.board.model.comment;


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
			System.out.println("searchOption: " + map.get("searchOption"));
			System.out.println("keyword: " + map.get("keyword"));
			
			List<board> board = boardMapper.selectBoardList(map);			
			int count = boardMapper.selectBoardCnt(map);
			Map<String, Object> countMap = new HashMap<>();
			countMap.put("cnt", count);

			resultMap.put("count", countMap);
			resultMap.put("result", "success");			
			resultMap.put("board", board);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			

		}

		return resultMap;
	}
	//게시글 이미지 출력
	public void addBoardFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		
		boardMapper.insertBoardFile(map);
	}
	//게시글 상세보기
	public HashMap<String, Object> boardView(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		if(map.get("option").equals("View")) {

			boardMapper.updateCnt(map);
		}
		
		List<comment> cmtList = boardMapper.selectCmtList(map);
		List<board> boardList = boardMapper.selectBoard(map);
		board info = boardList.isEmpty() ? null : boardList.get(0);
		
		resultMap.put("info", info);
		resultMap.put("result", "success");
		resultMap.put("cmtList", cmtList);
		return resultMap;
	}
	//게시글 추가
	public HashMap<String, Object> boardAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.insertBoard(map);
		resultMap.put("boardId", map.get("boardId"));
		resultMap.put("result", "success");
		
		return null;
	}
	//게시글 수정
	public HashMap<String, Object> boardEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.updateBoard(map);
		resultMap.put("result", "success");
		
		return resultMap;
	}
	//게시글 삭제
	public HashMap<String, Object> boardRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int num = boardMapper.updateRemoveBoard(map);
		return null;
	}
	//댓글작성
	public HashMap<String, Object> CommentAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.insertComment(map);

		resultMap.put("result", "success");
		return null;
	}
	//댓글 수정 저장
	public HashMap<String, Object> commentUpdate(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.commentUpdate(map);

		resultMap.put("result", "success");
		return null;
	}
	//댓글 삭제
	public HashMap<String, Object> CommentRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		boardMapper.deleteComment(map);
		return null;
	}
	//댓글 수정
	public HashMap<String, Object> CommentEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		boardMapper.updateComment(map);
		return null;
	}
	//댓글 갯수
	public HashMap<String, Object> CommentCount(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<board> count = boardMapper.countComment(map);
		
		resultMap.put("count", count);
		resultMap.put("result","success");
		return resultMap;
	}
}
