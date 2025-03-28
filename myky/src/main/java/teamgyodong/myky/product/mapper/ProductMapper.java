package teamgyodong.myky.product.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.product.model.Product;
import teamgyodong.myky.product.model.Review;

@Mapper
public interface ProductMapper {

	List<Product> selectProductList(HashMap<String, Object> map);

	Product selectProduct(HashMap<String, Object> map);

	List<Product> selectProductImg(HashMap<String, Object> map);

	int selectProductCnt(HashMap<String, Object> resultMap);

	List<Review> selectReviewList(HashMap<String, Object> map);

	int selectReviewCount(HashMap<String, Object> map);

	void insertReview(HashMap<String, Object> map);

	void insertReviewFile(HashMap<String, Object> map);

	void deleteReview(HashMap<String, Object> map);

	void UpdateReview(HashMap<String, Object> map);
	
	//리뷰 가져오기
	Review selectReview(HashMap<String, Object> map);
	//리뷰 사진 가져오기
	List<Review> selectReviewImg(HashMap<String, Object> map);
	//조회수
//	int ReviewCnt(HashMap<String, Object> map);

	//도움돼요 추천
	int selectHelpfulByUser(HashMap<String, Object> map);
	void updateHelpCnt(HashMap<String, Object> map);


}
