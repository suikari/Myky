package teamgyodong.myky.user.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.user.model.User;

@Mapper
public interface UserMapper {

	User getUser(HashMap<String, Object> map);

}
