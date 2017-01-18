package cn.tedu.easymall.service;

import cn.tedu.easymall.pojo.User;

public interface UserService {

	void saveUser(User user);

	User findUserByUserNameAndPassword(String username, String password);

	User findUserByName(String username);
	
	

}
