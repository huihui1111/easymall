package cn.tedu.easymall.controller;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.tedu.easymall.exception.MsgException;
import cn.tedu.easymall.pojo.OrderInfo;
import cn.tedu.easymall.pojo.Products;
import cn.tedu.easymall.pojo.User;
import cn.tedu.easymall.service.OrderItemService;
import cn.tedu.easymall.service.OrderService;

@Controller
@RequestMapping("/pages/order/")
public class OrderController {

	@Resource
	private OrderService orderService;

	@Resource
	private OrderItemService orderItemService;

	@RequestMapping("addOrder")
	public String addOrder(HttpSession session) {
		Map<Products, Integer> cart = (Map<Products, Integer>) session.getAttribute("cart");

		String id = UUID.randomUUID().toString();

		User user = (User) session.getAttribute("user");

		orderService.addOrder(cart, id, user);
		orderItemService.addOrderItem(cart, id);

		return "redirect:/pages/order/list";
	}

	@RequestMapping("delete")
	public String deleteOrder(String id ) {
		orderService.delOrder(id);
		return "redirect:/pages/order/list";
	}

	@RequestMapping("list")
	public String findOrder(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		try {
			String uid = user.getId();
			List<OrderInfo> list = orderService.findAllOrderByUid(uid);
			model.addAttribute("list", list);
		} catch (MsgException e) {
			return "/logIO/login";
		}
		
		return "/order/orderList";
	}

}
