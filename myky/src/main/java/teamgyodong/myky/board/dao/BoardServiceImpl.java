package teamgyodong.myky.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.Main.mapper.MainMapper;
import teamgyodong.myky.board.mapper.BoardMapper;
import teamgyodong.myky.board.model.board;
import teamgyodong.myky.board.model.boardFile;
import teamgyodong.myky.board.model.boardLikeLog;
import teamgyodong.myky.board.model.comment;
import teamgyodong.myky.board.model.vetAnswer;
import teamgyodong.myky.board.model.vetBoard;
import teamgyodong.myky.manager.model.order;
import teamgyodong.myky.manager.model.orderdetail;


@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper boardMapper;
	
	@Autowired // 세션용(중요! 유저 로그인 관련!)
	HttpSession session;
	
	@Autowired 
	MainMapper mainMapper;
	
	
	
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
			
			HashMap<String, Object> countMap = new HashMap<String, Object>();
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
	@Override
	//게시글 상세보기
	public HashMap<String, Object> boardView(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			if(map.get("option").equals("View")) {

				String boardId = (String) map.get("boardId");

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

		    board boardList = boardMapper.selectBoard(map); 
		    List<boardFile> fileList = boardMapper.selectBoardImg(map);

		    resultMap.put("info", boardList);
		    resultMap.put("fileList", fileList);
		    resultMap.put("cmtList", cmtList); // 여기에 대댓글이 포함됨
		    resultMap.put("result", "success");

		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
			
		}
		
	    return resultMap;
	}
	@Override
	//게시글 이미지 출력
	public void addBoardFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			boardMapper.insertBoardFile(map);	
			
			resultMap.put("result","success");
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
		}
	}
	@Override
	//게시글 추가
	public HashMap<String, Object> boardAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			
			int count = boardMapper.insertBoard(map);
			
			
			if (count == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			
			resultMap.put("boardId", map.get("boardId"));
			resultMap.put("result", "success");			
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
		}		
		
		return resultMap;
	}
	@Override
	//게시글 수정
	public HashMap<String, Object> boardEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int count = boardMapper.updateBoard(map);
			
			if (count == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			
			resultMap.put("result", "success");
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
		}
		
		
		return resultMap;
	}
	@Override
	//게시글 삭제
	public HashMap<String, Object> boardRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int num = boardMapper.updateRemoveBoard(map);
			
			if (num == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
		}
		
		return resultMap;
	}
	@Override
	//댓글 작성
	public HashMap<String, Object> CommentAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			
			int count = boardMapper.insertComment(map);			
			int Noticount = mainMapper.insertNotification(map);
			
			if (count == 0 || Noticount == 0 ) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			
			resultMap.put("count", count);
			resultMap.put("Noticount", Noticount);
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
		}
		
		resultMap.put("result", "success");
		return resultMap;
	}
	@Override
	//댓글 수정 저장
	public HashMap<String, Object> commentUpdate(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int count = boardMapper.commentUpdate(map);
			
			if (count == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			
			resultMap.put("count", count);
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
		}

		resultMap.put("result", "success");
		return resultMap;
	}
	@Override
	//댓글 삭제
	public HashMap<String, Object> CommentRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int count = boardMapper.deleteComment(map);
			
			if (count == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
		}
		return resultMap;
	}
	@Override
	//댓글 수정
	public HashMap<String, Object> CommentEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int count = boardMapper.updateComment(map);
			
			if (count == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
		}
		return resultMap;
	}
	@Override
	//댓글 갯수
	public HashMap<String, Object> CommentCount(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<board> count = boardMapper.countComment(map);
			
			if (count.isEmpty()) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			resultMap.put("count", count);
			resultMap.put("result","success");
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
		}
		
		return resultMap;
	}
	@Override
	//파일 삭제
	public HashMap<String, Object> boardRemoveFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int num = boardMapper.deleteFile(map);
			
			if (num == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
		}
		
		return resultMap;
	}
	@Override
	//대댓글 구현
	public  HashMap<String, Object> insertReply(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		try {
			boardMapper.insertReply(map);
		    int num = mainMapper.insertNotification(map);
		    
		    if (num == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
		    
		    resultMap.put("result", "success");
			resultMap.put("num", "num");
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
			
		} 
	    return resultMap;
	}
	@Override
	//좋아요 버튼 기록 출력 (userId)
	public HashMap<String, Object> selectLikeButton(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			boardLikeLog listStatus = boardMapper.selectLike(map);
			
			if(listStatus != null) {
				resultMap.put("result", "success");
			} else {
				resultMap.put("result", "fail");
			}
			resultMap.put("listStatus", listStatus);
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");
			
		} 		
		return resultMap;
	}
	
	@Override
	//좋아요 버튼 status insert
	public HashMap<String, Object> addlikeCnt(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int num = boardMapper.deleteStatus(map);
			int insertSatus = boardMapper.insertLikelog(map);
			
			if (num == 0 || insertSatus == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			resultMap.put("listSatus", insertSatus);
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");			
		} 

		return resultMap;
	}
	@Override
	//좋아요 버튼 status 삭제
	public HashMap<String, Object> RemoveCnt(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int num = boardMapper.deleteStatus(map);
			
			if (num == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			resultMap.put("listSatus", num);
			
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");			
		} 
		
		return resultMap;

	}
	@Override
	//좋아요 갯수 DB저장
	public HashMap<String, Object> addlikeCntBoard(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int num = boardMapper.updatelikeCntBoard(map);
			
			if (num == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			resultMap.put("num", num);
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result","fail");			
		} 
		return resultMap;
	}
	@Override
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
			if(vetBoard != null) {
				
				resultMap.put("result", "success");			
			}else {
				resultMap.put("result", "fail");
			}
			
			resultMap.put("vetBoard", vetBoard);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			

		}
		
		return resultMap;
	}	
	@Override
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
			//List<vetAnswer> vetRatings = boardMapper.selectVetRating(map);

						
		    for (vetAnswer detail : answerList) {
		        map.put("vetId", detail.getVetId()); // 댓글 ID → 대댓글 검색용
		        List<vetAnswer> replies = boardMapper.selectVetRating(map);
		        detail.setVetAnswerdetail(replies); // 💥 replies를 comment 객체에 직접 세팅
		    }

			if(vetboard != null) {
				resultMap.put("result", "success");			
			}else {
				resultMap.put("result", "fail");
			}
			
			resultMap.put("info", vetboard);
			resultMap.put("answerList", answerList);

			
		}catch (Exception e){
			 e.printStackTrace();
			 resultMap.put("result", "fail");
		}
		return resultMap;
	}
	@Override
	//수의사 게시글 추가
	public HashMap<String, Object> vetBoardAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int num = boardMapper.insertVetBoard(map);
			
			if (num == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			resultMap.put("num", num);
			
			resultMap.put("vetBoardId", map.get("vetBoardId"));
			resultMap.put("result", "success");
		}catch (Exception e){
			 e.printStackTrace();
			 resultMap.put("result", "fail");
		}
		
		
		return resultMap;
	}
	@Override
	//수의사 게시글 수정
	public HashMap<String, Object> vetBoardEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int num = boardMapper.updateVetBoard(map);
			
			if (num == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			resultMap.put("num", num);
			resultMap.put("result", "success");
			
		}catch (Exception e){
			 e.printStackTrace();
			 resultMap.put("result", "fail");
		}		
		return resultMap;
	}
	@Override
	//수의사 게시글 삭제
	public HashMap<String, Object> vetBoardRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int num = boardMapper.updateRemoveVetBoard(map);
			
			if (num == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			resultMap.put("num", num);
			resultMap.put("result", "success");
			
		}catch (Exception e){
			 e.printStackTrace();
			 resultMap.put("result", "fail");
		}
		return resultMap;
	}
	@Override
	//수의사 답변 작성
	public HashMap<String, Object> vetBoardAnReply(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int count = boardMapper.checkDuplicateVetAnswer(map);
			
			if (count > 0) {
				resultMap.put("status", "fail");
				resultMap.put("message", "이미 답변을 작성했습니다.");
				return resultMap;
			}
			int num = boardMapper.insertVetAnReply(map);
			int Noticount = mainMapper.insertNotification(map);
			
			resultMap.put("num", num);
			resultMap.put("Noticount", Noticount);
			resultMap.put("result", "success");
			
		}catch (Exception e){
			 e.printStackTrace();
			 resultMap.put("result", "fail");
		}

		return resultMap;
	}
	@Override
	//수의사 게시판 답변 수정
	public HashMap<String, Object> vetBoardAnEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int num = boardMapper.updateAnEdit(map);
			if (num == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			resultMap.put("num", num);
			
		}catch (Exception e){
			 e.printStackTrace();
			 resultMap.put("result", "fail");
		}

		return resultMap;
	}
	@Override
	//수의사 답변 삭제
	public HashMap<String, Object> vetBoardAnRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int num = boardMapper.deleteVetBoardAn(map);
			
			if (num == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			resultMap.put("num", num);
			
		}catch (Exception e){
			 e.printStackTrace();
			 resultMap.put("result", "fail");
		}

		return resultMap;
		
	}
	@Override
	//수의사 답변 채택
	public HashMap<String, Object> vetBoardAnSelect(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int Noticount = mainMapper.insertNotification(map);
			
			if (Noticount == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			resultMap.put("Noticount", Noticount);
			
			boardMapper.updateVetAnSelect(map);
			boardMapper.updateVetBoardStats(map);
			resultMap.put("result", "success");
			
		}catch (Exception e){
			 e.printStackTrace();
			 resultMap.put("result", "fail");
		}		
		return resultMap;
	}
	@Override
	//FQA 게시글 보기
	public HashMap<String, Object> FAQView(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<board> menu = boardMapper.selectBoardList(map);
			int count = boardMapper.selectBoardCnt(map);
			
			if (count == 0) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			
			Map<String, Object> countMap = new HashMap<>();		
			countMap.put("cnt", count);
			
			resultMap.put("count", countMap);
			resultMap.put("menu", menu);
			resultMap.put("result", "success");
			
		}catch (Exception e){
			 e.printStackTrace();
			 resultMap.put("result", "fail");
		}		
		
		return resultMap;
	}
	
}
	