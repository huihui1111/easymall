package cn.tedu.easymall.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.tedu.easymall.mapper.OrderItemMapper;
import cn.tedu.easymall.pojo.OrderItem;
import cn.tedu.easymall.pojo.Products;

@Service
public class OrderItemServiceImpl implements OrderItemService {

	@Resource
	private OrderItemMapper orderItemMapper;

	@Override
	public void addOrderItem(Map<Products, Integer> map, String id) {

		for (Map.Entry<Products, Integer> entry : map.entrySet()) {

			OrderItem oi = new OrderItem();

			oi.setOrderId(id);

			oi.setProductId(entry.getKey().getId());

			oi.setBuynum(entry.getValue());

			orderItemMapper.addOrderItem(oi);
		}

	}

}
