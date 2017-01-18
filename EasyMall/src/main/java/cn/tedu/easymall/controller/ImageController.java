package cn.tedu.easymall.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ImageController {

	@RequestMapping("showImg")
	public String showImg(HttpServletRequest request,HttpServletResponse response, String imgurl) throws ServletException, IOException{
		request.getRequestDispatcher(imgurl).forward(request, response);
		return null;
	}
}
