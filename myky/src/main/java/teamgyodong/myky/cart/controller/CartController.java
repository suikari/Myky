package teamgyodong.myky.cart.controller;

import java.util.HashMap;
import java.util.List;
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

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import teamgyodong.myky.cart.dao.CartService;


@Controller
public class CartController {
	@Autowired
	CartService cartService;
	
	@RequestMapping("/cart/list.do") 
	public String list(HttpServletRequest request, Model model) throws Exception {
        HttpSession session = request.getSession();
        String sessionId = (String) session.getAttribute("sessionId");
        
        if (sessionId == null) {
            return "redirect:/user/login.do"; // 로그인 페이지로 리디렉트
        }
        
		return "cart/cart";
	}

	@RequestMapping("/cart/order.do") 
	public String order(HttpServletRequest request, Model model) throws Exception {
        HttpSession session = request.getSession();
        String sessionId = (String) session.getAttribute("sessionId");
        
        if (sessionId == null) {
            return "redirect:/user/login.do";
        }
		
		return "cart/order";
	}

	@RequestMapping("/order/orderComplete.do") 
	public String orderComplete(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession();
        String sessionId = (String) session.getAttribute("sessionId");
        
        if (sessionId == null) {
            return "redirect:/user/login.do";
        }
        
		request.setAttribute("map", map);
		return "cart/order-complete";
	}

	@RequestMapping("/order/orderList.do") 
	public String orderList(HttpServletRequest request, Model model, @RequestParam HashMap<String, Object> map) throws Exception{
		HttpSession session = request.getSession();
        String sessionId = (String) session.getAttribute("sessionId");
        
        if (sessionId == null) {
            return "redirect:/user/login.do";
        }
        
		request.setAttribute("map", map);
		return "cart/order-list";
	}
	
	// cartList
	@RequestMapping(value = "/cart/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String list(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.getCartList(map);
		return new Gson().toJson(resultMap);
	}

	// cartCheckList
	@RequestMapping(value = "/cart/checkList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String checkList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.getCartCheckList(map);
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

	// cart checkYn 변경 - 개별
	@RequestMapping(value = "/cart/checkYn.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String checkYn(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.editCheckYn(map);
		return new Gson().toJson(resultMap);
	}

	// cart checkYn 변경 - 전체 (userId, checkYn 필요)
	@RequestMapping(value = "/cart/AllCheckYn.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String AllCheckYn(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.editAllCheckYn(map);
		return new Gson().toJson(resultMap);
	}

	// cart 특정 상품 삭제 - 삭제버튼
	@RequestMapping(value = "/cart/removeProduct.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeCartProduct(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.removeCartProduct(map);
		return new Gson().toJson(resultMap);
	}
	
	// cart 비우기 (결제 후 전체삭제)
	@RequestMapping(value = "/cart/removeCart.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String removeCart(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.removeCart(map);
		return new Gson().toJson(resultMap);
	}

	// cart 상품 추가 (상세페이지에서 이동 - userId, sessionId, productId, quantity(수량), checkYn 필요)
	@RequestMapping(value = "/cart/addProduct.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String addCartProduct(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.addCartProduct(map);
		return new Gson().toJson(resultMap);
	}
	
	// cart order - 주문내역 저장
	@RequestMapping(value = "/cart/order.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String order(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		String json = map.get("orderDetails").toString(); 
		ObjectMapper mapper = new ObjectMapper();
		List<Object> orderDetails = mapper.readValue(json, new TypeReference<List<Object>>(){});
		map.put("orderDetails", orderDetails);
		
		resultMap = cartService.addCartOrder(map);
		return new Gson().toJson(resultMap);
	}
	
	// orderInfo -- orders 테이블만 (userId, orderId)
	@RequestMapping(value = "/order/info.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String orderInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.getOrderInfo(map);
		return new Gson().toJson(resultMap);
	}

	// orderList -- order_details 테이블까지 (userId, orderId)
	@RequestMapping(value = "/order/list.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String orderList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.getOrderList(map);
		return new Gson().toJson(resultMap);
	}

	// orderList -- 모두 조회 (userId)
	@RequestMapping(value = "/order/AllList.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String allOrderList(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.getAllOrderList(map);
		return new Gson().toJson(resultMap);
	}

	// 주문 상태 변경 (orderId, userId, orderStatus)
	@RequestMapping(value = "/order/status.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String orderStatus(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.editOrderStatus(map);
		return new Gson().toJson(resultMap);
	}

	// 주문/배송 정보 변경 (orderId, userId, receiverName, receiverPhone, receiverAddr, deliveryMessage)
	@RequestMapping(value = "/order/editInfo.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String editInfo(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.editOrderInfo(map);
		return new Gson().toJson(resultMap);
	}

	// 교환/반품 신청 (orderId, productId, reason, reasonDetail, refundStatus)
	@RequestMapping(value = "/order/refund.dox", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String refund(Model model, @RequestParam HashMap<String, Object> map) throws Exception {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = cartService.editRefundStatus(map);
		return new Gson().toJson(resultMap);
	}
}
