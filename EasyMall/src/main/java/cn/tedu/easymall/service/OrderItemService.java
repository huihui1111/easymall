package cn.tedu.easymall.service;

import java.util.Map;

import cn.tedu.easymall.pojo.Products;

public interface OrderItemService {

	public void addOrderItem(Map<Products, Integer> map, String id);

}
