package teamgyodong.myky.user.dao;

import java.util.HashMap;

public interface UserService {

	HashMap<String, Object> userLogin(HashMap<String, Object> map);

	HashMap<String, Object> newPwd(HashMap<String, Object> map);

	HashMap<String, Object> getview(HashMap<String, Object> map);

//	HashMap<String, Object> searchId(HashMap<String, Object> map);
	
}
