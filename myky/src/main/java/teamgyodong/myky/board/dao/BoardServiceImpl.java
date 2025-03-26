package teamgyodong.myky.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teamgyodong.myky.board.mapper.BoardMapper;
import teamgyodong.myky.board.model.board;
import teamgyodong.myky.board.model.boardFile;
import teamgyodong.myky.board.model.boardLikeLog;
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
	//파일 삭제
	public HashMap<String, Object> boardRemoveFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int num = boardMapper.deleteFile(map);
		return null;
	}
	//대댓글 구현
	public void insertReply(Map<String, Object> map) {
	    boardMapper.insertReply(map);
	}
	//좋아요 싫어요 구현
//	public HashMap<String, Object> toggleLike(HashMap<String, Object> map) {
//	    HashMap<String, Object> resultMap = new HashMap<>();
//
//	    String boardId = (String) map.get("boardId");
//	    String userId = (String) map.get("userId");
//	    String type = (String) map.get("type"); //like, dislike
//	    
//	    // BoardLikeLog 객체로 설정
//	    boardLikeLog boardLikeLog = new BoardLikeLog();
//	    boardLikeLog.setBoardId(boardId);
//	    boardLikeLog.setUserId(userId);
//	    boardLikeLog.setStatus(type);  // like / dislike
//	    
//	    String currentStatus = boardMapper.getUserLikeStatus(boardLikeLog);
//	    
//	    // 상태에 맞게 처리
//	    if (currentStatus != null && currentStatus.equals(type)) {
//	        // 이미 눌렀으면 취소 (DB에서 카운트 -1, 상태 초기화)
//	        if (type.equals("like")) {
//	            boardMapper.updateLikeCount(boardId, -1);
//	        } else {
//	            boardMapper.updateDislikeCount(boardId, -1);
//	        }
//	        boardMapper.deleteUserLikeStatus(map); // 로그에서 상태 삭제
//	    } else {
//	        // 새로 눌렀거나 반대 눌렀으면
//	        if (type.equals("like")) {
//	            boardMapper.updateLikeCount(boardId, 1);  // 좋아요 +1
//	            if (currentStatus != null && currentStatus.equals("dislike")) {
//	                boardMapper.updateDislikeCount(boardId, -1);  // 반대가 눌렸으면 싫어요 -1
//	            }
//	        } else {
//	            boardMapper.updateDislikeCount(boardId, 1);  // 싫어요 +1
//	            if (currentStatus != null && currentStatus.equals("like")) {
//	                boardMapper.updateLikeCount(boardId, -1);  // 좋아요가 눌렸으면 좋아요 -1
//	            }
//	        }
//	        boardMapper.insertUserLikeStatus(map);  // 로그에 상태 저장
//	    }
//
//	    // 현재 좋아요/싫어요 카운트 가져오기
//	    int likeCount = boardMapper.getLikeCount(boardId);
//	    int dislikeCount = boardMapper.getDislikeCount(boardId);
//
//	    // 결과 맵에 담기
//	    resultMap.put("likeCount", likeCount);
//	    resultMap.put("dislikeCount", dislikeCount);
//	    resultMap.put("myStatus", boardMapper.getUserLikeStatus(map));  // 현재 세션 상태
//
//	    return resultMap;
//	}
	
}
	