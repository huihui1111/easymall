package cn.tedu.easymall.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase.FileSizeLimitExceededException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.tedu.easymall.pojo.Products;
import cn.tedu.easymall.service.ProdService;

@Controller
@RequestMapping("/pages/back/")
public class BackProdController {

	@Resource
	private ProdService prodService;
	
	@RequestMapping("findAllProd")
	public String allProd(Model model){
		List<Products> prodList = prodService.findAllProd();
		model.addAttribute("prodList", prodList);
		return "/back/prod_list";
	}
	
	@RequestMapping("deletProd")
	public String deletProd(String[] prodId){
		prodService.deletProd(prodId);
		return "redirect:/pages/back/findAllProd";
	}
	
	@RequestMapping("updateProd")
	public String updateProd(String prodId,Model model){
		model.addAttribute("prod", prodService.findProdById(prodId));
		return "/back/prod_update";
	}
	
	@RequestMapping("update")
	public String update(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		//1、创建商品实体类的对象
				Products prod =new Products();
				//2、创建Map集合保存商品的相关信息
				Map<String,String> map = new HashMap<String,String>();
				//3处理文件上传：
				//3.2创建DiskFileItemFactory对象，并配置相关属性
				//3.2.1创建对象
				DiskFileItemFactory factory = new DiskFileItemFactory();
				//3.2.2设置缓存区的大小
				factory.setSizeThreshold(200*1024);//200KB
				//3.2.3设置临时文件的位置  在WEB-INF目录下新建一个tmp文件夹
				factory.setRepository(new File(request.
						getRealPath("/WEB-INF/pages/tmp")));
				//3.3、ServletFileUpload类的相关操作
				//3.3.1创建ServletFileUpload类对象
				ServletFileUpload fileUpload = new ServletFileUpload(factory);
				//3.3.2处理上传文件名中文乱码的问题
				fileUpload.setHeaderEncoding("utf-8");
				//3.3.3设置上传文件单个大小
				fileUpload.setFileSizeMax(20*1024*1024);//2M
				//3.4设置form文件总大小的限制
				//fileUpload.setSizeMax(2*1024*1024);//2M
				//3.3.5获取所有的输入项
				try {
					List<FileItem> list = fileUpload.parseRequest(request);
					//3.4、遍历list集合
					for(FileItem item :list){
						//3.4.1判断是否为普通表单项目
						if(item.isFormField()){//普通的表单项
							map.put(item.getFieldName(),item.getString("utf-8"));
						}else{//3.4.2文件上传表单项
							//3.5、获取文件名
							String fileName = item.getName();
							//3.5.1解决部分版本的浏览器：文件名中包含本地路径的bug
							if(fileName.indexOf("\\")!=-1){
								fileName.substring(fileName.lastIndexOf("\\")+1);
							}
							//3.5.2防止重名
							fileName = UUID.randomUUID().toString()+"_"+fileName;
							//63.处理保存目录
							String path = "/WEB-INF/pages/upload/";
							String hash = Integer.toHexString(fileName.hashCode());
							char[] chs = hash.toCharArray();
							for (int i = 0; i < chs.length; i++) {
								path=path +"/"+chs[i];
							}//  /WEB-INF/upload/a/e/9/0/a/1.jpg
							//3.7、创建目录
							new File(request.getRealPath(path)).mkdirs();
							//3.8、文件的IO操作
							InputStream in = item.getInputStream();
							OutputStream out = new FileOutputStream(new File(
									request.getRealPath(path+"/"+fileName)));
							int len = -1;
							byte bts[] = new byte[1024];
							while((len=in.read(bts))!=-1){
								out.write(bts, 0, len);
							}
							//3.9、关闭流
							out.close();
							in.close();
							//3.10、将临时文件删除
							item.delete();
							//3.11、将上传表单项相关信息保存map中
							map.put(item.getFieldName(), path+"/"+fileName);
						}
					}
					//4、从map中获取信息保存到prod,并通过调用业务层的方法，
					//将商品信息添加到数据库中
					//4.1将map中信息保存到prod对象中
					BeanUtils.populate(prod, map);
					//4.2声明并创建业务层的对象
					prodService.update(prod);
					
					return "redirect:/pages/back/findAllProd";
				} catch (FileSizeLimitExceededException e) {
					e.printStackTrace();
					/*response.getWriter().write("商品添加失败，3秒后自动跳转，如果不跳转请<a href='"
							+request.getContextPath()+"/back/manageAddProd.jsp'>点击此处</a>");
					response.setHeader("Refresh", "3;url="+request.getContextPath()+"/back/manageAddProd.jsp");*/
					request.setAttribute("msg", "商品添加失败，上传文件过大");
					request.getRequestDispatcher("/back/manageAddProd.jsp").forward(request, response);
				}catch (Exception e) {
					e.printStackTrace();
					throw new RuntimeException(e);
				} 
				return null;
	}
	
	
	@RequestMapping("addProd")
	public String addProd(){
		return "/back/prod_add";
	}
	
	@RequestMapping("prodSave")
	public String prodSave(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		//1、创建商品实体类的对象
		
		String name=request.getParameter("name");
		//1、创建商品实体类的对象
		Products prod =new Products();
		//2、创建Map集合保存商品的相关信息
		Map<String,String> map = new HashMap<String,String>();
		map.put("id", UUID.randomUUID().toString());
		//3处理文件上传：
		//3.2创建DiskFileItemFactory对象，并配置相关属性
		//3.2.1创建对象
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//3.2.2设置缓存区的大小
		factory.setSizeThreshold(200*1024);//200KB
		//3.2.3设置临时文件的位置  在WEB-INF目录下新建一个tmp文件夹
		factory.setRepository(new File(request.
				getRealPath("/WEB-INF/pages/tmp")));
		//3.3、ServletFileUpload类的相关操作
		//3.3.1创建ServletFileUpload类对象
		ServletFileUpload fileUpload = new ServletFileUpload(factory);
		//3.3.2处理上传文件名中文乱码的问题
		fileUpload.setHeaderEncoding("utf-8");
		//3.3.3设置上传文件单个大小
		fileUpload.setFileSizeMax(20*1024*1024);//2M
		//3.4设置form文件总大小的限制
		//fileUpload.setSizeMax(2*1024*1024);//2M
		//3.3.5获取所有的输入项
		try {
			List<FileItem> list = fileUpload.parseRequest(request);
			//3.4、遍历list集合
			for(FileItem item :list){
				//3.4.1判断是否为普通表单项目
				if(item.isFormField()){//普通的表单项
					map.put(item.getFieldName(),item.getString("utf-8"));
				}else{//3.4.2文件上传表单项
					//3.5、获取文件名
					String fileName = item.getName();
					//3.5.1解决部分版本的浏览器：文件名中包含本地路径的bug
					if(fileName.indexOf("\\")!=-1){
						fileName.substring(fileName.lastIndexOf("\\")+1);
					}
					//3.5.2防止重名
					fileName = UUID.randomUUID().toString()+"_"+fileName;
					//63.处理保存目录
					String path = "/WEB-INF/pages/upload/";
					String hash = Integer.toHexString(fileName.hashCode());
					char[] chs = hash.toCharArray();
					for (int i = 0; i < chs.length; i++) {
						path=path +"/"+chs[i];
					}//  /WEB-INF/upload/a/e/9/0/a/1.jpg
					//3.7、创建目录
					new File(request.getRealPath(path)).mkdirs();
					//3.8、文件的IO操作
					InputStream in = item.getInputStream();
					OutputStream out = new FileOutputStream(new File(
							request.getRealPath(path+"/"+fileName)));
					int len = -1;
					byte bts[] = new byte[1024];
					while((len=in.read(bts))!=-1){
						out.write(bts, 0, len);
					}
					//3.9、关闭流
					out.close();
					in.close();
					//3.10、将临时文件删除
					item.delete();
					//3.11、将上传表单项相关信息保存map中
					map.put(item.getFieldName(), path+"/"+fileName);
				}
			}
			//4、从map中获取信息保存到prod,并通过调用业务层的方法，
			//将商品信息添加到数据库中
			//4.1将map中信息保存到prod对象中
			BeanUtils.populate(prod, map);
			//4.2声明并创建业务层的对象
			prodService.saveProd(prod);
			
			return "redirect:/pages/back/findAllProd";
		} catch (FileSizeLimitExceededException e) {
			e.printStackTrace();
			/*response.getWriter().write("商品添加失败，3秒后自动跳转，如果不跳转请<a href='"
					+request.getContextPath()+"/back/manageAddProd.jsp'>点击此处</a>");
			response.setHeader("Refresh", "3;url="+request.getContextPath()+"/back/manageAddProd.jsp");*/
			request.setAttribute("msg", "商品添加失败，上传文件过大");
			request.getRequestDispatcher("/back/manageAddProd.jsp").forward(request, response);
		}catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} 
		return null;
	}
}
