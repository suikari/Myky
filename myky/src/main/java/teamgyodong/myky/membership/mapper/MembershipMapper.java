package teamgyodong.myky.membership.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.membership.model.Membership;

@Mapper

public interface MembershipMapper {

	Membership selectMembershipInfo(HashMap<String, Object> map);
	
	void updateDonationYn(HashMap<String, Object> map);

	Membership selectValidMembership(HashMap<String, Object> map);

}
