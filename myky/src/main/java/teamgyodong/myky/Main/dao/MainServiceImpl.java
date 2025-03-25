package teamgyodong.myky.Main.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import teamgyodong.myky.Main.mapper.MainMapper;
import teamgyodong.myky.Main.model.Category;
import teamgyodong.myky.Main.model.Visit;
import teamgyodong.myky.donation.mapper.DonationMapper;
import teamgyodong.myky.donation.model.donation;


@Service
public class MainServiceImpl implements MainService {

	@Autowired
	MainMapper mainMapper;
	
    
	@Override
	public HashMap<String, Object> InsertVisitLog(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int count = mainMapper.insertVisitLog(map);

			resultMap.put("count", count);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		
		return resultMap;
	}
	
	@Override
	public HashMap<String, Object> selectCategoryList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Category> list = mainMapper.selectCategoryList(map);

			resultMap.put("list", list);
			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	@Override
	public HashMap<String, Object> selectLogBrowserList(HashMap<String, Object> map) {
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			List<Visit> Browser = mainMapper.selectLogBrowserList(map);
			List<Visit> Date = mainMapper.selectLogDateList(map);
			List<Visit> Time = mainMapper.selectLogTimeList(map);

			resultMap.put("Browser", Browser);
			resultMap.put("Date", Date);
			resultMap.put("Time", Time);

			resultMap.put("result", "success");
		}catch(Exception e) {
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");			
		}
		return resultMap;
	}
	


}
