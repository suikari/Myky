package teamgyodong.myky.prodcut.dao;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teamgyodong.myky.prodcut.mapper.ProductMapper;
import teamgyodong.myky.prodcut.model.Product;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	ProductMapper productMapper;
	
	public HashMap<String, Object> getProductList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Product> list = productMapper.selectProductList(map);
		resultMap.put("result", "success");
		resultMap.put("list", list);

		return resultMap;
	}
	
	public HashMap<String, Object> getProduct(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Product info = productMapper.selectProduct(map);
		List<Product> imgList = productMapper.selectProductImg(map);
		resultMap.put("result", "success");
		resultMap.put("info", info);
		resultMap.put("imgList", imgList);

		return resultMap;
	}
}
