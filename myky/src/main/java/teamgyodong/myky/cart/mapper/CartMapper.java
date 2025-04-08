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

	List<cart> selectOrderList(HashMap<String, Object> map);

	cart selectOrderInfo(HashMap<String, Object> map);

	List<cart> selectAllOrderList(HashMap<String, Object> map);

	void updateOrderStatus(HashMap<String, Object> map);

	void updateOrderInfo(HashMap<String, Object> map);

	void updateRefundStatus(HashMap<String, Object> map);

	int getPartnerCount(HashMap<String, Object> map);

	int findTotalQuantity(int i);

	void decreaseQuantity(Map<String, Object> item);

	void insertPartialRefund(HashMap<String, Object> map);

}
