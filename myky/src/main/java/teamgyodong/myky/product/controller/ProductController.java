package teamgyodong.myky.product.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import teamgyodong.myky.Config.Common;
import teamgyodong.myky.product.dao.ProductService;
import teamgyodong.myky.product.mapper.ProductMapper;
import teamgyodong.myky.product.model.Product;
import teamgyodong.myky.product.model.Qna;
import teamgyodong.myky.product.model.Review;


@Controller
public class ProductController {


	@Autowired
	ProductService productService;
	@Autowired
	ProductMapper productMapper;
	
	//상품 리스트 가져오기
	@RequestMapping("/product/list.do") 
    public String list(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		
		return "product/product-list"; 
	}
	
	//상품 세부사항 가져오기
	@RequestMapping("/product/view.do") 
    public String view(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		
		return "product/product-view"; 
    }
	
	//상품 리뷰 등록
	@RequestMapping("/product/review.do")
	public String review(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) {
		// 세션에서 로그인 여부 확인
	    String sessionId = (String) request.getSession().getAttribute("sessionId");

	    if (sessionId == null || sessionId.isEmpty()) {
	        // 로그인 안 되어 있으면 로그인 페이지로 리다이렉트
	        return "redirect:/user/login.do";
	    }

	    model.addAttribute("productId", map.get("productId"));
		
		return "product/product-review";
	}
	//리뷰 수정
	@RequestMapping("/product/reviewEdit.do") 
    public String reviewEdit(HttpServletRequest request, Model model,RedirectAttributes redirectAttributes, @RequestParam HashMap<String, Object> map) throws Exception{
		
		String sessionId = (String) request.getSession().getAttribute("sessionId");
	    String productId = (String) map.get("productId");
	    String reviewId = (String) map.get("reviewId");
		
	    // 1. 로그인 안 된 경우
	    if (sessionId == null || sessionId.isEmpty()) {
	    	redirectAttributes.addFlashAttribute("alertMessage", "로그인 후 이용해주세요.");
	        return "redirect:/user/login.do";
	    }
	    // 2. 리뷰 데이터 가져오기
	    HashMap<String, Object> param = new HashMap<>();
	    param.put("reviewId", reviewId);
	    Review review = productService.getReviewById(param);  // 리뷰 하나 조회하는 서비스 필요

	    // 3. 존재하지 않는 리뷰 or 작성자 불일치
	    if (review == null || !sessionId.equals(review.getUserId())) {
	    	redirectAttributes.addFlashAttribute("alertMessage", "본인만 수정할 수 있습니다.");
	        return "redirect:/product/view.do?productId=" + productId;
	    }
	    // 4. 본인일 때만 수정 페이지 접근 허용
	    model.addAttribute("productId", productId);
	    model.addAttribute("reviewId", reviewId);
	    
		return "product/product-reviewEdit"; 
    }
	
	//상품 문의 글쓰기
	@RequestMapping("/product/qnawrite.do")
	public String qnawrite(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) {
		// 세션에서 로그인 여부 확인
	    String sessionId = (String) request.getSession().getAttribute("sessionId");

	    if (sessionId == null || sessionId.isEmpty()) {
	        // 로그인 안 되어 있으면 로그인 페이지로 리다이렉트
	        return "redirect:/user/login.do";
	    }

	    model.addAttribute("productId", map.get("productId"));
		return "product/product-qna";
	}
	//상품 문의 글 수정
	@RequestMapping("/product/qnaEdit.do") 
    public String qnaEdit(HttpServletRequest request, Model model,RedirectAttributes redirectAttributes, @RequestParam HashMap<String, Object> map) throws Exception{
		String sessionId = (String) request.getSession().getAttribute("sessionId");
	    String productId = (String) map.get("productId");
	    String qnaId = (String) map.get("qnaId");
	    
	    // 1. 로그인 확인
	    if (sessionId == null || sessionId.isEmpty()) {
	        redirectAttributes.addFlashAttribute("alertMessage", "로그인 후 이용해주세요.");
	        return "redirect:/user/login.do";
	    }

	    // 2. QnA 글 가져오기 (서비스에서)
	    HashMap<String, Object> param = new HashMap<>();
	    param.put("qnaId", qnaId);
	    Qna qna = productService.getQnaById(param);  // 이 메서드 추가 필요!
    	System.out.println("rerr");

	    // 3. QnA가 없거나 작성자 불일치
    	if (qna == null || 
    		    !sessionId.equals(qna.getUserId()) || 
    		    !productId.trim().equals(qna.getProductId().trim())
    		) {
    		    System.out.println("eerr");
    		    redirectAttributes.addFlashAttribute("alertMessage", "본인만 수정할 수 있습니다.");
    		    return "redirect:/product/view.do?productId=" + productId;
    		}


	    // 4. 본인일 경우에만 수정 허용
	    model.addAttribute("productId", productId);
	    model.addAttribute("qnaId", qnaId);
	    
		return "product/product-qnaEdit"; 
    }
	
	
	//상품 리스트 호출
	@RequestMapping(value = "/product/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.getProductList(map);
		return new Gson().toJson(resultMap);
	}
	
	//상품 가져오기
	@RequestMapping(value = "/product/get.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String get(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.getProduct(map);
		return new Gson().toJson(resultMap);
	}
	
	//리뷰 글쓰기
	@RequestMapping(value = "/product/add.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String reviewAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.addReview(map);
		return new Gson().toJson(resultMap);
	}

	//리뷰 리스트 가져오기
	@RequestMapping(value = "/product/reviewList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String review(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.getReviewList(map);
		return new Gson().toJson(resultMap);
	}
		
	//리뷰글 삭제
	@RequestMapping(value = "/product/reviewRemove.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String reviewRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.reviewRemove(map);
		return new Gson().toJson(resultMap);
	}
	//리뷰글 수정
	@RequestMapping(value = "/product/reviewEdit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String Reviewedit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.reviewEdit(map);
		return new Gson().toJson(resultMap);
	}
	//리뷰 하나만 가져오기
	@RequestMapping(value = "/product/getReview.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getReview(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.getReview(map);
		return new Gson().toJson(resultMap);
	}
	//리뷰 도움체크
	@RequestMapping(value = "/product/reviewHelpCnt.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String helpCnt(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.markHelpful(map);
		return new Gson().toJson(resultMap);
	}
	
	// 상품 구매 여부 확인
	@RequestMapping(value = "/product/checkPurchase.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String checkProductPurchase(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
	    HashMap<String, Object> resultMap = productService.checkPurchaseForReview(map);
	    return new Gson().toJson(resultMap);
	}

	//QnA
	@RequestMapping(value = "/product/qnaList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getQnAList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.getQnAList(map);
		return new Gson().toJson(resultMap);
	}
	
	//QnA 글쓰기
	@RequestMapping(value = "/product/qna.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String qnaAdd(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.addQna(map);
		return new Gson().toJson(resultMap);
	}
	//QnA 글 삭제
	@RequestMapping(value = "/product/qnaDelete.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String qnaRemove(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.qnaRemove(map);
		return new Gson().toJson(resultMap);
	}
	//QnA 글 수정
	@RequestMapping(value = "/product/qnaEdit.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String QnaEdit(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.qnaEdit(map);
		return new Gson().toJson(resultMap);
	}
	//QnA 하나만 가져오기
	@RequestMapping(value = "/product/getQna.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getQna(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.getQna(map);
		return new Gson().toJson(resultMap);
	}
	
	// 첨부파일
	@RequestMapping("/Review/fileUpload.dox")
	public String result(@RequestParam("file1") List<MultipartFile> files, @RequestParam("reviewId") int reviewId,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		
		String url = null;
		String path = "c:\\img";	
		try {
			
			for(MultipartFile multi : files) {
			String uploadpath = path;
			String fileOrgname = multi.getOriginalFilename();
			String extName = fileOrgname.substring(fileOrgname.lastIndexOf("."), fileOrgname.length());
			long size = multi.getSize();
			String saveFileName = Common.genSaveFileName(extName);

			System.out.println("uploadpath : " + uploadpath);
			System.out.println("fileOrgname : " + fileOrgname);
			System.out.println("fileEtc : " + extName);
			System.out.println("fileSize : " + size);
			System.out.println("saveFileName : " + saveFileName);
			String path2 = System.getProperty("user.dir");
			System.out.println("Working Directory = " + path2 + "\\src\\webapp\\img");
		
			if (!multi.isEmpty()) {
				File file = new File(path2 + "\\src\\main\\webapp\\img\\product\\Review", saveFileName);
				multi.transferTo(file);

				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("reviewId", reviewId);
				map.put("filePath", "../img/product/Review/" + saveFileName);
				map.put("fileName",  saveFileName);
				map.put("fileOrgname", fileOrgname);
				map.put("fileSize",size);
				map.put("fileEtc", extName); 
				
				int thumbConut = productMapper.selectReviewThumb(map);
				
				if (thumbConut < 1) {
					map.put("thumbYn", "Y");
				} else {
					map.put("thumbYn", "N");
				}
				productService.addReviewFile(map);
				
				model.addAttribute("fileName", multi.getOriginalFilename());
				model.addAttribute("uploadPath", file.getAbsolutePath());
				}
			}
			return "redirect:/product/view.do";
		} catch (Exception e) {
			System.out.println(e);
		}
		return "redirect:/product/view.do";
		}

}

