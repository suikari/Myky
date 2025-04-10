package teamgyodong.myky.manager.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.Config.Common;
import teamgyodong.myky.manager.dao.ManagerService;


@Controller
public class ManagerController {
	
	@Autowired
	ManagerService managerService;
	
	@RequestMapping("manager/main.do") 
    public String main(HttpServletRequest request, HttpSession session, Model model ,RedirectAttributes redirectAttributes) throws Exception{
		
		
		String sessionId = (String) session.getAttribute("sessionId");
		 
		 if (sessionId == null) {
	            // Flash 속성을 사용하여 alert 메시지 전달
	            redirectAttributes.addFlashAttribute("alertMessage", "비정상적인 접근입니다.");
	            return "redirect:/main.do"; // 로그인 페이지로 이동
	     } 
		 
	        return "manager/index";

		
    }
	
	// centerList
	@RequestMapping(value = "/admin/mainList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String mainList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectMainList(map);
		return new Gson().toJson(resultMap);
	}
    
	// centerList
	@RequestMapping(value = "/admin/cmtList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String cmtList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectAllCmtList(map);
		return new Gson().toJson(resultMap);
	}
    
	// centerList
	@RequestMapping(value = "/admin/memberList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String memberList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectAllUserList(map);
		return new Gson().toJson(resultMap);
	}
    
	// centerList
	@RequestMapping(value = "/admin/searchList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String searchList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectSearchRanking(map);
		return new Gson().toJson(resultMap);
	}
	
	// centerList
	@RequestMapping(value = "/admin/notVetList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String notVetList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectAllnotVetList(map);
		return new Gson().toJson(resultMap);
	}
	
	// centerList
	@RequestMapping(value = "/admin/membershipList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String membershipList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectAllMembershipList(map);
		return new Gson().toJson(resultMap);
	}
	
	// centerList
	@RequestMapping(value = "/admin/boardList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String boardList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectAllBoardList(map);
		return new Gson().toJson(resultMap);
	}
	
	// centerList
	@RequestMapping(value = "/admin/productList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String productList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectAllProductList(map);
		return new Gson().toJson(resultMap);
	}
	
	
	// centerList
	@RequestMapping(value = "/admin/LogList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String LogList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectLogBrowserList(map);
		return new Gson().toJson(resultMap);
	}
	
	// centerList
	@RequestMapping(value = "/admin/fristBuyer.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String fristBuyer(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectLogFristJoinBuy(map);
		return new Gson().toJson(resultMap);
	}
	
	// centerList
	@RequestMapping(value = "/admin/membershipVal.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String membershipVal(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectMembershipVal(map);
		return new Gson().toJson(resultMap);
	}
	
	
	// centerList
	@RequestMapping(value = "/admin/VetList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String VetList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = managerService.selectAllVetList(map);
		return new Gson().toJson(resultMap);
	}
	
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/remove-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		System.out.println(list);
		
		resultMap = managerService.deleteBoardList(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/remove-cmt-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeCmtList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		System.out.println(list);
		
		resultMap = managerService.deleteBoardCmtList(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/remove-partner-list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removePartnerList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("selectList").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> list = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("list", list);
		System.out.println(list);
		
		resultMap = managerService.deletePartnerList(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/deleteVet.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deleteVet(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.deleteVet(map);
		return new Gson().toJson(resultMap);
	}
	
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/updateUser.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String updateUser(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.updateUser(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/updateVet.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String updateVet(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.updateVet(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/updateProduct.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String updateProduct(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.updateProduct(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/updateOrder.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String updateOrder(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.updateOrder(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/updateOrderDetail.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String updateOrderDetail(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.updateOrderDetail(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/updatePartnerDetail.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String updatePartnerDetail(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.updatePartnerDetail(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/insertVet.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String insertVet(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.insertVet(map);
		return new Gson().toJson(resultMap);
	}
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/insertBoard.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String insertBoard(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.insertBoard(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/insertProduct.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String insertProduct(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.insertProduct(map);
		return new Gson().toJson(resultMap);
	}
	
	
	// 게시글 여러개 삭제
	@RequestMapping(value = "/admin/insertPartnerDetail.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String insertPartnerDetail(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.insertPartnerDetail(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 한개 선택
	@RequestMapping(value = "/admin/selectProduct.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String selectProduct(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.selectProduct(map);
		return new Gson().toJson(resultMap);
	}
	
	

	// 게시글 한개 선택
	@RequestMapping(value = "/admin/deleteProduct.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deleteProduct(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.deleteProduct(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 한개 선택
	@RequestMapping(value = "/admin/deleteProductImg.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String deleteProductImg(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.deleteProductImg(map);
		return new Gson().toJson(resultMap);
	}
	
	// 게시글 한개 선택
	@RequestMapping(value = "/admin/BestSellProduct.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String BestSellProduct(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.selectBestSellProduct(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/admin/selectOrderList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String selectOrderList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.selectAllOrderList(map);
		return new Gson().toJson(resultMap);
	}
	
	@RequestMapping(value = "/admin/selectPartnerList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String selectPartnerList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.selectAllPartnerList(map);
		return new Gson().toJson(resultMap);
	}
	
	
	@RequestMapping(value = "/admin/UpdateAdminQna.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String UpdateAdminQna(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		
		resultMap = managerService.UpdateAdminQna(map);
		return new Gson().toJson(resultMap);
	}
	
	
	// 첨부파일
	@RequestMapping("/manager/fileUpload.dox")
	public String result(@RequestParam("file1") List<MultipartFile> files, @RequestParam("productId") int productId,
			 @RequestParam("thumbYn") String thumbYn, HttpServletRequest request, HttpServletResponse response, Model model) {
		
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
				File file = new File(path2 + "\\src\\main\\webapp\\img\\product\\img", saveFileName);
				multi.transferTo(file);

				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("productId", productId);
				map.put("filePath", "../img/product/img/" + saveFileName);
				map.put("fileName",  saveFileName);
				map.put("fileOrgname", fileOrgname);
				map.put("fileSize",size);
				map.put("fileEtc", extName); 
				map.put("thumbYn", thumbYn);

				managerService.insertProductFile(map);
				
				model.addAttribute("fileName", multi.getOriginalFilename());
				model.addAttribute("uploadPath", file.getAbsolutePath());
				}
			}
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return "redirect:/manager/main.do?menu=product&submenu=4";
		}
	
}
