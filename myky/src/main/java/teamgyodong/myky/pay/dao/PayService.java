package teamgyodong.myky.pay.dao;

import java.util.HashMap;

public interface PayService {

	HashMap<String, Object> addPayment(HashMap<String, Object> map);
	
	HashMap<String, Object> selectPayment(HashMap<String, Object> map);

	
}
