package teamgyodong.myky.board.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.ssl.SslProperties.Bundles.Watch.File;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import teamgyodong.myky.Config.Common;
import teamgyodong.myky.board.dao.BoardService;

@Controller
public class BoardControlloer {

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
	//게시글 목록출력
	@RequestMapping(value = "board/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {

		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = boardService.getBoardList(map);
		
		return new Gson().toJson(resultMap);
	}
	//게시글 보기
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
			
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
		//return new Gson().toJson(resultMap);
	}
	//댓글 작성
	@RequestMapping(value = "/board/CommentAdd.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String CommentAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = boardService.CommentAdd(map);
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
	}
	//댓글 삭제
	@RequestMapping(value = "/board/CommentRemove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String CommentRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		resultMap = boardService.CommentRemove(map);
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
	}
	//댓글 수정
	@RequestMapping(value = "/board/CommentEdit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String CommentEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
			
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		resultMap = boardService.CommentEdit(map);
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
	}
	//댓글 수정-저장
	@RequestMapping(value = "/board/comment/update.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String commentUpdate(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
			
		resultMap = boardService.commentUpdate(map);
		return new Gson().toJson(resultMap); //map을 json형태로 바꿔주는 함수다
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
		public String result(@RequestParam("file1") List<MultipartFile> files, @RequestParam("boardNo") int boardNo, HttpServletRequest request,HttpServletResponse response, Model model)
		{
//			System.out.println(multi.size());O
			
			
			String url = null;
			String path="c:\\img";
			
			try {
				
				for(MultipartFile multi : files) {
					System.out.println(multi.getOriginalFilename());
					

					String uploadpath = path;
					String originFilename = multi.getOriginalFilename();
					String extName = originFilename.substring(originFilename.lastIndexOf("."),originFilename.length());
					long size = multi.getSize();
					String saveFileName = Common.genSaveFileName(extName);
					
					System.out.println("uploadpath : " + uploadpath);
					System.out.println("originFilename : " + originFilename);
					System.out.println("extensionName : " + extName);
					System.out.println("size : " + size);
					System.out.println("saveFileName : " + saveFileName);
					String path2 = System.getProperty("user.dir");
					System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");
					if(!multi.isEmpty()){
						
//						File file = new File(path2 + "\\src\\main\\webapp\\img\\freeBoard", saveFileName);
//						multi.transferTo(file);
						
						HashMap<String, Object> map = new HashMap<String, Object>();
						map.put("filename", saveFileName);
						map.put("path", "../img/" + saveFileName);
						map.put("originFilename", originFilename);
						map.put("extName", extName); //확장자
						map.put("size", size);
						map.put("boardNo", boardNo);
						
				
						// insert 쿼리 실행
						boardService.addBoardFile(map);
						
						model.addAttribute("filename", multi.getOriginalFilename());
//						model.addAttribute("uploadPath", file.getAbsolutePath());
						
						//redirect==스프링 문법
						}
				}
				return "redirect:board/list.do";
			}catch(Exception e) {
				System.out.println(e);
			}
			return "redirect:board/list.do";
		}

}
