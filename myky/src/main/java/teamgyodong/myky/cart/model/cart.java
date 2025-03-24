package teamgyodong.myky.cart.model;

import lombok.Data;

@Data
public class cart {

	private String cartId;
	private String createdAt;
	private String sessionId;
	private String userId;
	
	private String cartItemId;
	private String quantity;
	private String productId;
	
	private String productName;
	private String price;
	private String totalPrice;
	
}
