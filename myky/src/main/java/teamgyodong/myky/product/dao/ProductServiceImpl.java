package teamgyodong.myky.product.dao;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teamgyodong.myky.product.mapper.ProductMapper;
import teamgyodong.myky.product.model.Product;
import teamgyodong.myky.product.model.Qna;
import teamgyodong.myky.product.model.Review;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	ProductMapper productMapper;
	//상품 리스트 가져오기
	public HashMap<String, Object> getProductList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Product> list = productMapper.selectProductList(map);
		int count = productMapper.selectProductCnt(map);
		
		resultMap.put("list", list);
		resultMap.put("count", count);
		resultMap.put("result", "success");
		
		return resultMap;
	}
	//상품 가져오기
	public HashMap<String, Object> getProduct(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Product info = productMapper.selectProduct(map);
		List<Product> imgList = productMapper.selectProductImg(map);
		
		resultMap.put("info", info);
		resultMap.put("imgList", imgList);
		resultMap.put("result", "success");
		return resultMap;
	}

	//상품 리뷰 쓰기
	public HashMap<String, Object> addReview(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		productMapper.insertReview(map);
		//System.out.println("Key ==> " +map.get("userId"));
		
		resultMap.put("reviewId", map.get("reviewId"));
		resultMap.put("result", "success");
		return resultMap;
	}
	
	//상품 리뷰 리스트 가져오기
	public HashMap<String, Object> getReviewList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Review> list = productMapper.selectReviewList(map);
		int count = productMapper.selectReviewCount(map);
		//리뷰 사진 가져오기
//		List<Review> imgList = productMapper.selectReviewImg(map);
				
				
		resultMap.put("reviewList", list);
//		resultMap.put("imgList", imgList);
		resultMap.put("count", list.size());
		resultMap.put("totalCount", count); 
		resultMap.put("result", "success");
		
		return resultMap;
	}
	//리뷰 삭제
	public HashMap<String, Object> reviewRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		productMapper.deleteReview(map);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	//리뷰 수정
	public  HashMap<String, Object> reviewEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		productMapper.UpdateReview(map);
		resultMap.put("result", "success");
		return resultMap;
	}
	
	//리뷰 가져오기
	public HashMap<String, Object> getReview(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//리뷰 정보 가져오기
		Review info = productMapper.selectReview(map);
		
		resultMap.put("info", info);
		resultMap.put("result", "success");
		return resultMap;
	}

	// 도움돼요 추천 처리
	public HashMap<String, Object> markHelpful(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<>();

	    // 이미 추천했는지 확인
	    int check = productMapper.selectHelpfulByUser(map);

	    if (check > 0) {
	        resultMap.put("result", "fail");
	        resultMap.put("message", "이미 추천한 리뷰입니다.");
	    } else { 
	        productMapper.updateHelpCnt(map);  
	        resultMap.put("result", "success");
	    }

	    return resultMap;
	}

	//상품 리뷰 파일 업로드
	public  void addReviewFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		productMapper.insertReviewFile(map);
	}
	
	
	//상품 QnA 페이지
	public HashMap<String, Object> getQnAList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Qna> qnalist = productMapper.selectQnaList(map);
		int count = productMapper.selectQnaCnt(map);
		
		resultMap.put("list", qnalist);
		resultMap.put("totalCount", count);
		resultMap.put("result", "success");
		
		return resultMap;
	}
	//상품 QnA 글쓰기
	public HashMap<String, Object> addQna(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		productMapper.insertQna(map);
		//System.out.println("Key ==> " +map.get("userId"));
		
		resultMap.put("qnaId", map.get("qnaId"));
		resultMap.put("result", "success");
		return resultMap;
	}
	//QnA 글 삭제
	public HashMap<String, Object> qnaRemove(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		productMapper.deleteQna(map);
		resultMap.put("result", "success");
		return resultMap;
	}
	//리뷰 수정
	public HashMap<String, Object> qnaEdit(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		productMapper.UpdateQna(map);
		resultMap.put("result", "success");
		return resultMap;
	}
	//QnA 하나만 가져오기
	public HashMap<String, Object> getQna(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//리뷰 정보 가져오기
		Qna info = productMapper.selectQna(map);
		
		resultMap.put("info", info);
		resultMap.put("result", "success");
		return resultMap;
	}
	
}
