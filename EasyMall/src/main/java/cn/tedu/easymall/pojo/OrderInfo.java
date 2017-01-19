package cn.tedu.easymall.pojo;

import java.util.List;
import java.util.Map;

public class OrderInfo {
	private Orders orders;
	private Map<Products, Integer> map;

	public Orders getOrders() {
		return orders;
	}

	public void setOrders(Orders order) {
		this.orders = order;
	}

	public Map<Products, Integer> getMap() {
		return map;
	}

	public void setMap(Map<Products, Integer> map) {
		this.map = map;
	}

}
