package teamgyodong.myky.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.board.mapper.BoardMapper;
import teamgyodong.myky.board.model.board;
import teamgyodong.myky.board.model.boardFile;
import teamgyodong.myky.board.model.boardLikeLog;
import teamgyodong.myky.board.model.comment;
import teamgyodong.myky.board.model.vetAnswer;
import teamgyodong.myky.board.model.vetBoard;


@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper boardMapper;
	
	@Autowired // 세션용(중요! 유저 로그인 관련!)
	HttpSession session;
	
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
	//게시글 상세보기
	public HashMap<String, Object> boardView(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		if(map.get("option").equals("View")) {

		    String boardId = (String) map.get("boardId");
		    String category = (String) map.get("category");

		    // 1. 세션 기반 조회수 중복 방지 처리
		    String sessionKey = "viewedBoard_" + boardId;

		    if (session.getAttribute(sessionKey) == null) {
		        boardMapper.updateCnt(map); // 조회수 1 증가
		        session.setAttribute(sessionKey, true); // 세션에 기록
		    }
		    
		}
		
	    List<comment> cmtList = boardMapper.selectCmtList(map);

	    for (comment comment : cmtList) {
	        map.put("parentId", comment.getCommentId()); // 댓글 ID → 대댓글 검색용
	        List<comment> replies = boardMapper.selectParentCmtList(map);
	        comment.setReplies(replies); // 💥 replies를 comment 객체에 직접 세팅
	    }

	    List<board> boardList = boardMapper.selectBoard(map);
	    List<boardFile> fileList = boardMapper.selectBoardImg(map);
	    board info = boardList.isEmpty() ? null : boardList.get(0);

	    resultMap.put("info", info);
	    resultMap.put("fileList", fileList);
	    resultMap.put("cmtList", cmtList); // 여기에 대댓글이 포함됨
	    resultMap.put("result", "success");

	    return resultMap;
	}
	//게시글 이미지 출력
	public void addBoardFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.insertBoardFile(map);

	}
	//게시글 추가
	public HashMap<String, Object> boardAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.insertBoard(map);
		resultMap.put("boardId", map.get("boardId"));
		resultMap.put("result", "success");
		
		return resultMap;
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
		return resultMap;
	}
	//댓글 작성
	public HashMap<String, Object> CommentAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.insertComment(map);

		resultMap.put("result", "success");
		return resultMap;
	}
	//댓글 수정 저장
	public HashMap<String, Object> commentUpdate(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.commentUpdate(map);

		resultMap.put("result", "success");
		return resultMap;
	}
	//댓글 삭제
	public HashMap<String, Object> CommentRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.deleteComment(map);
		return resultMap;
	}
	//댓글 수정
	public HashMap<String, Object> CommentEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.updateComment(map);
		return resultMap;
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
	//파일 삭제
	public HashMap<String, Object> boardRemoveFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int num = boardMapper.deleteFile(map);
		return resultMap;
	}
	//대댓글 구현
	public void insertReply(Map<String, Object> map) {
	    boardMapper.insertReply(map);
	}
	//좋아요 버튼 기록 출력 (userId)
	public HashMap<String, Object> selectLikeButton(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		boardLikeLog listStatus = boardMapper.selectLike(map);

		if(listStatus != null) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		resultMap.put("listStatus", listStatus);
		return resultMap;
	}
	
	@Override
	//좋아요 버튼 status insert
	public HashMap<String, Object> addlikeCnt(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		int num = boardMapper.deleteStatus(map);

		int insertSatus = boardMapper.insertLikelog(map);
		
		resultMap.put("listSatus", insertSatus);
		return resultMap;
	}
	//좋아요 버튼 status 삭제
	public HashMap<String, Object> RemoveCnt(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int num = boardMapper.deleteStatus(map);
		
		resultMap.put("listSatus", num);
		return resultMap;

	}
	//좋아요 갯수 DB저장
	public HashMap<String, Object> addlikeCntBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		boardMapper.updatelikeCntBoard(map);
		return resultMap;
	}
	//수의사 게시판 목록 출력
	public HashMap<String, Object> vetBoardList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String result = "";
		
		try {
			System.out.println("searchOption: " + map.get("searchOption"));
			System.out.println("keyword: " + map.get("keyword"));
			
			List<vetBoard> vetBoard = boardMapper.selectVetBoardList(map);			
						
			int count = boardMapper.selectVetBoardCnt(map);
			
			Map<String, Object> countMap = new HashMap<>();
			countMap.put("cnt", count);

			resultMap.put("count", countMap);
			resultMap.put("result", "success");			
			resultMap.put("vetBoard", vetBoard);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			

		}

		return resultMap;
	}
	//수의사 게시글 상세보기
	public HashMap<String, Object> vetBoardView(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		if(map.get("option").equals("View")) {

		    String vetBoardId = (String) map.get("vetBoardId");

		    // 1. 세션 기반 조회수 중복 방지 처리
		    String sessionKey = "viewedBoard_" + vetBoardId;

		    if (session.getAttribute(sessionKey) == null) {
		        boardMapper.updateVetBoardCnt(map); // 조회수 1 증가
		        session.setAttribute(sessionKey, true); // 세션에 기록
		    }
		    
		}

		
		try {
			vetBoard vetboard = boardMapper.selectVetBoard(map);
			List<vetAnswer> answerList = boardMapper.selectVetAnList(map);
			
			resultMap.put("info", vetboard);
			resultMap.put("answerList", answerList);
			resultMap.put("result", "success");
		}catch (Exception e){
			 e.printStackTrace();
			 resultMap.put("result", "fail");

		}
		return resultMap;
	}
	//수의사 게시글 추가
	public HashMap<String, Object> vetBoardAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		boardMapper.insertVetBoard(map);
		
		resultMap.put("vetBoardId", map.get("vetBoardId"));
		resultMap.put("result", "success");
		
		return resultMap;
	}
	//수의사 게시글 수정
	public HashMap<String, Object> vetBoardEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.updateVetBoard(map);
		resultMap.put("result", "success");
		
		return resultMap;
	}
	//수의사 게시글 삭제
	public HashMap<String, Object> vetBoardRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int num = boardMapper.updateRemoveVetBoard(map);
		return resultMap;
	}
	//수의사 답변 작성
	public HashMap<String, Object> vetBoardAnReply(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
	    int count = boardMapper.checkDuplicateVetAnswer(map);

	    if (count > 0) {
	    	resultMap.put("status", "fail");
	    	resultMap.put("message", "이미 답변을 작성했습니다.");
	        return resultMap;
	    }
		boardMapper.insertVetAnReply(map);

		resultMap.put("result", "success");
		return resultMap;
	}
	//수의사 게시판 답변 수정
	public HashMap<String, Object> vetBoardAnEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.updateAnEdit(map);
		return resultMap;
	}
	//수의사 답변 삭제
	public HashMap<String, Object> vetBoardAnRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int num = boardMapper.deleteVetBoardAn(map);

		return resultMap;
		
	}
	//수의사 답변 채택
	public HashMap<String, Object> vetBoardAnSelect(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boardMapper.updateVetAnSelect(map);
		boardMapper.updateVetBoardStats(map);
		resultMap.put("result", "success");
		return resultMap;
	}
}
	