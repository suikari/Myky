package teamgyodong.myky.prodcut.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import teamgyodong.myky.prodcut.dao.ProductService;


@Controller
public class ProdcutController {


	@Autowired
	ProductService productService;
	
	//상품 리스트 가져오기
	@RequestMapping("/product/list.do") 
    public String result(Model model) throws Exception{
        return "/product/product-list"; 
    }

	
	
	
	
	
	//상품 리스트 호출
	@RequestMapping(value = "/product/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap = productService.getProductList(map);
		return new Gson().toJson(resultMap);
	}
}
