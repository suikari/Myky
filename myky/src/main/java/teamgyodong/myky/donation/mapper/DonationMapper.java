package teamgyodong.myky.donation.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.donation.model.donation;

@Mapper
public interface DonationMapper {

	List<donation> selectCenterList(HashMap<String, Object> map);

	donation selectCenter(HashMap<String, Object> map);

	void insertHistory(HashMap<String, Object> map);

	List<donation> selectDonationInfo(HashMap<String, Object> map);

	donation selectUserDonationInfo(HashMap<String, Object> map);

}
