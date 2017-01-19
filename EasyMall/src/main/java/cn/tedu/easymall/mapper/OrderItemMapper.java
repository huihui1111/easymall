package cn.tedu.easymall.mapper;

import org.apache.ibatis.annotations.Insert;

import cn.tedu.easymall.pojo.OrderItem;

public interface OrderItemMapper {

	
	@Insert("insert into orderItem values(#{orderId},#{productId},#{buynum})")
	public void addOrderItem(OrderItem oi);

}
