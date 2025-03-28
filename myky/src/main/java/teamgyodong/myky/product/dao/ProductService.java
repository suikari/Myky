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

  HashMap<String, Object> markHelpful(HashMap<String, Object> map);

  HashMap<String, Object> getQnAList(HashMap<String, Object> map);

  HashMap<String, Object> addQna(HashMap<String, Object> map);

  HashMap<String, Object> qnaRemove(HashMap<String, Object> map);

  HashMap<String, Object> qnaEdit(HashMap<String, Object> map);

  HashMap<String, Object> getQna(HashMap<String, Object> map);

}
