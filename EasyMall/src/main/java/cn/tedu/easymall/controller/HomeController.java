package cn.tedu.easymall.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping("/home")
	public String home(){
		return "/home/fmain";
	}
	
	@RequestMapping("head")
	public String head(){
		return "/home/_head";
	}
	
	@RequestMapping("body")
	public String body(){
		return "/home/_body";
	}
	
	@RequestMapping("foot")
	public String foot(){
		return "/home/_foot";
	}
}
