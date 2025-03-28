package teamgyodong.myky.manager.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.manager.model.Visit;
import teamgyodong.myky.manager.model.mComment;
import teamgyodong.myky.manager.model.mDonation;
import teamgyodong.myky.manager.model.mPay;
import teamgyodong.myky.manager.model.mProduct;
import teamgyodong.myky.manager.model.mUser;
import teamgyodong.myky.manager.model.manager;

@Mapper
public interface ManagerMapper {

	List<Visit> selectLogBrowserList(HashMap<String, Object> map);
	List<Visit> selectLogDateList(HashMap<String, Object> map);
	List<Visit> selectLogTimeList(HashMap<String, Object> map);

	List<mProduct> selectProductList(HashMap<String, Object> map);
	List<mPay> selectPaymentList(HashMap<String, Object> map);
	List<mUser> selectUserList(HashMap<String, Object> map);
	List<mDonation> selectDonationList(HashMap<String, Object> map);
	
	List<mComment> selectAllCmtList(HashMap<String, Object> map);
	
	List<manager> selectSearchRanking(HashMap<String, Object> map);

	
	
	int selectAllCmtCnt(HashMap<String, Object> map);

	
	
	
	int deleteBoardList(HashMap<String, Object> map);
	int deleteBoardCmtList(HashMap<String, Object> map);

	
}
