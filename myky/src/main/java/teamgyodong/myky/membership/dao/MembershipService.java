package teamgyodong.myky.membership.dao;

import java.util.HashMap;

public interface MembershipService {

	HashMap<String, Object> getMembershipInfo(HashMap<String, Object> map);

	HashMap<String, Object> getMembershipActive(HashMap<String, Object> map);

	HashMap<String, Object> getMemberCnt(HashMap<String, Object> map);

	HashMap<String, Object> getMembershipTotalDonation(HashMap<String, Object> map);

	HashMap<String, Object> getUserTotalDonation(HashMap<String, Object> map);

	HashMap<String, Object> getTotalUserCnt(HashMap<String, Object> map);

	HashMap<String, Object> getJoinMember(HashMap<String, Object> map);

	HashMap<String, Object> getTermsList(HashMap<String, Object> map);

	HashMap<String, Object> addMembership(HashMap<String, Object> map);

	HashMap<String, Object> checkMembership(HashMap<String, Object> map);
	
		


}
