package teamgyodong.myky.user.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.board.model.board;
import teamgyodong.myky.board.model.comment;
import teamgyodong.myky.cart.model.cart;
import teamgyodong.myky.donation.model.donation;
import teamgyodong.myky.manager.model.Vet;
import teamgyodong.myky.membership.model.Membership;
import teamgyodong.myky.user.model.User;

@Mapper
public interface UserMapper {

	User getUser(HashMap<String, Object> map);

	int updatePwd(HashMap<String, Object> map);

	User selectUser(HashMap<String, Object> map);

	User selectNick(HashMap<String, Object> map);

	int insertUser(HashMap<String, Object> map);

	void updateInfo(HashMap<String, Object> map);

	void updateLastLogin(String userId);

	int updateWithdraw(HashMap<String, Object> map);

	void insertProfileImg(HashMap<String, Object> map);

	List<comment> selectComm(HashMap<String, Object> map);

	int selectCommentCnt(HashMap<String, Object> map);

	List<donation> selectDonaInfo(HashMap<String, Object> map);

	donation sumDona(HashMap<String, Object> map);

	Vet selectVet(HashMap<String, Object> map);

	List<User> selectPoint(HashMap<String, Object> map);

	int selectPointCnt(HashMap<String, Object> map);

	int selectDonaCnt(HashMap<String, Object> map);

	List<User> selectCoupon(HashMap<String, Object> map);

	int selectCouponCnt(HashMap<String, Object> map);

	List<cart> selectUserOrderList(HashMap<String, Object> map);

	List<User> selectOrderCnt(HashMap<String, Object> map);

	User selectEmail(HashMap<String, Object> map);

	int selectOrderAllCnt(HashMap<String, Object> map);

	List<Membership> selectMembershipId(HashMap<String, Object> map);

	






}
