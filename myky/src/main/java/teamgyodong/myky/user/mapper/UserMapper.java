package teamgyodong.myky.user.mapper;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import teamgyodong.myky.user.model.User;

@Mapper
public interface UserMapper {

	User getUser(HashMap<String, Object> map);

	int updatePwd(HashMap<String, Object> map);

	User selectUser(HashMap<String, Object> map);

	User selectNick(HashMap<String, Object> map);

	int insertUser(HashMap<String, Object> map);

	int updateInfo(HashMap<String, Object> map);

	void updateLastLogin(String userId);

	int updateWithdraw(HashMap<String, Object> map);



}
