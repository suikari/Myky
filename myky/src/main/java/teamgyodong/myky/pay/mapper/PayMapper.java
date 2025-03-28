package teamgyodong.myky.pay.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.pay.model.pay;

@Mapper
public interface PayMapper {

	void insertPayment(HashMap<String, Object> map);

	List<pay> selectPayment(HashMap<String, Object> map);

	pay selectCurrentPoint(HashMap<String, Object> map);

	void insertUsedPoint(HashMap<String, Object> map);

	
	
}
