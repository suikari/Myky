package teamgyodong.myky.pay.dao;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teamgyodong.myky.pay.mapper.PayMapper;


@Service
public class PayServiceImpl implements PayService {
	
	@Autowired
	PayMapper payMapper;

	@Override
	public HashMap<String, Object> addPayment(HashMap<String, Object> map) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			payMapper.insertPayment(map);

			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
}
