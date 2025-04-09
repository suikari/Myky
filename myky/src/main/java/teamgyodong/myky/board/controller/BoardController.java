package teamgyodong.myky.board.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.Config.Common;
import teamgyodong.myky.board.dao.BoardService;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;
	//게시글 목록출력
	@RequestMapping("/board/list.do") 
    public String list(Model model) throws Exception{

        return "board/board-list";
    }
	//게시글 보기
	@RequestMapping("/board/view.do") 
	public String view(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception{
			
		request.setAttribute("map", map);
		
        return "board/board-view";
    }
	//게시글 추가
	@RequestMapping("/board/add.do") 
    public String add(Model model) throws Exception{

        return "board/board-add";
    }
	//게시글 수정
	@RequestMapping("/board/edit.do") 
    public String edit(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		
		request.setAttribute("map", map);
		
        return "board/board-edit";
    }
	//게시글 삭제
	@RequestMapping("/board/remove.do") 
	public String remove(Model model) throws Exception{

	    return "board/board-remove";
	}
	//FAQ 게시글 보기
	@RequestMapping("/board/FAQView.do") 
	public String FAQView(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception{
			
		request.setAttribute("map", map);
		
        return "board/board-FAQView";
    }
	//수의사 게시판 게시글리스트 주소
	@RequestMapping("/board/vetBoardList.do") 
    public String vetBoardList(Model model) throws Exception{

        return "board/board-vetBoardList";
    }
	//수의사 게시판 상세보기
	@RequestMapping("/board/vetBoardView.do") 
	public String vetBoardView(HttpServletRequest request, Model model,  @RequestParam HashMap<String, Object> map) throws Exception{
			
		request.setAttribute("map", map);
		
        return "board/board-vetBoardView";
    }
	//수의사 게시판 게시글 추가
	@RequestMapping("/board/vetBoardAdd.do") 
    public String vetBoardAdd(Model model) throws Exception{

        return "board/board-vetBoardAdd";
    }
	//수의사 게시판 게시글 수정
	@RequestMapping("/board/vetBoardEdit.do") 
    public String vetBoardEdit(HttpServletRequest request,Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		
		request.setAttribute("map", map);
		
        return "board/board-vetBoardEdit";
    }
	//게시글 목록출력
	@RequestMapping(value = "board/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getBoardList(map);
		
		return new Gson().toJson(resultMap);
	}
	//게시글 상세보기
	@RequestMapping(value = "board/view.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.boardView(map);
		
		return new Gson().toJson(resultMap);
	}
	//게시글 추가
	@RequestMapping(value = "board/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.boardAdd(map);
		
		return new Gson().toJson(resultMap);
	}
	//게시글 수정하기
	@RequestMapping(value = "board/edit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.boardEdit(map);
			
		return new Gson().toJson(resultMap); 
	}
	//게시글 삭제
	@RequestMapping(value = "/board/remove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String remove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			
			
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.boardRemove(map);
			
		return new Gson().toJson(resultMap); 
	}
	//댓글 작성
	@RequestMapping(value = "/board/CommentAdd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String CommentAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.CommentAdd(map);
		return new Gson().toJson(resultMap);
	}
	//댓글 삭제
	@RequestMapping(value = "/board/CommentRemove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String CommentRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		resultMap = boardService.CommentRemove(map);
		return new Gson().toJson(resultMap); 
	}
	//댓글 수정
	@RequestMapping(value = "/board/CommentEdit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String CommentEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		resultMap = boardService.CommentEdit(map);
		return new Gson().toJson(resultMap); 
	}
	//댓글 수정-저장
	@RequestMapping(value = "/board/comment/update.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String commentUpdate(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		resultMap = boardService.commentUpdate(map);
		return new Gson().toJson(resultMap); 
	}
	//댓글 갯수
	@RequestMapping(value = "/board/CommentCount.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String CommentCount(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		resultMap = boardService.CommentCount(map);
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
	}
	//파일업로드 기능 추가
	@RequestMapping("/fileUpload.dox")
	public String result(@RequestParam("file1") List<MultipartFile> files, @RequestParam("boardId") int boardId, HttpServletRequest request,HttpServletResponse response, Model model)
	{
			
			
		String url = null;
		String path="c:\\img";
			
		try {
				
			for(MultipartFile multi : files) {
				System.out.println(multi.getOriginalFilename());
					

				String uploadpath = path;
				String originalName = multi.getOriginalFilename();
				String extName = originalName.substring(originalName.lastIndexOf("."),originalName.length());
				long filesize = multi.getSize();
				String saveFileName = Common.genSaveFileName(extName);
					
				System.out.println("uploadpath : " + uploadpath);
				System.out.println("originalName : " + originalName);
				System.out.println("extensionName : " + extName);
				System.out.println("filesize : " + filesize);
				System.out.println("saveFileName : " + saveFileName);
				String path2 = System.getProperty("user.dir");
				System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");
				if(!multi.isEmpty()){
						
					File file = new File(path2 + "\\src\\main\\webapp\\img\\freeBoard", saveFileName);
					multi.transferTo(file);
					
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("fileName", saveFileName);
					map.put("filePath", "../img/freeBoard/" + saveFileName);
					map.put("originalName", originalName);
					map.put("fileExt", extName); //확장자
					map.put("fileSize", filesize);
					map.put("boardId", boardId);
						
				
					// insert 쿼리 실행
					boardService.addBoardFile(map);
					
					model.addAttribute("fileName", multi.getOriginalFilename());
					model.addAttribute("uploadPath", file.getAbsolutePath());
					
					//redirect==스프링 문법
					}
			}
			return "redirect:board/list.do";
		}catch(Exception e) {
			System.out.println(e);
		}
		return "redirect:board/list.do";
	}
	//첨부파일 삭제
	@RequestMapping(value = "/board/removeFile.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeFile(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
				
				
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.boardRemoveFile(map);
				
		return new Gson().toJson(resultMap);
	}
	
	//대댓글
	@RequestMapping(value = "/board/ReplyAdd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addReply(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
				
				
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.insertReply(map);
				
		return new Gson().toJson(resultMap);
	}
	
	//좋아요 싫어요 버튼 값 가져오기
	@RequestMapping(value = "/board/likeStatus.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String likeButton(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
				
				
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.selectLikeButton(map);
				
		return new Gson().toJson(resultMap);
	}
	//좋아요 버튼 status insert
	@RequestMapping(value = "board/addlikeCnt.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String insertLikeCnt(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.addlikeCnt(map);
		
		return new Gson().toJson(resultMap);
	}
	//좋아요 싫어요 버튼 삭제
	@RequestMapping(value = "/board/removelikeCnt.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String RemoveCnt(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
				
				
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.RemoveCnt(map);
				
		return new Gson().toJson(resultMap);
	}
	//좋아요 싫어요 작성
	@RequestMapping(value = "/board/addlikeCntBoard.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.addlikeCntBoard(map);
		return new Gson().toJson(resultMap);
	}
	//수의사 게시판 목록 출력
	@RequestMapping(value = "board/vetBoardList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String vetBoardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.vetBoardList(map);
		
		return new Gson().toJson(resultMap);
	}
	//수의사 게시글 상세보기
	@RequestMapping(value = "board/vetBoardView.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String vetBoardView(Model model, @RequestParam HashMap<String, Object> map) throws Exception {


		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.vetBoardView(map);
		
		return new Gson().toJson(resultMap);
	}
	//수의사 게시판 게시글 추가
	@RequestMapping(value = "board/vetBoardAdd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String vetBoardAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.vetBoardAdd(map);
		
		return new Gson().toJson(resultMap);
	}
	//수의사 게시글 수정하기
	@RequestMapping(value = "board/vetBoardEdit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String vetBoardEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.vetBoardEdit(map);
			
		return new Gson().toJson(resultMap); 
	}
	//수의사 게시글 삭제하기
	@RequestMapping(value = "/board/vetBoardRemove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String vetBoardRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			
			
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.vetBoardRemove(map);
			
		return new Gson().toJson(resultMap); 
	}
	//수의사 게시판 답글 작성
	@RequestMapping(value = "/board/vetBoardAnReply.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String vetBoardAnReply(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.vetBoardAnReply(map);
		return new Gson().toJson(resultMap);
	}
	//수의사 게시판 답글 수정
	@RequestMapping(value = "/board/vetBoardAnEdit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String vetBoardAnEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		resultMap = boardService.vetBoardAnEdit(map);
		return new Gson().toJson(resultMap); 
	}
	//수의사 게시판 답글 삭제
	@RequestMapping(value = "/board/vetBoardAnRemove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String vetBoardAnRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		resultMap = boardService.vetBoardAnRemove(map);
		return new Gson().toJson(resultMap);
	}
	//수의사 게시판 채택
	@RequestMapping(value = "/board/vetBoardAnSelect.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String vetBoardAnSelect(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.vetBoardAnSelect(map);
		return new Gson().toJson(resultMap);
	}
	//FAQ 게시글 목록 출력
	@RequestMapping(value = "board/FAQView.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String FAQList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.FAQView(map);

		return new Gson().toJson(resultMap);
	}
}
