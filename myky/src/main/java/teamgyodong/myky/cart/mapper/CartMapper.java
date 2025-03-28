package teamgyodong.myky.cart.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.cart.model.cart;

@Mapper
public interface CartMapper {

	List<cart> selectCartList(HashMap<String, Object> map);

	List<cart> selectCartCheckList(HashMap<String, Object> map);

	void updateQuantity(HashMap<String, Object> map);

	void deleteCartProduct(HashMap<String, Object> map);

	void insertCartProduct(HashMap<String, Object> map);

	cart findCart(HashMap<String, Object> map);

	void insertCart(HashMap<String, Object> map);

	cart findCartItem(HashMap<String, Object> map);

	void updateCartQuantity(HashMap<String, Object> map);

	void updateCartCheckYn(HashMap<String, Object> map);

	void updateCartAllCheckYn(HashMap<String, Object> map);

	void updateCartAllCheckY(HashMap<String, Object> map);

	void insertCartOrder(HashMap<String, Object> map);

	void insertCartOrderDetail(Map<String, Object> detail);

	void deleteCart(HashMap<String, Object> map);

	void deleteCartItem(HashMap<String, Object> map);

}
