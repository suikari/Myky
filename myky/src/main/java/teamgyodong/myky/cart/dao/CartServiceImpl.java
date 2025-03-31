package teamgyodong.myky.cart.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import teamgyodong.myky.cart.mapper.CartMapper;
import teamgyodong.myky.cart.model.cart;


@Service
public class CartServiceImpl implements CartService {

	@Autowired
	CartMapper cartMapper;
	
	@Override
	public HashMap<String, Object> getCartList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<cart> list = cartMapper.selectCartList(map);

			resultMap.put("list", list);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}

	@Override
	public HashMap<String, Object> getCartCheckList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<cart> checkList = cartMapper.selectCartCheckList(map);
			
			resultMap.put("checkList", checkList);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> editQuantity(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			cartMapper.updateQuantity(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> editCheckYn(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			cartMapper.updateCartCheckYn(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> editAllCheckYn(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			cartMapper.updateCartAllCheckYn(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> removeCartProduct(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			cartMapper.deleteCartProduct(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> addCartProduct(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
//			String userId = (map.get("userId")) != null ? (String) map.get("userId") : (String) map.get("sessionId");
//			map.put("userId", userId);
//			비회원 장바구니 기능 추가 시 사용할 코드
			
			cart userCart = cartMapper.findCart(map);
			// userId 필요. 해당 유저에게 장바구니가 있는지 조회
			
			if(userCart == null) {
				// 장바구니 없는 경우
				cartMapper.insertCart(map);
				// 장바구니 생성. map에 cartId 담겨있음
				System.out.println("기존 카트 x. map에 담긴 내용 >>> "+map);
				cartMapper.insertCartProduct(map);
				// 만들어진 장바구니에 상품 담기
			} else {
				map.put("cartId", userCart.getCartId());
				System.out.println("zkkkkkkkkkkkkkkkkxmmmmmmmmmmmmmm >> "+map);
				// 장바구니 데이터에서 cartId 가져오기
				System.out.println("기존 카트 o. map에 담긴 내용 >>> "+map);
				if(map.get("option").equals("instant")) {
					// 상품페이지에서 바로구매 진행하는 경우
					cart existingProduct  = cartMapper.findCartItem(map);
					if (existingProduct != null) {
						cartMapper.updateQuantity(map);
						// 기존 장바구니에 해당 상품이 있는 경우 > 전달받은 quantity 값으로 변경
						cartMapper.updateCartCheckYn(map);
						// 바로구매 상품 장바구니에 넣기 전 N값으로 변경되어있음.
						// 수량 변경 및 Y값으로 변경
					} else {
						cartMapper.insertCartProduct(map);
					}
				} else {
					cart existingProduct  = cartMapper.findCartItem(map);
					// 기존 장바구니에 담으려는 상품이 있는지 확인
					if (existingProduct != null) {
						cartMapper.updateCartQuantity(map);
						// 기존 장바구니에 해당 상품이 있는 경우 > 수량 추가
					} else {
						cartMapper.insertCartProduct(map);
						// 기존 장바구니에 해당 상품이 없는 경우 > 장바구니에 상품 추가
					}
				}
			}
			
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	@Override
	@Transactional
	public HashMap<String, Object> addCartOrder(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			if (map.get("option").equals("order")) {
	            // 주문 정보 삽입
	            cartMapper.insertCartOrder(map);
	            
	            cartMapper.insertCartOrderDetail(map);
	            
	        }
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println("오류 발생: " + e.getMessage());
            resultMap.put("result", "fail");
            throw new RuntimeException(e); // 트랜잭션 롤백을 위해 예외 발생			
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> removeCart(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			cartMapper.deleteCart(map);
			cartMapper.deleteCartItem(map);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> getOrderInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			cart orderInfo = cartMapper.selectOrderInfo(map);

			resultMap.put("orderInfo", orderInfo);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> getOrderList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<cart> orderList = cartMapper.selectOrderList(map);

			resultMap.put("orderList", orderList);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> getAllOrderInfo(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<cart> orderInfo = cartMapper.selectAllOrderInfo(map);

			resultMap.put("orderInfo", orderInfo);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> getAllOrderList(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<cart> orderList = cartMapper.selectAllOrderList(map);

			resultMap.put("orderList", orderList);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
}
