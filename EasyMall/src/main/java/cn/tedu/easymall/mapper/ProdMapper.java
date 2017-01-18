package cn.tedu.easymall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import cn.tedu.easymall.pojo.Products;

public interface ProdMapper {

	@Select("select * from products")
	public List<Products> findAllProd();

	public List<Products> findProdUseLimit(@Param("name") String name, @Param("category") String category,
			@Param("minprice") double minprice, @Param("maxprice") double maxprice);
	@Select("SELECT * FROM products WHERE id=#{prodId}")
	public Products findProdById(String prodId);
	@Select("select * from products where category=#{category}")
	public List<Products> findProdByCate(String category);
	@Delete("delete from products where id=#{prodId}")
	public void deletProd(String prodId);
	@Insert("insert into products values(#{id},#{name},#{price},#{category},#{pnum},#{imgurl},#{desc})")
	public void saveProd(Products prod);

	public void update(Products prod);

}
