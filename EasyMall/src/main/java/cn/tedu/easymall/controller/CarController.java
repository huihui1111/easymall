package cn.tedu.easymall.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.tedu.easymall.pojo.Products;
import cn.tedu.easymall.service.CartService;
import cn.tedu.easymall.service.ProdService;

@Controller
@RequestMapping("/pages/cart/")
public class CarController {
	@Resource
	private CartService cartService;
	@Resource
	private ProdService prodService;

	@RequestMapping("toCart")
	public String toCart(){
		return "/cart/cart";
	}
	
// zeng
	@RequestMapping("addCart")
	public String addCart(HttpServletRequest request, Model model, String prodId, HttpSession session) {

		Products product=null;
		Map<Products, Integer> cart = (Map<Products, Integer>) request.getSession(true).getAttribute("cart");
		if(cart==null){
			cart=new HashMap<Products,Integer>();
		}
		Set<Products> keySet = cart.keySet();
		for (Products prod : keySet) {
			while(prod.getId().equals(prodId)){
				product=prod;
				break;
			}
		}
		if(product==null){
			product=prodService.findProdById(prodId);
		}
		int buyNum = cart.containsKey(product) ? cart.get(product) + 1 : 1;
		cart.put(product, buyNum);
		session.setAttribute("cart", cart);
		return "/cart/cart";
	}
	// shan
	@RequestMapping("delete")
	public String delete(String prodId, HttpSession session) {
		Map<Products, Integer> cart = (Map<Products, Integer>) session.getAttribute("cart");
		Set<Products> keySet = cart.keySet();
		for (Products product : keySet) {
			while(product.getId().equals(prodId)){
				cart.remove(product);
				break;
			}
		}
		session.setAttribute("cart", cart);
		return "/cart/cart";
	}

	@RequestMapping("update")
	public String update(String id, int newBuyNum, HttpSession session) {
		Map<Products, Integer> map = (Map<Products, Integer>) session.getAttribute("map");
		Products prod = new Products();
		prod.setId(id);
		map.put(prod, newBuyNum);
		return "/cart/cart";
	}
}
