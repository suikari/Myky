package teamgyodong.myky.partner.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.partner.model.partnerdetail;

@Mapper
public interface PartnerMapper {
	List<partnerdetail> getPartnerDetailList(HashMap<String, Object> map);

	List<partnerdetail> getPartnerGuList(HashMap<String, Object> map);

	List<partnerdetail> getPartnerDongList(HashMap<String, Object> map);

	List<partnerdetail> getPartnerSiList(HashMap<String, Object> map);

	List<partnerdetail> getPartnerHosList(HashMap<String, Object> map);

	List<partnerdetail> getPartnerList(HashMap<String, Object> map);

	List<partnerdetail> getfavoriteList(HashMap<String, Object> map);

	List<partnerdetail> favorList(HashMap<String, Object> map);

	List<partnerdetail> getcategoryCode(HashMap<String, Object> map);

	void addfavoritesHospital(HashMap<String, Object> map);

	void addfavoritesPartner(HashMap<String, Object> map);

	void favoritesHospitalDelete(HashMap<String, Object> map);

	void favoritesPartnerDelete(HashMap<String, Object> map);





}
