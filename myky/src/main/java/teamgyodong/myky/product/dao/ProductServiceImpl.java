package teamgyodong.myky.product.dao;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teamgyodong.myky.product.mapper.ProductMapper;
import teamgyodong.myky.product.model.Product;
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
		System.out.println("Key ==> " +map.get("userId"));
		
		resultMap.put("userId", map.get("userId"));
		resultMap.put("result", "success");
		return resultMap;
	}
	
	//상품 리뷰 리스트 가져오기
	public HashMap<String, Object> getReviewList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Review> list = productMapper.selectReviewList(map);
		int count = productMapper.selectReviewCount(map);
		
		
		resultMap.put("reviewList", list);
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
		//리뷰 사진 가져오기
//		List<Review> imgList = productMapper.selectReviewImg(map);
		
		resultMap.put("info", info);
//		resultMap.put("imgList", imgList);
		resultMap.put("result", "success");
		return resultMap;
	}

	//상품 리뷰 파일 업로드
	public  void addReviewFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		productMapper.insertReviewFile(map);
		
	}
	
}
