package teamgyodong.myky.cart.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.cart.model.cart;

@Mapper
public interface CartMapper {

	List<cart> selectCartList(HashMap<String, Object> map);

	void updateQuantity(HashMap<String, Object> map);

	void deleteCartProduct(HashMap<String, Object> map);

	void insertCartProduct(HashMap<String, Object> map);

	cart findCart(HashMap<String, Object> map);

	void insertCart(HashMap<String, Object> map);

	cart findCartItem(HashMap<String, Object> map);

	void updateCartQuantity(HashMap<String, Object> map);

	void insertCartOrder(HashMap<String, Object> map);

	void insertCartOrderDetail(HashMap<String, Object> map);

}
