package teamgyodong.myky.membership.dao;

import java.util.HashMap;

public interface MembershipService {

	HashMap<String, Object> getMembershipInfo(HashMap<String, Object> map);

	HashMap<String, Object> getMembershipActive(HashMap<String, Object> map);

}
