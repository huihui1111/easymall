package cn.tedu.easymall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/pages/back/")
public class ManagerController {

	@RequestMapping("toBack")
	public String toBack(){
		return "/back/manage";
	}
	
	@RequestMapping("_left")
	public String _left(){
		return "/back/_left";
	}
	
	@RequestMapping("_right")
	public String _right(){
		return "/back/_right";
	}
	
	@RequestMapping("_top")
	public String _top(){
		return "/back/_top";
	}
	
}
