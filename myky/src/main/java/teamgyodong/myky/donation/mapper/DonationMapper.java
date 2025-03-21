package teamgyodong.myky.donation.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.donation.model.donation;

@Mapper
public interface DonationMapper {

	List<donation> selectCenterList(HashMap<String, Object> map);

}
