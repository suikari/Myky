package teamgyodong.myky.prodcut.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.prodcut.model.Product;

@Mapper
public interface ProductMapper {

	List<Product> selectProductList(HashMap<String, Object> map);

	Product selectProduct(HashMap<String, Object> map);

	List<Product> selectProductImg(HashMap<String, Object> map);

}
