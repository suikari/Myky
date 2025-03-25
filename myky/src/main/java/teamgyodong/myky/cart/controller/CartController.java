package teamgyodong.myky.cart.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.*;

import org.springframework.web.client.RestTemplate;
import org.springframework.util.MultiValueMap;
import org.springframework.util.LinkedMultiValueMap;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.cart.dao.CartService;


@Controller
public class CartController {
	@Autowired
	CartService cartService;
	
	@RequestMapping("/cart/list.do") 
	public String list(Model model) throws Exception{
		
		return "cart/cart";
	}
	
	// cartList
	@RequestMapping(value = "/cart/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.getCartList(map);
		return new Gson().toJson(resultMap);
	}

	// cart 수량 변경
	@RequestMapping(value = "/cart/quantity.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String quantity(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.editQuantity(map);
		return new Gson().toJson(resultMap);
	}

	// cart 특정 상품 삭제
	@RequestMapping(value = "/cart/removeProduct.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeCartProduct(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.removeCartProduct(map);
		return new Gson().toJson(resultMap);
	}
}
