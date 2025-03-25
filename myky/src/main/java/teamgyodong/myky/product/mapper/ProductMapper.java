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

}
