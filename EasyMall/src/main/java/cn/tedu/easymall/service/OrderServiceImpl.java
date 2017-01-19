package cn.tedu.easymall.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.tedu.easymall.mapper.OrderMapper;
import cn.tedu.easymall.mapper.ProdMapper;
import cn.tedu.easymall.pojo.OrderInfo;
import cn.tedu.easymall.pojo.OrderItem;
import cn.tedu.easymall.pojo.Orders;
import cn.tedu.easymall.pojo.Products;
import cn.tedu.easymall.pojo.User;

@Service
public class OrderServiceImpl implements OrderService {

	@Resource
	private OrderMapper orderMapper;
	@Resource
	private ProdMapper prodMapper;

	@Override
	public List<Orders> findOrders(String userId) {

		return orderMapper.findOrder(userId);
	}

	@Override
	public void addOrder(Map<Products, Integer> map, String id, User user) {
		Orders orders = new Orders();
		orders.setPaystate(0);
		orders.setOrdertime(new Date());
		orders.setUser(user);

		int money = 0;
		for (Map.Entry<Products, Integer> entry : map.entrySet()) {
			money += entry.getValue() * entry.getKey().getPrice();
		}
		orders.setMoney(money);
		orders.setReceiverinfo("0");
		orders.setId(id);

		orderMapper.addOrder(orders);

	}

	@Override
	public List<OrderInfo> findAllOrderByUid(String uid) {

		List<OrderInfo> resultList = new ArrayList<OrderInfo>();
		// 1、根据用户id查询该用户所有的orders表中的订单信息
		List<Orders> orderList = orderMapper.findOrdersByUid(uid);
		// 2、判断当前用户是否有订单
		if (orderList != null) {// 该用户有订单
			List<OrderItem> itemList = orderMapper.findOrderItemsByUid(uid);
			// 3、遍历orderList
			for (Orders order : orderList) {
				OrderInfo oi = new OrderInfo();
				oi.setOrders(order);
				// 4、遍历itemList
				Map<Products, Integer> map = new HashMap<Products, Integer>();
				for (OrderItem item : itemList) {
					// 5、判断当前订单条目item,是否是order下的订单条目
					if (item.getOrderId().equals(order.getId())) {
						Products prod = prodMapper.findProdById(item.getProductId());
						map.put(prod, item.getBuynum());
					}
				}
				// 6、将map对象赋值给oi的map属性
				oi.setMap(map);
				resultList.add(oi);
			}
		}

		return resultList;
	}

	@Override
	public void delOrder(String oId) {

		//1、业务规则检验：只有未支付的订单，才可以被删除
		Orders order = orderMapper.findOrderByOid(oId);

		//2还原库存
		//2.1根据订单id查询所有的订单项的集合
		List<OrderItem> itemList = orderMapper.findOrderItemsByOid(oId);
		//2.2遍历itemList集合
		if(itemList!=null){
			for(OrderItem item : itemList){
			    /* //获取当前订单条目对应的商品信息
				  Product prod = prodDao.findProdById(item.getProduct_id());
				 //修改库存的方法
				  prodDao.updatePnum(item.getProduct_id(), prod.getPnum()+item.getBuynum());*/
				prodMapper.updatePnumAdd(item.getProductId(),item.getBuynum());
			}
			//3、删除订单项
			orderMapper.deleteOrderItemsByOid(oId);
		}
	    //4、删除订单
		orderMapper.deleteOrderById(oId);
	}
}
