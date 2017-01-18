package cn.tedu.easymall.controller;

import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.tedu.easymall.pojo.User;
import cn.tedu.easymall.service.UserService;
import cn.tedu.easymall.tool.VerifyCode;

@Controller
@RequestMapping("/pages/logIO/")
public class registController {

	@Resource
	private UserService userSerive;

	@RequestMapping("toregist")
	public String toRegist(Model model) {
		return "/logIO/regist";
	}

	// 用户信息注册
	@RequestMapping("/save")
	public String saveUser(User user, String password2, Model model) {
		String password = user.getPassword();
		if (password == null || password2 == null || !password.equals(password2)) {
			model.addAttribute("msg", "两次密码不一致");
			return "/regist";
		}
		user.checkData();
		userSerive.saveUser(user);
		return "redirect:/home.action";
	}

	@RequestMapping("/AjaxCheckUserName")
	public String checkUser(String username, Model model, HttpServletResponse response) throws IOException {
		User user = userSerive.findUserByName(username);
		if (user == null) {
			response.getWriter().write("true");
		}

		return "/regist";

	}
}
