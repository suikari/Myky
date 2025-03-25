package teamgyodong.myky.product.dao;

import java.util.HashMap;

public interface ProductService {
  HashMap<String, Object> getProductList(HashMap<String, Object> map);

  HashMap<String, Object> getProduct(HashMap<String, Object> map);

  HashMap<String, Object> getReviewList(HashMap<String, Object> map);

  HashMap<String, Object> addReview(HashMap<String, Object> map);

  void addReviewFile(HashMap<String, Object> map);

  HashMap<String, Object> reviewRemove(HashMap<String, Object> map);

  HashMap<String, Object> reviewEdit(HashMap<String, Object> map);

  HashMap<String, Object> getReview(HashMap<String, Object> map);
}
