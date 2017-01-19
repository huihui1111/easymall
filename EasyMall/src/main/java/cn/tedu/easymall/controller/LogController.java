package cn.tedu.easymall.controller;

import java.net.URLEncoder;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.tedu.easymall.pojo.User;
import cn.tedu.easymall.service.UserService;

@Controller
@RequestMapping("/pages/logIO/")
public class LogController {
	@Resource 
	private UserService userService;
	
	@RequestMapping("tologin")
	public String toRegist(){
		return "/logIO/login";
	}
	
	/*@RequestMapping("login")
	public String login(String username,String password,Model model,HttpSession session){
		User user = userService.findUserByUserNameAndPassword(username,password);

		//将user对象保存到session域中	
		if(user ==null){
			model.addAttribute("msg", "用户名或密码不正确");
			return "/logIO/login";			
		}
		session.setAttribute("user", user);
		return "redirect:/home.action";
	}*/
	
	
	@RequestMapping("login")
	public String login(String username,String password,Model model,HttpSession session,
			String remname,String autologin,HttpServletRequest request,HttpServletResponse response) throws Exception{
		User user = userService.findUserByUserNameAndPassword(username,password);

		//将user对象保存到session域中	
		if(user ==null){
			model.addAttribute("msg", "用户名或密码不正确");
			return "/logIO/login";			
		}
		session.setAttribute("user", user);
		
		if("true".equals(remname)){
			//记住用户名
			//url编码  -- URLEncoder.encode("中国", "utf-8");
			//url解码 -- URLDecoder.decode("%E5%BC%A0%E9%A3%9E", "utf-8");
			Cookie cookie = new Cookie("remname", URLEncoder.encode(username, "utf-8"));
			cookie.setPath(request.getContextPath()+"/");
			cookie.setMaxAge(3600*24*30);
			response.addCookie(cookie);
		}else{
			//不记住用户名
			Cookie cookie = new Cookie("remname", "");
			cookie.setPath(request.getContextPath()+"/");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		/*//自动登陆
		if("true".equals(autologin)){
			Cookie cookie = new Cookie("autologin", URLEncoder.encode(username+":"+password, "utf-8"));
			cookie.setPath(request.getContextPath()+"/");
			cookie.setMaxAge(60*60*24*30);
			response.addCookie(cookie);
		}else{
			//删除自动登陆的Cookie(用户名和密码)
			
		}*/
		
		return "redirect:/home.action";
	}
	
	@RequestMapping("tologout")
	public String logout(HttpServletRequest request,HttpServletResponse response){
		if(request.getSession(false) != null){
			request.getSession().invalidate();
		}
		
		Cookie cookie = new Cookie("autologin", "");
		cookie.setPath(request.getContextPath()+"/");
		cookie.setMaxAge(0);
		response.addCookie(cookie);
		
		return "redirect:/home.action";
	}
	
	

}
