package teamgyodong.myky.membership.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.membership.model.Membership;

@Mapper

public interface MembershipMapper {

	Membership selectMembershipInfo(HashMap<String, Object> map);
	
	void updateDonationYn(HashMap<String, Object> map);

	Membership selectValidMembership(HashMap<String, Object> map);

	int selectMemberCnt(HashMap<String, Object> map);

	int getMembershipTotalAmount(HashMap<String, Object> map);

	int getUserTotalAmount(HashMap<String, Object> map);

	int selectTotalUserCnt(HashMap<String, Object> map);

	void getJoinMEmber(HashMap<String, Object> map);

	List<Membership> selectTermsList(HashMap<String, Object> map);

	void insertMembership(HashMap<String, Object> map);

	String selectMembershipIdByUserId(String userId);

	int getMembershipHistoryCount(String userId);
	
	

}
