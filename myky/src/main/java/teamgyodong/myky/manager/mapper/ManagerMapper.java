package teamgyodong.myky.manager.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.board.model.board;
import teamgyodong.myky.manager.model.Vet;
import teamgyodong.myky.manager.model.Visit;
import teamgyodong.myky.manager.model.mBoard;
import teamgyodong.myky.manager.model.mComment;
import teamgyodong.myky.manager.model.mDonation;
import teamgyodong.myky.manager.model.mMembership;
import teamgyodong.myky.manager.model.mPartner;
import teamgyodong.myky.manager.model.mPay;
import teamgyodong.myky.manager.model.mProduct;
import teamgyodong.myky.manager.model.mProductImg;
import teamgyodong.myky.manager.model.mUser;
import teamgyodong.myky.manager.model.manager;
import teamgyodong.myky.manager.model.order;
import teamgyodong.myky.manager.model.orderdetail;

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
	
	List<mUser> selectAllUserList(HashMap<String, Object> map);
	List<Vet> selectAllVetList(HashMap<String, Object> map);
	List<mUser> selectAllnotVetList(HashMap<String, Object> map);
	List<mMembership> selectAllMembershipList(HashMap<String, Object> map);
	List<mBoard> selectAllBoardList(HashMap<String, Object> map);
	List<mProduct> selectAllProductList(HashMap<String, Object> map);
	List<mProduct> selectBestSellProduct(HashMap<String, Object> map);
	List<mProduct> selectTotOrder(HashMap<String, Object> map);
	List<mPartner> selectAllPartnerList(HashMap<String, Object> map);

	
	List<order> selectAllOrderList(HashMap<String, Object> map);
	List<orderdetail> selectOrderDetailList(HashMap<String, Object> map);
	
	List<mProductImg> selectProductImg(HashMap<String, Object> map);
	mProductImg selectProductThumImg(HashMap<String, Object> map);
	

	
	
	mPay selectLogFristJoinBuy(HashMap<String, Object> map);
	mMembership selectMembershipVal(HashMap<String, Object> map);
	mProduct selectProduct(HashMap<String, Object> map);
	
	int selectProductThumbChk(HashMap<String, Object> map);
	
	int selectAllCmtCnt(HashMap<String, Object> map);
	int selectAllUserCnt(HashMap<String, Object> map);
	int selectAllVetCnt(HashMap<String, Object> map);
	int selectAllMembershipCnt(HashMap<String, Object> map);
	int selectAllBoardCnt(HashMap<String, Object> map);
	int selectAllProductCnt(HashMap<String, Object> map);
	int selectAllOrderCnt(HashMap<String, Object> map);
	int selectAllPartnerCnt(HashMap<String, Object> map);

	

	
	
	
	int deleteBoardList(HashMap<String, Object> map);
	int deleteBoardCmtList(HashMap<String, Object> map);
	int deleteProductImg(HashMap<String, Object> map);
	int deletePartnerList(HashMap<String, Object> map);
	
	
	int insertVet(HashMap<String, Object> map);
	int insertProduct(HashMap<String, Object> map);
	int insertProductFile(HashMap<String, Object> map);
	int insertBoard(HashMap<String, Object> map);
	int insertPartnerDetail(HashMap<String, Object> map);

	
	
	
	int updateVet(HashMap<String, Object> map);
	int updateUser(HashMap<String, Object> map);	
	int updateProduct(HashMap<String, Object> map);
	int updateOrder(HashMap<String, Object> map);
	int updateOrderDetail(HashMap<String, Object> map);
	int updatePartnerDetail(HashMap<String, Object> map);
	int UpdateAdminQna(HashMap<String, Object> map);
	
	
	
	
}
