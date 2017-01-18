package cn.tedu.easymall.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cn.tedu.easymall.pojo.Products;
import cn.tedu.easymall.service.ProdService;

@Controller
public class ProdController { 

	@Resource
	private ProdService prodService;
	
	@RequestMapping("findAllProd")
	public String allProd(Model model){
		List<Products> prodList = prodService.findAllProd();
		model.addAttribute("prodList", prodList);
		
		return "/allProd/prod_list";
	}
	
	@RequestMapping("findProdByCate")
	public String findProdByCate(Integer cate,Model model){
//		category=URLDecoder.decode(category);
		//1.手机数码,2.电脑平板,3.家用电器,4,汽车用品,5,食品饮料,6图书杂志,7.服装服饰,8.理财产品
		String category = "";
		switch (cate) {
		case 1:
			category="手机数码";
			break;
		case 2:
			category="电脑平板";
			break;
		case 3:
			category="家用电器";
			break;
		case 4:
			category="汽车用品";
			break;
		case 5:
			category="食品饮料";
			break;
		case 6:
			category="图书杂志";
			break;
		case 7:
			category="服装服饰";
			break;
		case 8:
			category="理财产品";
			break;
		}
		List<Products> prodList = prodService.findProdByCate(category);
		model.addAttribute("prodList", prodList);
		
		return "/allProd/prod_list";
	}
	
	@RequestMapping("selectProd")
	public String selectProd(String name,String category,double minprice , double maxprice,Model model){
		List<Products> prodList=prodService.findProdUseLimit(name,category,minprice,maxprice);
		model.addAttribute("prodList", prodList);
		return "/allProd/prod_list";
	}
	
	
	
	@RequestMapping("prodInfo")
	public String prodInfo(Model model,String prodId){
		Products product=prodService.findProdById(prodId);
		model.addAttribute("prod", product);
		return "/allProd/ProdInfo";
	}
}
