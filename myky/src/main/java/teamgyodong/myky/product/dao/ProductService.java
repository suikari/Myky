package teamgyodong.myky.product.dao;

import java.util.HashMap;

public interface ProductService {
  HashMap<String, Object> getProductList(HashMap<String, Object> map);

  HashMap<String, Object> getProduct(HashMap<String, Object> map);

  HashMap<String, Object> getReviewList(HashMap<String, Object> map);
}
