package cn.tedu.easymall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import cn.tedu.easymall.pojo.OrderItem;
import cn.tedu.easymall.pojo.Orders;

public interface OrderMapper {
	@Select("select * from orders where user_id=#{userId}")
	List<Orders> findOrder(String id);

	public void addOrder(Orders orders);

	public List<Orders> findOrdersByUid(String uid);

	public List<OrderItem> findOrderItemsByUid(String uid);

	@Select("select * from OrderItem where order_id=#{orderId}")
	public List<OrderItem> findOrderItemsByOid(String oId);

	@Select("select * from orders where id=#{oid}")
	public Orders findOrderByOid(String oId);

	@Delete("delete from orderitem where order_id = #{oId}")
	public void deleteOrderItemsByOid(String oId);

	@Delete("delete from orders where id =#{oId}")
	public void deleteOrderById(String oId);

}
