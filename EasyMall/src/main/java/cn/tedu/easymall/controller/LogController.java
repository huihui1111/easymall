package cn.tedu.easymall.controller;

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
	
	@RequestMapping("login")
	public String login(String username,String password,Model model,HttpSession session){
		User user = userService.findUserByUserNameAndPassword(username,password);

		//将user对象保存到session域中	
		if(user ==null){
			model.addAttribute("msg", "用户名或密码不正确");
			return "/logIO/login";			
		}
		session.setAttribute("user", user);
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
