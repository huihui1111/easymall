package cn.tedu.easymall.service;

import java.util.List;
import java.util.Map;

import cn.tedu.easymall.pojo.OrderInfo;
import cn.tedu.easymall.pojo.Orders;
import cn.tedu.easymall.pojo.Products;
import cn.tedu.easymall.pojo.User;

public interface OrderService {

	public List<Orders> findOrders(String userId);

	public void addOrder(Map<Products, Integer> map, String id ,User user);

	public List<OrderInfo> findAllOrderByUid(String uid);

	public  void delOrder(String oId) ;


	
	
	
}
