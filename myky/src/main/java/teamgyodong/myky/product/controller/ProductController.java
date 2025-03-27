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

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import teamgyodong.myky.Config.Common;
import teamgyodong.myky.product.dao.ProductService;


@Controller
public class ProductController {


	@Autowired
	ProductService productService;
	
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
		
		return "product/product-review";
	}
	//리뷰 수정
	@RequestMapping("/product/reviewEdit.do") 
    public String reviewEdit(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
	
		return "product/product-reviewEdit"; 
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
	//리뷰 가져오기
	@RequestMapping(value = "/product/reviewCnt.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String getreview(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.getReviewCnt(map);
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
	
	
	// 첨부파일
	@RequestMapping("/Review/fileUpload.dox")
	public String result(@RequestParam("file1") List<MultipartFile> files, @RequestParam("reviewId") int reviewId,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		
		String url = null;
		String path = "c:\\img";	
		try {
			
			for(MultipartFile multi : files) {
			// String uploadpath = request.getServletContext().getRealPath(path);
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
				map.put("thumbYn", "Y");

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



