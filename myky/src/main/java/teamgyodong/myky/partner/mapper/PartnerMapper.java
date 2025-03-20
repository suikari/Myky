package teamgyodong.myky.partner.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.partner.model.partnerdetail;

@Mapper
public interface PartnerMapper {
	List<partnerdetail> getPartnerDetailList(HashMap<String, Object> map);

}
