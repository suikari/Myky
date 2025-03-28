package teamgyodong.myky.cart.dao;

import java.util.HashMap;

public interface CartService {

	HashMap<String, Object> getCartList(HashMap<String, Object> map);

	HashMap<String, Object> getCartCheckList(HashMap<String, Object> map);

	HashMap<String, Object> editQuantity(HashMap<String, Object> map);

	HashMap<String, Object> removeCartProduct(HashMap<String, Object> map);

	HashMap<String, Object> addCartProduct(HashMap<String, Object> map);

	HashMap<String, Object> addCartOrder(HashMap<String, Object> map);

	HashMap<String, Object> removeCart(HashMap<String, Object> map);

	HashMap<String, Object> editCheckYn(HashMap<String, Object> map);

	HashMap<String, Object> editAllCheckYn(HashMap<String, Object> map);

}
