package cn.tedu.easymall.mapper;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import cn.tedu.easymall.pojo.User;

public interface UserMapper {

	public void saveUser(User user);
	@Select("select * from user where username=#{username} and password=#{password}")
	public User findUserByUserNameAndPassword(@Param("username")String username, @Param("password")String password);
	@Select("select * from user where username=#{username}")
	public User findUserByUsername(String username);
}
