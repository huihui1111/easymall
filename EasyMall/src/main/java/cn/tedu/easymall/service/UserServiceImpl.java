package cn.tedu.easymall.service;

import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.tedu.easymall.mapper.UserMapper;
import cn.tedu.easymall.pojo.User;
@Service
public class UserServiceImpl implements UserService{

	@Resource
	private UserMapper userMapper;
	@Override
	public void saveUser(User user) {
		user.setId(UUID.randomUUID().toString());
		userMapper.saveUser(user);
	}
	@Override
	public User findUserByUserNameAndPassword(String username, String password) {
		return userMapper.findUserByUserNameAndPassword(username,password);
	}
	@Override
	public User findUserByName(String username) {
		return userMapper.findUserByUsername(username);
	}

}
