package teamgyodong.myky.pay.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PayMapper {

	void insertPayment(HashMap<String, Object> map);

}
