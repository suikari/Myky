package teamgyodong.myky.manager.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import teamgyodong.myky.Main.mapper.MainMapper;
import teamgyodong.myky.board.model.board;
import teamgyodong.myky.manager.mapper.ManagerMapper;
import teamgyodong.myky.manager.model.Vet;
import teamgyodong.myky.manager.model.Visit;
import teamgyodong.myky.manager.model.mBoard;
import teamgyodong.myky.manager.model.mComment;
import teamgyodong.myky.manager.model.mDonation;
import teamgyodong.myky.manager.model.mMembership;
import teamgyodong.myky.manager.model.mPay;
import teamgyodong.myky.manager.model.mProduct;
import teamgyodong.myky.manager.model.mProductImg;
import teamgyodong.myky.manager.model.mUser;
import teamgyodong.myky.manager.model.manager;
import teamgyodong.myky.manager.model.order;
import teamgyodong.myky.manager.model.orderdetail;


@Service
public class ManagerServiceImpl implements ManagerService {

	@Autowired
	
	ManagerMapper managerMapper;
	
	
	@Override
	public HashMap<String, Object> selectLogBrowserList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Visit> Browser = managerMapper.selectLogBrowserList(map);
			List<Visit> Date = managerMapper.selectLogDateList(map);
			List<Visit> Time = managerMapper.selectLogTimeList(map);

			resultMap.put("Browser", Browser);
			resultMap.put("Date", Date);
			resultMap.put("Time", Time);

			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	
	//게시글 추가
	@Override
	public HashMap<String, Object> insertProduct(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			managerMapper.insertProduct(map);
			resultMap.put("productId", map.get("productId"));
			resultMap.put("result", "success");
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> selectMainList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<mProduct> mProduct = managerMapper.selectProductList(map);
			List<mPay> mPay = managerMapper.selectPaymentList(map);
			List<mUser> mUser = managerMapper.selectUserList(map);
			List<mDonation> mDonation = managerMapper.selectDonationList(map);

			

			
			resultMap.put("Product", mProduct);
			resultMap.put("Pay", mPay);
			resultMap.put("User", mUser);
			resultMap.put("Donation", mDonation);
			
	        if (!mProduct.isEmpty()) {
	            resultMap.put("productcnt", mProduct.get(0).getProductTotalCnt());
	        }
	        if (!mPay.isEmpty()) {
	            resultMap.put("paycnt", mPay.get(0).getPaymentTotalCnt());
	        }
	        if (!mUser.isEmpty()) {
	            resultMap.put("userCnt", mUser.get(0).getUserTotalCnt());
	        }
	        if (!mDonation.isEmpty()) {
	            resultMap.put("donationCnt", mDonation.get(0).getDonationTotalCnt());
	        }


			
			
			resultMap.put("result", "success");
			
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> deleteBoardList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int count = managerMapper.deleteBoardList(map);

			resultMap.put("count", count);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> deleteBoardCmtList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int count = managerMapper.deleteBoardCmtList(map);

			resultMap.put("count", count);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	
	@Override
	public HashMap<String, Object> selectAllCmtList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<mComment> mComment = managerMapper.selectAllCmtList(map);
			
			int count = managerMapper.selectAllCmtCnt(map);
			
			Map<String, Object> countMap = new HashMap<>();
			countMap.put("cnt", count);

			resultMap.put("count", countMap);
			resultMap.put("result", "success");			
			resultMap.put("Comment", mComment);			
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	
	@Override
	public HashMap<String, Object> selectSearchRanking(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<manager> Search = managerMapper.selectSearchRanking(map);
			
	
			resultMap.put("result", "success");			
			resultMap.put("Search", Search);			
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	
	@Override
	public HashMap<String, Object> selectAllUserList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<mUser> mUser = managerMapper.selectAllUserList(map);
			
			int count = managerMapper.selectAllUserCnt(map);
			
			Map<String, Object> countMap = new HashMap<>();
			countMap.put("cnt", count);

			resultMap.put("count", countMap);
			resultMap.put("result", "success");			
			resultMap.put("User", mUser);			
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	
	@Override
	public HashMap<String, Object> selectLogFristJoinBuy(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			mPay mPay = managerMapper.selectLogFristJoinBuy(map);
			
			
			resultMap.put("result", "success");			
			resultMap.put("Pay", mPay);			
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> selectAllVetList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Vet> Vet = managerMapper.selectAllVetList(map);
			int count = managerMapper.selectAllVetCnt(map);
			
			Map<String, Object> countMap = new HashMap<>();
			countMap.put("cnt", count);

			resultMap.put("count", countMap);
			
			resultMap.put("result", "success");			
			resultMap.put("Vet", Vet);			
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> selectAllMembershipList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<mMembership> mMembership = managerMapper.selectAllMembershipList(map);
			int count = managerMapper.selectAllMembershipCnt(map);
			
			Map<String, Object> countMap = new HashMap<>();
			countMap.put("cnt", count);

			resultMap.put("count", countMap);
			
			resultMap.put("result", "success");			
			resultMap.put("Membership", mMembership);			
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> selectAllBoardList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<mBoard> mBoard = managerMapper.selectAllBoardList(map);
			int count = managerMapper.selectAllBoardCnt(map);
			
			Map<String, Object> countMap = new HashMap<>();
			countMap.put("cnt", count);

			resultMap.put("count", countMap);
			
			resultMap.put("result", "success");			
			resultMap.put("Board", mBoard);			
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	
	@Override
	public HashMap<String, Object> selectAllnotVetList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<mUser> mUser = managerMapper.selectAllnotVetList(map);
			
			
			resultMap.put("result", "success");			
			resultMap.put("User", mUser);			
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	
	@Override
	public HashMap<String, Object> selectAllProductList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<mProduct> mProduct = managerMapper.selectAllProductList(map);
			int count = managerMapper.selectAllProductCnt(map);
			
			Map<String, Object> countMap = new HashMap<>();
			countMap.put("cnt", count);
			resultMap.put("count", countMap);
			resultMap.put("result", "success");			
			resultMap.put("Product", mProduct);			
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
		
	
	@Override
	public HashMap<String, Object> selectBestSellProduct(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<mProduct> mProduct = managerMapper.selectBestSellProduct(map);
			List<mProduct> mOrder = managerMapper.selectTotOrder(map);

			
			resultMap.put("result", "success");			
			resultMap.put("Product", mProduct);	
			resultMap.put("Order", mOrder);			

		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
		
	
	
	
	@Override
	public HashMap<String, Object> updateUser(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int count = managerMapper.updateUser(map);

			resultMap.put("count", count);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> updateVet(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int count = managerMapper.updateVet(map);

			resultMap.put("count", count);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> insertVet(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int count = managerMapper.insertVet(map);

			resultMap.put("count", count);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	
	@Override
	public HashMap<String, Object> insertProductFile(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
			
			int chk =  managerMapper.selectProductThumbChk(map);
			
			if ( chk > 1 ) {
				resultMap.put("result", "fail");
				return resultMap;
			}
			
			int count = managerMapper.insertProductFile(map);

			resultMap.put("count", count);
			resultMap.put("result", "success");
			try {
	
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	
	@Override
	public HashMap<String, Object> selectProduct(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
			
			mProduct mProduct =  managerMapper.selectProduct(map);
			mProductImg ThumImg =  managerMapper.selectProductThumImg(map);
			List<mProductImg> ImgList =  managerMapper.selectProductImg(map);

									
			

		
			resultMap.put("Product", mProduct);
			resultMap.put("ThumImg", ThumImg);
			resultMap.put("ImgList", ImgList);

			
			resultMap.put("result", "success");
			try {
	
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> updateProduct(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int count = managerMapper.updateProduct(map);

			resultMap.put("count", count);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> updateOrder(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int count = managerMapper.updateOrder(map);

			resultMap.put("count", count);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> updateOrderDetail(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int count = managerMapper.updateOrderDetail(map);

			resultMap.put("count", count);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> selectMembershipVal(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			mMembership mMembership = managerMapper.selectMembershipVal(map);
			
			
			resultMap.put("result", "success");			
			resultMap.put("Membership", mMembership);			
		}catch(Exception e) {
			
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	@Override
	public HashMap<String, Object> deleteProductImg(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int count = managerMapper.deleteProductImg(map);

			resultMap.put("count", count);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	//게시글 상세보기
	@Override
	public HashMap<String, Object> selectAllOrderList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
				
	    List<order> order = managerMapper.selectAllOrderList(map);
		
	    int count = managerMapper.selectAllOrderCnt(map);

		Map<String, Object> countMap = new HashMap<>();
		countMap.put("cnt", count);
		
	    for (order detail : order) {
	        map.put("orderId", detail.getOrderId()); // 댓글 ID → 대댓글 검색용
	        List<orderdetail> replies = managerMapper.selectOrderDetailList(map);
	        detail.setOrderdetail(replies); // 💥 replies를 comment 객체에 직접 세팅
	    }

		

		
		resultMap.put("count", count);
	    resultMap.put("order", order);
	    resultMap.put("result", "success");
	    
		try {

		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
	
	    return resultMap;
	}
	
}
