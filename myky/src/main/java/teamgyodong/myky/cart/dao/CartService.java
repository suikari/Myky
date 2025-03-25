package teamgyodong.myky.cart.dao;

import java.util.HashMap;

public interface CartService {

	HashMap<String, Object> getCartList(HashMap<String, Object> map);

	HashMap<String, Object> editQuantity(HashMap<String, Object> map);

	HashMap<String, Object> removeCartProduct(HashMap<String, Object> map);

	HashMap<String, Object> addCartProduct(HashMap<String, Object> map);

}
